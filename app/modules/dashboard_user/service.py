from flask import request, render_template, redirect, url_for, flash, session

from app.database.connection_db_v2 import db

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

def _form_opciones_acudiente(form):
    """Asigna choices a los SelectFields del formulario del acudiente."""
    estratos = sp_obtener_estratos()
    generos = sp_obtener_generos()
    grupos_pref = sp_obtener_grupos_preferenciales()
    barrios = sp_obtener_barrios()

    form.estrato.choices = (
        [(0, "— Seleccione un Estrato —")] +
        [(e["ID_Estrato"], e["Numero_Estrato"]) for e in estratos]
    )
    form.genero.choices = (
        [(0, "— Seleccione un Género —")] +
        [(g["ID_Genero"], g["Nombre_Genero"]) for g in generos]
    )
    form.grupo_preferencial.choices = (
        [(0, "— Seleccione un Grupo —")] +
        [(gp["ID_Grupo_Preferencial"], gp["Nombre_Grupo_Preferencial"]) for gp in grupos_pref]
    )
    form.barrio.choices = (
        [(0, "— Seleccione un Barrio —")] +
        [(b["ID_Barrio"], b["Nombre_Barrio"]) for b in barrios]
    )

def _form_opciones_estudiante(form):
    """Asigna choices a todos los SelectFields del formulario del estudiante."""
    
    generos = sp_obtener_generos()
    grupos_preferenciales = sp_obtener_grupos_preferenciales()
    grados = sp_obtener_grados()
    colegios = sp_obtener_colegios()
    
    
    form.genero.choices = (
        [(0, "— Seleccione un Genero —")] +
        [(g["ID_Genero"], g["Nombre_Genero"]) for g in generos]
    )
    form.grupo_preferencial.choices = (
        [(0, "— Seleccione un Grupo —")] +
        [(gp["ID_Grupo_Preferencial"], gp["Nombre_Grupo_Preferencial"]) for gp in grupos_preferenciales]
    )
    form.grado_actual.choices = (
        [(0, "— Seleccione un grado —")] +
        [(gr["ID_Grado"], gr["Nombre_Grado"]) for gr in grados]
    )
    form.grado_proximo.choices = (
        [(0, "— Seleccione un grado —")] +
        [(gr["ID_Grado"], gr["Nombre_Grado"]) for gr in grados]
    )    
    form.colegio_anterior.choices = (
        [(0, "— Seleccione un Colegio —")] +
        [(c["ID_Colegio"], c["Nombre_Colegio"]) for c in colegios]
    )
    
#  PROFILE — Acudiente
class Profile:

    def cargar_perfil(self):
        """
        Carga y pre-pobla ambos formularios con los datos actuales del acudiente
        y del estudiante vinculado. Retorna el contexto listo para render_template.
        """
        # ── Formularios
        form_acu_fijos = FormAcudienteDatosPersonales()
        form_acu_edit = FormAcudienteDatosEditables()
        form_est = FormEstudianteDatosEditables()

        _form_opciones_acudiente(form_acu_edit)
        _form_opciones_estudiante(form_est)

        user_id = session["user_id"]
        if not user_id:
            flash("No se encontró sesión de usuario activa.", "danger")
            return redirect(url_for("dashboard.dashboard_home"))

        if request.method == "POST":
            form_type = request.form.get("form_type", "").strip().lower()

            if form_type == "acudiente":
                if self.actualizar_acudiente():
                    return redirect(url_for("dashboard.dashboard_profile"))
            elif form_type == "estudiante":
                if self.actualizar_estudiante():
                    return redirect(url_for("dashboard.dashboard_profile"))
            else:
                flash("Tipo de formulario no reconocido.", "danger")
                
        # ── Datos desde BD
        datos_acu_fijos = sp_obtener_perfil_acudiente(user_id)
        datos_acu = sp_obtener_perfil_acudiente(user_id)
        datos_est = sp_obtener_perfil_estudiante(user_id)
        
        
        if datos_acu_fijos:
            form_acu_fijos.primer_nombre.data = datos_acu_fijos.get("Primer_Nombre")
            form_acu_fijos.segundo_nombre.data = datos_acu_fijos.get("Segundo_Nombre")
            form_acu_fijos.primer_apellido.data = datos_acu_fijos.get("Primer_Apellido")
            form_acu_fijos.segundo_apellido.data = datos_acu_fijos.get("Segundo_Apellido")        
            form_acu_fijos.tipo_identificacion.data = datos_acu_fijos.get("Nombre_Tipo_Iden")
            form_acu_fijos.numero_documento.data = datos_acu_fijos.get("Numero_Documento")
            form_acu_fijos.parentesco.data = datos_acu_fijos.get("Nombre_Parentesco")
            form_acu_fijos.email.data = datos_acu_fijos.get("Email")

            fecha = datos_acu_fijos.get("Fecha_Creacion")
            if fecha:
                fecha_formateada = fecha.strftime("%d/%m/%Y %H:%M")
            else:
                fecha_formateada = None
            form_acu_fijos.fecha_creacion.data = fecha_formateada
            
        # ── Pre-poblar acudiente
        if datos_acu:
            form_acu_edit.telefono.data = datos_acu.get("Telefono")
            form_acu_edit.barrio.data = datos_acu.get("ID_Barrio", 0)
            form_acu_edit.genero.data = datos_acu.get("ID_Genero", 0)
            form_acu_edit.grupo_preferencial.data = datos_acu.get("ID_Grupo_Preferencial", 0)
            form_acu_edit.estrato.data = datos_acu.get("ID_Estrato", 0)

        # ── Pre-poblar estudiante
        if datos_est:
            form_est.primer_nombre.data = datos_est.get("Primer_Nombre")
            form_est.segundo_nombre.data = datos_est.get("Segundo_Nombre")
            form_est.primer_apellido.data = datos_est.get("Primer_Apellido")
            form_est.segundo_apellido.data = datos_est.get("Segundo_Apellido")
            form_est.fecha_nacimiento.data = datos_est.get("Fecha_Nacimiento")
            form_est.genero.data = datos_est.get("ID_Genero", 0)
            form_est.grupo_preferencial.data = datos_est.get("ID_Grupo_Preferencial", 0)
            form_est.grado_actual.data = datos_est.get("ID_Grado_Actual", 0)
            form_est.grado_proximo.data = datos_est.get("ID_Grado_Proximo", 0)
            form_est.colegio_anterior.data = datos_est.get("ID_Colegio_Anterior", 0)
            
        return render_template(
            "dashboard_users/profile.html",
            form_acu_fijos=form_acu_fijos,
            form_acu=form_acu_edit,
            form_est=form_est,
            datos_acu_fijos=datos_acu_fijos,
            datos_acu=datos_acu,
            datos_est=datos_est,
            active_page="profile",
        )

    # ── Guardar acudiente ─────────────────────────────────────────────────────

    def actualizar_acudiente(self):
        form = FormAcudienteDatosEditables()
        _form_opciones_acudiente(form)

        if not form.validate_on_submit():
            print("FORM ERRORS:", form.errors)
            flash("Por favor revise los campos del formulario del acudiente.", "danger")
            return False

        user_id = session.get("user_id")
        if not user_id:
            flash("No se encontró sesión de usuario activa.", "danger")
            return False
        
        datos_acu = sp_obtener_perfil_acudiente(user_id)
        if not datos_acu:
            flash("No se encontró el perfil del acudiente.", "danger")
            return False
                
        persona_id = datos_acu.get("Numero_Documento") or datos_acu.get("ID_Persona")
        if not persona_id:
            flash("No se pudo obtener el ID de persona del acudiente.", "danger")
            return False
         
        datos_id = datos_acu.get("ID_Datos_Adicionales") or f"D{persona_id}"
        
        try:
            sp_actualizar_datos_adicionales((
                datos_id,
                form.telefono.data,
                persona_id,
                form.genero.data,
                form.grupo_preferencial.data,
                form.estrato.data,  
                form.barrio.data,
            ))
                        
            db.commit()
            
            flash("Datos del acudiente actualizados correctamente.", "success")
            return True

        except Exception as e:
            db.rollback()
            print(f"[ERROR] Actualización acudiente fallida: {e}")
            flash("Ocurrió un error al guardar los cambios.", "danger")
            return False

    # Guardar estudiante 
    def actualizar_estudiante(self):
        form = FormEstudianteDatosEditables()
        _form_opciones_estudiante(form)

        if not form.validate_on_submit():
            flash("Por favor revise los campos del formulario del menor.", "danger")
            return False

        user_id = session.get("user_id")
        if not user_id:
            flash("No se encontró sesión de usuario activa.", "danger")
            return False

        datos_est = sp_obtener_perfil_estudiante(user_id)
        if not datos_est:
            flash("No se encontró el estudiante vinculado.", "danger")
            return False

        id_persona_est = datos_est["ID_Persona"]
        
        print(
            form.primer_nombre.data,
            form.segundo_nombre.data or None,
            form.primer_apellido.data,
            form.segundo_apellido.data or None,
            form.fecha_nacimiento.data,
            id_persona_est,
        )
        
        try:
            # 1. Actualizar TBL_PERSONA del menor
            sp_actualizar_persona((
                id_persona_est,
                form.primer_nombre.data,
                form.segundo_nombre.data or None,
                form.primer_apellido.data,
                form.segundo_apellido.data or None,
                form.fecha_nacimiento.data,
            ))

            # 2. Actualizar TBL_ESTUDIANTE
            sp_actualizar_estudiante((
                form.grado_actual.data,
                form.grado_proximo.data,
                form.colegio_anterior.data,
                form.genero.data,
                form.grupo_preferencial.data,
                id_persona_est,
            ))

            db.commit()
            flash("Datos del estudiante actualizados correctamente.", "success")
            return True

        except Exception as e:
            db.rollback()
            print(f"[ERROR] Actualización estudiante fallida: {e}")
            flash("Ocurrió un error al guardar los cambios.", "danger")
            return False


def _form_opciones_estudiante_register(form):
    """Asigna choices a todos los SelectFields del formulario del estudiante."""
    
    generos = sp_obtener_generos()
    grupos_preferenciales = sp_obtener_grupos_preferenciales()
    grados = sp_obtener_grados()
    colegios = sp_obtener_colegios()
    tipos_identificacion = sp_obtener_tipos_identificacion()
    parentesco_estudiante = sp_obtener_parentesco_est()
    
    
    form.genero.choices = (
        [(0, "— Seleccione un Genero —")] +
        [(g["ID_Genero"], g["Nombre_Genero"]) for g in generos]
    )
    form.grupo_preferencial.choices = (
        [(0, "— Seleccione un Grupo —")] +
        [(gp["ID_Grupo_Preferencial"], gp["Nombre_Grupo_Preferencial"]) for gp in grupos_preferenciales]
    )
    form.grado_actual.choices = (
        [(0, "— Seleccione un grado —")] +
        [(gr["ID_Grado"], gr["Nombre_Grado"]) for gr in grados]
    )
    form.grado_proximo.choices = (
        [(0, "— Seleccione un grado —")] +
        [(gr["ID_Grado"], gr["Nombre_Grado"]) for gr in grados]
    )    
    form.colegio_anterior.choices = (
        [(0, "— Seleccione un Colegio —")] +
        [(c["ID_Colegio"], c["Nombre_Colegio"]) for c in colegios]
    )
    form.tipo_identificacion.choices = (
        [(0, "— Seleccione una Identificación —")] +
        [(t["ID_Tipo_Iden"], t["Nombre_Tipo_Iden"]) for t in tipos_identificacion]
    )
    form.parentesco.choices = (
        [(0, "— Seleccione un Parentesco —")] +
        [(p["ID_Parentesco"], p["Nombre_Parentesco"]) for p in parentesco_estudiante]
    )

#  REGISTER — Nuevo Estudiante
class RegisterEstudiante:

    def registrar(self):
        """
        Maneja GET y POST del formulario de registro del estudiante.
        ID_Estudiante = 'E' + ID_Persona del menor (VARCHAR 16).
        """

        form = FormRegistroEstudiante()
        _form_opciones_estudiante_register(form)

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
                "dashboard_user/register_student.html",
                form=form,
            )

        # Construir IDs compuestos
        id_persona_estudiante = form.numero_documento.data
        id_estudiante = f"E{id_persona_estudiante}"

        id_persona = session["user_id"]
        
        try:
            # Verificar que el estudiante no esté ya registrado
            ya_existe = sp_estudiante_existe(id_estudiante, id_persona)
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