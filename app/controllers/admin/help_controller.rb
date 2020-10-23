# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::HelpController < Admin::AdminController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @markdown_headers = <<~MD
    # 1: Highest heading
    ## 1.1: Second order heading
    ### 1.1.1: Third order
    #### 1.1.1.1: Fourth order
    ##### 1.1.1.1: Fifth order
    MD

    @markdown_paragraphs = <<~MD
    A paragraph.
    Even if you write on a newline, it will be the same paragrah.

    New paragraphs will be created by an empty line between two paragraphs.

    If you need a manual  
    break within a paragraph, end the line (here on the word manual with two invisible spaces at the end).

    MD

    @markdown_typography = <<~MD
    You can use **bold**, *italic* and __underlined__ text with stars and underscores.
    These can also be ***__mixed__***.
    MD

    @markdown_lists = <<~MD
    Lists are automatically created if after an empty new line

    1. you add numbers in front
    2. (they do not need to be correct):
    2. this item had a second "2" in front

    or with stars or plusses:

    * its a bullet list
    + the bullets are the stars
    * Nesting
      * is possible
        * with more stars
        + or pluses
    + and the list can continue

    MD

    @markdown_links_etc = <<~MD
    Links are easy, too. You will need squared and round brackets:

    [squared: link text, round: target](https://targetaddress)

    And then there are

    > blockquotes of famouse persons or an important citation/summary
    > with a greater-than-sign

    and `highlights` with so called "backticks".

    These [**can** be `combined`](https://).

    If you want typewriter-written text
    
        put four empty spaces in front
        of every line
        (here line breaks do break the lines)
    MD
  end
end

