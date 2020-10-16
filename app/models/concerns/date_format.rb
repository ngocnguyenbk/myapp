class DateFormat
  def initialize(date)
    @date = date
  end

  def format_with_separate
    date&.strftime("%d/%m/%Y")
  end

  private

  attr_reader :date
end
