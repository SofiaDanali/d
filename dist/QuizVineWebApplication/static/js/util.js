export function validateForm(form) {
    const validForm = form.checkValidity();
    form.classList.add("was-validated");
    return validForm;
}
