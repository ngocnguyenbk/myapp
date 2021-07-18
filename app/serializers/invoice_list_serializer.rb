class InvoiceListSerializer
  attr_reader :data

  def initialize(args)
    @data = args[:data]
  end

  def generate
    {
      current_page: data.current_page,
      total_pages: data.total_pages,
      total_count: data.total_count,
      data: ActiveModelSerializers::SerializableResource.new(data.invoices, each_serializer: InvoiceSerializer)
    }
  end
end
