/*
 * https://github.com/leastbad/stimulus-form-utilities/blob/master/src/auto_resize_height.js
 * SPDX-License-Identifier: MIT
 */

window.application.register('auto_resize_height', class extends Stimulus.Controller {
  static get targets() {
    return [ "input" ];
  }

  connect() {
    console.log("auto_resize_height stimulus controller connected");
  }

  initialize() {
    this.setInputAttributes();
    this.update();
  }

  update() {
    this.inputTarget.style.height = "auto";
    this.inputTarget.style.height = `${this.inputTarget.scrollHeight}px`;
  }

  setInputAttributes() {
    this.inputTarget.setAttribute("style", `height: ${this.inputTarget}px; /*overflow-y: hidden;*/`)
  }
}
)
