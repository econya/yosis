/*
 * SPDX-FileCopyrightText: 2020 Felix Wolfsteller
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

window.application.register('render_md_preview',
  class extends Stimulus.Controller {
    static get targets() {
      return [ "source", "result" ]
    }

    connect() {
      console.log("render_md_preview stimulus controller connected");
      this.lastChange = 0;
    }

    render(event) {
      // if preview display
      event.preventDefault();
      var md_source_form_data = new FormData();
      md_source_form_data.append("md", this.sourceTarget.value);
      Rails.ajax({
        type: "post",
        url: '/admin/markdown/render',
        data: md_source_form_data,
        success: (_data, _status, xhr) => {
          this.resultTarget.innerHTML = xhr.response
        }
      })
    }
  }
)
