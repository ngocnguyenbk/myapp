class BaseForm
  include Virtus.model
  include ActiveModel::Model

  attr_accessor :record

  def assign_from_model
    attributes.keys.each do |attr|
      public_send "#{attr}=", record.public_send(attr)
    end
  end
end
