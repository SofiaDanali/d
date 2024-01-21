import {validateForm} from "./util.js"
function alignPasswordFields() {
    $("#passwordConf").attr('pattern', $("#password").val());
} 

$("#password").on('keyup keypress blur change', function() {
    alignPasswordFields();
});

$("#RegisterForm").submit(function() {
    alignPasswordFields();
    return validateForm(document.querySelector("#RegisterForm"));
});