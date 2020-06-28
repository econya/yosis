/*
 * SPDX-FileCopyrightText: 2020 Felix Wolfsteller
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

function hide_admin_buttons() {
   var admin_stuff = document.querySelectorAll(".admin_edit_button");
  (admin_stuff || []).forEach(($admin_button) => {
    $admin_button.style.display = "none";
  });
}

