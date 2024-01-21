import {validateForm} from "./util.js"

$("#LoginForm").submit(function(e) {
    return validateForm(document.querySelector("#LoginForm"));
});