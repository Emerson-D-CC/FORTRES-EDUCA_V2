from flask import request, render_template, redirect, url_for, flash, session

from app.database.connection_db_v2 import db

# from app.security.recaptcha import validar_recaptcha

from .models import *
from .forms import *


class DashboardHome:
    """
    El decorador @estudiante_requerido ya garantiza que si
    se llega aquí, el estudiante existe. Solo renderiza.
    """
    def index(self):
        return render_template(
            "dashboard_users/index.html",
            active_page="home",
        )


#  HELPERS INTERNOS
def _poblar_form_estudiante(form):
    """Asigna choices a todos los SelectFields del formulario del estudiante."""
    
    generos = sp_obtener_generos()
    grupos_preferenciales = sp_obtener_grupos_preferenciales()
    grados = sp_obtener_grados()
    colegios = sp_obtener_colegios()
    tipos_identificacion = sp_obtener_tipos_identificacion()
    
    
    form.genero.choices = [
        (g["ID_Genero"], g["Nombre_Genero"]) for g in generos
    ]
    form.grupo_preferencial.choices = [
        (gp["ID_Grupo_Preferencial"], gp["Nombre_Grupo_Preferencial"]) for gp in grupos_preferenciales
    ]
    form.grado_actual.choices = [
        (gr["ID_Grado"], gr["Nombre_Grado"]) for gr in grados
    ]
    form.grado_proximo.choices = [
        (gr["ID_Grado"], gr["Nombre_Grado"]) for gr in grados
    ]
    form.colegio_anterior.choices = [
        (c["ID_Colegio"], c["Nombre_Colegio"]) for c in colegios
    ]
    form.tipo_identificacion.choices = [
        (t["ID_Tipo_Iden"], t["Nombre_Tipo_Iden"]) for t in tipos_identificacion
    ]

#  PROFILE — Acudiente
class Profile:

    def actualizar_acudiente(self, user):
        """
        Actualiza email, teléfono, género, grupo preferencial y estrato
        del acudiente en TBL_DATOS_ADICIONALES.
        Los datos de identidad (nombre, documento) no se modifican aquí.
        """
        catalogos = {
            "estratos": sp_obtener_estratos(),
            "generos": sp_obtener_generos(),
            "grupos_preferenciales": sp_obtener_grupos_preferenciales(),
        }

        form = FormAcudienteDatosEditables()
        form.estrato.choices = [
            (e["ID_Estrato"], e["Nombre_Estrato"]) for e in catalogos["estratos"]
        ]
        form.genero.choices = [
            (g["ID_Genero"], g["Nombre_Genero"]) for g in catalogos["generos"]
        ]
        form.grupo_preferencial.choices = [
            (gp["ID_Grupo_Preferencial"], gp["Nombre_Grupo"])
            for gp in catalogos["grupos_preferenciales"]
        ]

        if not form.validate_on_submit():
            flash("Por favor revise los campos del formulario.", "danger")
            return False

        datos_id  = f"D{user.id_persona}"

        try:
            sp_actualizar_datos_adicionales((
                datos_id,
                form.email.data,
                form.telefono.data,
                user.fk_tipo_iden,
                user.id_persona,
                form.genero.data,
                form.grupo_preferencial.data,
                form.estrato.data,
                user.fk_localidad,
            ))
            db.commit()
            flash("Datos del acudiente actualizados correctamente.", "success")
            return True

        except Exception as e:
            db.rollback()
            print(f"[ERROR] Actualización acudiente fallida: {e}")
            flash("Ocurrió un error al guardar los cambios.", "danger")
            return False

    def actualizar_estudiante(self, user):
        """
        Actualiza TBL_PERSONA y TBL_ESTUDIANTE del menor.
        El tipo de identificación no es modificable desde el perfil.
        """
        form = FormEstudianteDatosEditables()
        _poblar_form_estudiante(form)

        if not form.validate_on_submit():
            flash("Por favor revise los campos del formulario del menor.", "danger")
            return False


        try:
            # 1. Actualizar TBL_PERSONA del menor
            sp_actualizar_persona((
                form.primer_nombre.data,
                form.segundo_nombre.data or None,
                form.primer_apellido.data,
                form.segundo_apellido.data or None,
                form.fecha_nacimiento.data,
            ))

            # 2. Actualizar TBL_ESTUDIANTE
            sp_actualizar_estudiante((
                form.tipo_identificacion.data,
                form.grado_actual.data,
                form.grado_proximo.data,
                form.colegio_anterior.data,
                form.genero.data,
                form.grupo_preferencial.data,
            ))

            db.commit()
            flash("Datos del estudiante actualizados correctamente.", "success")
            return True

        except Exception as e:
            db.rollback()
            print(f"[ERROR] Actualización estudiante fallida: {e}")
            flash("Ocurrió un error al guardar los cambios.", "danger")
            return False


#  REGISTER — Nuevo Estudiante
class RegisterEstudiante:

    def registrar(self):
        """
        Maneja GET y POST del formulario de registro del estudiante.
        ID_Estudiante = 'E' + ID_Persona del menor (VARCHAR 16).
        """

        form = FormRegistroEstudiante()
        _poblar_form_estudiante(form)

        if request.method == "GET":
            return render_template(
                "dashboard_users/register_student.html",
                form=form,
            )

        # ----- POST -----
        if not form.validate_on_submit():
            errores = "; ".join(
                f"{field}: {', '.join(msgs)}"
                for field, msgs in form.errors.items()
            )
            print(f"Errores en el formulario: {errores}")
            flash("Por favor revise los campos del formulario.", "danger")
            return render_template(
                "dashboard/register_student.html",
                form=form,
            )

        # Construir IDs compuestos
        id_persona_estudiante = form.numero_documento.data
        id_estudiante = f"E{id_persona_estudiante}"

        id_persona = session["user_id"]
        
        try:
            # Verificar que el estudiante no esté ya registrado
            ya_existe = sp_estudiante_existe(id_estudiante)
            if ya_existe:
                flash("Este estudiante ya se encuentra registrado.", "warning")
                return render_template(
                    "dashboard_user/register_student.html",
                    form=form,
                )

            # 1. Insertar TBL_PERSONA del menor
            sp_insertar_persona((
                id_persona_estudiante,
                form.primer_nombre.data,
                form.segundo_nombre.data or None,
                form.primer_apellido.data,
                form.segundo_apellido.data or None,
                form.fecha_nacimiento.data,
            ))

            # 2. Insertar TBL_ESTUDIANTE
            sp_insertar_estudiante((
                id_estudiante,              # ID compuesto: E + ID_Persona
                form.tipo_identificacion.data,
                id_persona_estudiante,
                form.grado_actual.data,
                form.grado_proximo.data,
                form.colegio_anterior.data,
                form.genero.data,
                form.grupo_preferencial.data,
                id_persona,            # FK_ID_Acudiente: persona del usuario en sesión
                form.parentesco.data,
            ))

            db.commit()
            
            session["estudiante_verificado"] = True
            flash("Estudiante registrado correctamente.", "success")
            return redirect(url_for("dashboard.dashboard_home"))

        except Exception as e:
            db.rollback()
            print(f"[ERROR] Registro de estudiante fallido: {e}")
            flash("Ocurrió un error al registrar al estudiante. Intente nuevamente.", "danger")
            return render_template(
                "dashboard_user/register_student.html",
                form=form,
            )