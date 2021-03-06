class UsersPresenter
  def initialize(params)
    @params = params
    @limit = Kaminari.config.default_per_page
  end

  def users
    users = User.all.includes(:room).order("rooms.room_number ASC").page(params[:page])
    OpenStruct.new({ users: users, count: users.size }.merge(paginate))
  end

  private

  attr_reader :params

  def paginate
    total_count = User.all.size
    total_pages = (total_count % @limit).zero? ? total_count / @limit : (total_count / @limit) + 1
    {
      current_page: (params[:page].presence || 1).to_i,
      total_pages: total_pages,
      total_count: total_count
    }
  end
end
