function set_on_click() {
    var play_pause = document.getElementById("play_pause");

    play_pause.onclick = function() {
        alert("Just a test");
    }
}

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

    insertAfter(el, make_button("Hello", "Click to delete me"));
}
