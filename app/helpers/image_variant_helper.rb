# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module ImageVariantHelper
  def header_image_variant_url attachment
    if !attachment.attached?
      return "data:image/svg+xml;base64,#{GeoPattern.generate().to_base64}"
    end

    url_for(attachment
      .variant(resize_to_fill: Yosis::Application::HEADER_IMAGE_SIZE)
      .processed)
  end
end

