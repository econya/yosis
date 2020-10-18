/*
 * SPDX-FileCopyrightText: 2020 Felix Wolfsteller
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

window.application.register('reveal',
  class extends Stimulus.Controller {
    static get targets() {
      return [ "revealer", "hider", "content" ]
    }

    connect() {
      console.log("reveal stimulus controller connected");

      if (this.data.get("shown") == "true") {
        //this.reveal(null);
        reveal_content_elem = document.getElementById('reveal-content');
        if (reveal_content_elem) {
          reveal_content_elem.style.display = "block";
        }
      } else {
        //this.hide(null);
        reveal_content_elem = document.getElementById('reveal-content');
        if (reveal_content_elem) {
          reveal_content_elem.style.display = "none";
        }
      }
    }

    reveal(event) {
      event.preventDefault();
      this.contentTarget.style.display = "block";
      this.data.set("shown", true);
    }

    hide(event) {
      event.preventDefault();
      this.contentTarget.style.display = "none";
      this.data.set("shown", false);
    }
  }
)

