class Subscription < ApplicationRecord
  belongs_to :user

  validates :date_start, presence: true
  validates :date_end, presence: true

  validate :start_before_end

  def start_before_end
    if date_end < date_start
      errors.add(:date_end, :must_be_before_start_date)
    end
  end

  def active_today?
    (date_start..date_end).include? DateTime.current
  end
end
