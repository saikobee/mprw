function insertAfter(referenceNode, newNode) {
    //referenceNode.parentNode.insertBefore(newNode, referenceNode.nextSibling);
    referenceNode.parentNode.insertBefore(newNode, referenceNode.nextSibling);
}

function remove(el) {
    el.parentNode.removeChild(el);
}

function add_button_after(el) {
    function make_button(text, desc) {
        var tn1    = document.createTextNode(text);
        var tn2    = document.createTextNode(desc);

        var button = document.createElement("div");
        var border = document.createElement("div");
        var label  = document.createElement("p");
        var desc   = document.createElement("p");

        border.className = "button_border middle";
        button.className = "button";
        label .className = "label";
        desc  .className = "description";

        label .appendChild(tn1);
        desc  .appendChild(tn2);
        button.appendChild(label);
        button.appendChild(desc);
        border.appendChild(button);

        border.onclick = function() {
            remove(this);
        }

        return border;
    }

    var button = make_button("Hello", "Click to delete me");

    insertAfter(el, button);
}

function nop() {
}

function on_button_click(el) {
    var msg = "/api/" + el.id;
    $.get(msg, nop);
}
