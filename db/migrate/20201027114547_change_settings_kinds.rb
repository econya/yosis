class ChangeSettingsKinds < ActiveRecord::Migration[6.0]
  def up
    news_line_setting = SiteSetting.find_by(key: 'news_line')
    if news_line_setting.present?
      news_line_setting.update!(kind: 'markdown')
    end

    copyright_notice_setting = SiteSetting.find_by(key: 'copyright_notice')
    if copyright_notice_setting.present?
      copyright_notice_setting.update!(kind: 'string')
    end
  end

  def down
    news_line_setting = SiteSetting.find_by(key: 'news_line')
    if news_line_setting.present?
      news_line_setting.update!(kind: 'string')
    end

    copyright_notice_setting = SiteSetting.find_by(key: 'copyright_notice')
    if copyright_notice_setting.present?
      copyright_notice_setting.update!(kind: 'markdown')
    end
  end
end
