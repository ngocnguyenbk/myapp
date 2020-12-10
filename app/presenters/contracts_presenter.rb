class ContractsPresenter
  def initialize(params)
    @params = params
    @limit = Kaminari.config.default_per_page
  end

  def contracts
    contracts = Contract.all.includes(:room, :holder).page(params[:page])
    OpenStruct.new({ contracts: contracts, count: contracts.size }.merge(paginate))
  end

  private

  attr_reader :params

  def paginate
    total_count = Contract.all.size
    total_pages = (total_count % @limit).zero? ? total_count / @limit : (total_count / @limit) + 1
    {
      current_page: (params[:page].presence || 1).to_i,
      total_pages: total_pages
    }
  end
end
