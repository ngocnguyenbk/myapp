class FloorListSerializer
  attr_reader :data

  def initialize(args)
    @data = args[:data]
  end

  def generate
    {
      data: ActiveModelSerializers::SerializableResource.new(data.floors, each_serializer: FloorSerializer)
    }
  end
end
