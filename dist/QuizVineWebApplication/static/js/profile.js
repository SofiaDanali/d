import {validateForm} from "./util.js"
function alignPasswordFields() {
    $("#passwordConf").attr('pattern', $("#password").val());
} 

$("#password").on('keyup keypress blur change', function() {
    alignPasswordFields();
});

$("#UpdatePasswordForm").submit(function() {
    alignPasswordFields();
    return validateForm(document.querySelector("#UpdatePasswordForm"));
});