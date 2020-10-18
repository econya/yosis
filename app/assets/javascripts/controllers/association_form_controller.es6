/*
 * SPDX-FileCopyrightText: 2020 Felix Wolfsteller
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

window.application.register('association_form', class extends Stimulus.Controller {
  static get targets() {
    return [ "destroy_field", "root", "template" ]
  }

  connect() {
    console.log("association_form stimulus controller connected");
  }

  add() {
    console.log("add");

    var template_clone = this.templateTarget.cloneNode(true);
    template_clone.style.display = 'block';

    var children = template_clone.getElementsByTagName('*');
    var timestamp_id = new Date().getTime();

    for(var i = 0; i < children.length; i++) {
      elem = children[i];

      if (elem.attributes["name"] && elem.attributes["name"].value) {
        elem.attributes["name"].value = elem.attributes["name"].value.replace("REPLACE", timestamp_id);
        elem.disabled = false;
        console.log(elem.attributes["name"].value);
        console.log(elem);
      }
    }

    // alt: obj.insertBefore(this)
    this.rootTarget.insertAdjacentHTML("beforebegin", template_clone.innerHTML);
  }

  delete() {
    this.destroy_fieldTarget.value = '1';
  }
});

