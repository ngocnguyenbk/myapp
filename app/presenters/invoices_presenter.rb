class InvoicesPresenter
  PRELOAD_TABLE = [
    :item_electric,
    :item_internet,
    :item_parking_fee,
    :item_service,
    :item_water
  ].freeze

  def initialize(params)
    @params = params
    @limit = Kaminari.config.default_per_page
  end

  def invoices
    invoices = Invoice.all.preload(PRELOAD_TABLE).ordered.page(params[:page])
    OpenStruct.new({ invoices: invoices }.merge(paginate))
  end

  private

  attr_reader :params

  def paginate
    total_count = Invoice.all.size
    total_pages = (total_count % @limit).zero? ? total_count / @limit : (total_count / @limit) + 1
    {
      current_page: (params[:page].presence || 1).to_i,
      total_pages: total_pages
    }
  end
end
