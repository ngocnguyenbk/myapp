class DownloadInvoiceService
  include ActionView::Helpers::NumberHelper

  attr_reader :invoice

  def initialize(invoice)
    @invoice = invoice
  end

  def perform
    sample_file = Settings.sample_file.template_invoice
    doc = Docx::Document.open(sample_file)
    table = doc.tables[0]

    table.rows.each do |row|
      row.cells.each do |cell|
        cell.paragraphs.each do |paragraph|
          paragraph.each_text_run do |item|
            next unless detect_argument(item.text)

            item.text.scan(/\*\w+/).each do |text|
              name_func = text.delete("*")
              begin
                item.substitute(text, __send__(name_func))
              rescue StandardError => e
                Rails.logger.error("ERROR: [#{e.message}] - #{name_func}")
              end
            end
          end
        end
      end
    end
    doc.save(file_path)
  end

  def file_path
    return @file_path if @file_path

    path = Settings.folder_download.invoice
    FileUtils.mkdir_p path unless File.exist?(path)

    date_export = date_time("_")
    time_now = Time.zone.now.strftime("%Y%m%d%H%M%S")
    file_name = "invoice_room_#{room_number}_#{date_export}_#{time_now}.docx"

    @file_path = "#{path}/#{file_name}"
  end

  private

  def detect_argument(str)
    str.match?(/_/)
  end

  def room_number
    number_with_delimiter(invoice.contract.room.room_number)
  end

  def date_time(separator = "/")
    invoice.date_export.strftime("%-m#{separator}%Y")
  end

  def room_price
    number_with_delimiter(invoice.contract.room_price)
  end

  def total_room_price
    cost = invoice.contract.room_price * invoice.day_lived.to_f / invoice.day_in_month
    number_with_delimiter(cost.round(0))
  end

  def total_electric
    number_with_delimiter(invoice.item_electric.total)
  end

  def total_water
    number_with_delimiter(invoice.item_water.total)
  end

  def total_internet
    number_with_delimiter(invoice.item_internet.total)
  end

  def total_parking_fee
    number_with_delimiter(invoice.item_parking_fee.total)
  end

  def total_service
    number_with_delimiter(invoice.item_service.total)
  end

  def total_cost
    total_cost = calculate_by_day * invoice.day_lived.to_f / invoice.day_in_month +
                 invoice.item_electric.total + invoice.item_water.total
    number_with_delimiter(total_cost.round(0))
  end

  def calculate_by_day
    invoice.contract.room_price +
      invoice.item_internet.quantity * invoice.item_internet.unit_price +
      invoice.item_parking_fee.quantity * invoice.item_parking_fee.unit_price +
      invoice.item_service.quantity * invoice.item_service.unit_price
  end

  def total_reduce
    number_with_delimiter(invoice.reduce)
  end

  def total_revenue
    number_with_delimiter(invoice.total)
  end

  def qty_electric
    number_with_delimiter(invoice.item_electric.quantity.round(0))
  end

  def qty_water
    number_with_delimiter(invoice.item_water.quantity.round(0))
  end

  def qty_internet
    number_with_delimiter(invoice.item_internet.quantity)
  end

  def qty_parking_fee
    number_with_delimiter(invoice.item_parking_fee.quantity)
  end

  def qty_service
    number_with_delimiter(invoice.item_service.quantity)
  end

  def unit_electric
    invoice.item_electric.x_unit
  end

  def unit_water
    invoice.item_water.x_unit
  end

  def unit_internet
    invoice.item_internet.x_unit
  end

  def unit_parking_fee
    invoice.item_parking_fee.x_unit
  end

  def unit_service
    invoice.item_service.x_unit
  end

  def unit_price_electric
    number_with_delimiter(invoice.item_electric.unit_price)
  end

  def unit_price_water
    number_with_delimiter(invoice.item_water.unit_price)
  end

  def unit_price_internet
    number_with_delimiter(invoice.item_internet.unit_price)
  end

  def unit_price_parking_fee
    number_with_delimiter(invoice.item_parking_fee.unit_price)
  end

  def unit_price_service
    number_with_delimiter(invoice.item_service.unit_price)
  end

  def begin_ele
    number_with_delimiter(invoice.item_electric.begin_number.round(0))
  end

  def end_ele
    number_with_delimiter(invoice.item_electric.end_number.round(0))
  end

  def begin_wat
    number_with_delimiter(invoice.item_water.begin_number.round(0))
  end

  def end_wat
    number_with_delimiter(invoice.item_water.end_number.round(0))
  end
end
