class SearchInvoicesForm
  include Virtus.model
  include ActiveModel::Model

  attribute :room_number, String
  attribute :date_export, String

  def build_params
    {
      room_room_number_arraystring: room_number,
      date_export_month_eq: date_export
    }
  end
end
