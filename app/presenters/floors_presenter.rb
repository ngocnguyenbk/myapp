class FloorsPresenter
  def initialize(params)
    @params = params
  end

  def floors
    floors = Floor.all.preload(:rooms)
    OpenStruct.new({ floors: floors })
  end
end
