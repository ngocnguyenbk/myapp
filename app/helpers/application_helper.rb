module ApplicationHelper
  ACTIVE_CLASS = "active".freeze

  def active_for(options)
    name_of_controller = options.fetch(:controller) { nil }

    return unless name_of_controller == controller_name

    ACTIVE_CLASS
  end

  def active_locale(options)
    name_of_locale = options.fetch(:locale) { nil }

    return unless name_of_locale == I18n.locale.to_s

    ACTIVE_CLASS
  end
end
