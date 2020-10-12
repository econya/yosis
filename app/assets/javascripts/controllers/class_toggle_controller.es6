/*
 * SPDX-FileCopyrightText: 2020 Felix Wolfsteller
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

window.application.register('class_toggle', class extends Stimulus.Controller {
  connect() {
    console.log("class_toggle stimulus controller connected");
  }

  highlight() {
    //console.log("enter");
    this.element.classList.toggle(this.toggle_class, true)
  }

  downlight() {
    //console.log("out");
    this.element.classList.toggle(this.toggle_class, false);
  }

  get toggle_class() {
    //console.log(this.data.get("toggle_class"));
    return this.data.get("toggle_class");
  }
});
