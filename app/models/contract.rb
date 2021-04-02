class Contract < ApplicationRecord
  include SoftDeletable

  NUMBER_MONTHS = 12

  has_many :invoices
  has_one :invoice_month_ago, -> { month_ago }, class_name: Invoice.name

  belongs_to :holder, class_name: User.name, optional: true
  belongs_to :room, class_name: Room.name, optional: true

  delegate :room_number, to: :room, prefix: true, allow_nil: true
  delegate :full_name, to: :holder, prefix: true, allow_nil: true

  scope :order_by_started_date, -> { order(active: :desc, started_date: :desc) }

  def start_date
    DateFormat.new(started_date)
  end

  def end_date
    DateFormat.new(ended_date)
  end

  def total_months_rented
    NUMBER_MONTHS * (Time.zone.today.year - started_date.year) + Time.zone.today.month - started_date.month + 1
  end

  def total_months_remaining
    sum = NUMBER_MONTHS * (ended_date.year - Time.zone.today.year) + ended_date.month - Time.zone.today.month
    sum.negative? ? 0 : sum
  end
end
