module SoftDeletable
  extend ActiveSupport::Concern

  included do
    acts_as_paranoid column: :active, sentinel_value: true,
                     without_default_scope: true

    def paranoia_restore_attributes
      {
        deleted_at: nil,
        active: true
      }
    end

    def paranoia_destroy_attributes
      {
        deleted_at: current_time_from_proper_timezone,
        active: false
      }
    end
  end
end
