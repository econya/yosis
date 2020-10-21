# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module ImageVariantHelper
  def header_image_variant_url attachment
    if !attachment&.attached?
      return "data:image/svg+xml;base64,#{GeoPattern.generate().to_base64}"
    end

    url_for(attachment
      .variant(resize_to_fill: Yosis::Application::HEADER_IMAGE_SIZE)
      .processed)
  end

  def style_card_image_variant_url attachment, if_unattached: nil
    if !attachment&.attached? && if_unattached.nil?
      return "data:image/svg+xml;base64,#{GeoPattern.generate().to_base64}"
    end

    if !attachment&.attached? && if_unattached
      return if_unattached
    end

    url_for(attachment
      .variant(resize_to_fill: Yosis::Application::STYLE_CARD_IMAGE_SIZE)
      .processed)
  end

  def preview_image_variant_url attachment
    url_for(attachment
      .variant(resize_to_fill: Yosis::Application::IMAGE_128x128)
      .processed)
  end
end

