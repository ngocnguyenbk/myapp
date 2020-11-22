module ApplicationHelper
  ACTIVE_CLASS = "is-active".freeze

  def active_for(options)
    name_of_controller = options.fetch(:controller) { nil }

    return unless name_of_controller == controller_name

    ACTIVE_CLASS
  end
end
