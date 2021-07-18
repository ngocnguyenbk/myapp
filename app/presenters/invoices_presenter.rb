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
    @limit = Settings.per_page.invoices
  end

  def result
    return @result if @result

    q_params = params[:q] || ActionController::Parameters.new
    @q = SearchInvoicesForm.new(q_params.permit!).build_params
    @result ||= Invoice.ransack(@q).result.preload(PRELOAD_TABLE).ordered
  end

  def invoices
    OpenStruct.new({ invoices: result.page(params[:page]).per(@limit) }.merge(paginate))
  end

  private

  attr_reader :params

  def paginate
    total_count = result.size
    total_pages = (total_count % @limit).zero? ? total_count / @limit : (total_count / @limit) + 1
    {
      current_page: (params[:page].presence || 1).to_i,
      total_pages: total_pages,
      total_count: total_count,
      months: months
    }
  end

  def months
    Invoice.all.pluck(:date_export).map(&:month).uniq.sort
  end
end
