document.addEventListener('DOMContentLoaded', function () {
    console.log('Fortress System - Frontend Initialized');

    const registroForm = document.getElementById('formRegistroAcudiente');

    if (registroForm) {

        // --- FEEDBACK EN TIEMPO REAL (sin cambios funcionales) ---
        const passwordInput = document.getElementById('password');
        const confirmInput  = document.getElementById('confirmPassword');
        const complexityMsg = document.getElementById('pwd-complexity-msg');
        const matchMsg      = document.getElementById('pwd-match-msg');
        const mismatchMsg   = document.getElementById('pwd-mismatch-msg');

        const feedbackRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{12,}$/;

        passwordInput.addEventListener('input', function () {
            if (feedbackRegex.test(this.value)) {
                complexityMsg.style.display = 'block';
                this.classList.add('is-valid');
                this.classList.remove('is-invalid');
            } else {
                complexityMsg.style.display = 'none';
                this.classList.remove('is-valid');
            }
            if (confirmInput.value) checkMatch();
        });

        confirmInput.addEventListener('input', checkMatch);
        confirmInput.addEventListener('keyup', checkMatch);

        function checkMatch() {
            const val = confirmInput.value;
            const pwd = passwordInput.value;

            if (!val) {
                matchMsg.style.display    = 'none';
                mismatchMsg.style.display = 'none';
                confirmInput.classList.remove('is-valid', 'is-invalid');
                return;
            }

            if (val === pwd) {
                matchMsg.style.display    = 'block';
                mismatchMsg.style.display = 'none';
                confirmInput.classList.add('is-valid');
                confirmInput.classList.remove('is-invalid');
            } else {
                matchMsg.style.display    = 'none';
                mismatchMsg.style.display = 'block';
                confirmInput.classList.remove('is-valid');
                confirmInput.classList.add('is-invalid');
            }
        }
        // --- FIN FEEDBACK ---

        registroForm.addEventListener('submit', function (e) {

            // Validación nativa del navegador
            if (!registroForm.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
                registroForm.classList.add('was-validated');
                return;
            }

            // --- VALIDACIONES PERSONALIZADAS ---
            const password       = document.getElementById('password').value;
            const confirmPassword= document.getElementById('confirmPassword').value;
            const primerNombre   = document.getElementById('primerNombre').value.toLowerCase();
            const primerApellido = document.getElementById('primerApellido').value.toLowerCase();
            const documento      = document.getElementById('documento').value;

            if (password !== confirmPassword) {
                alert('Las contraseñas no coinciden.');
                document.getElementById('confirmPassword').focus();
                e.preventDefault();
                return;
            }

            const complexityRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{12,}$/;
            if (!complexityRegex.test(password)) {
                alert('La contraseña debe tener al menos 12 caracteres e incluir mayúsculas, minúsculas, números y símbolos.');
                document.getElementById('password').focus();
                e.preventDefault();
                return;
            }

            if ((primerNombre && password.toLowerCase().includes(primerNombre)) ||
                (primerApellido && password.toLowerCase().includes(primerApellido)) ||
                (documento && password.includes(documento))) {
                alert('Por seguridad, la contraseña NO debe contener su nombre, apellido o número de documento.');
                document.getElementById('password').focus();
                e.preventDefault();
                return;
            }


            e.preventDefault(); // Prevenimos para mostrar el overlay primero

            const overlay   = document.getElementById('loadingOverlay');
            const spinner   = document.getElementById('spinner');
            const check     = document.getElementById('successCheck');
            const text      = document.getElementById('loadingText');
            const submitBtn = registroForm.querySelector('button[type="submit"]');

            if (overlay) {
                overlay.style.display = 'flex';
                spinner.style.display = 'block';
                check.style.display   = 'none';
                text.innerText        = 'Procesando registro...';
                if (submitBtn) submitBtn.disabled = true;

                // Envío nativo tras mostrar overlay (pequeño delay para render)
                setTimeout(() => {
                    registroForm.submit();
                }, 300);
            } else {
                // Fallback si no existe el overlay
                registroForm.submit();
            }
        });
    }
});