module BatchCreate
  class UsersImportForm
    include Virtus.model
    include ActiveModel::Model

    STEPS = { confirmation: "confirmation", done: "done" }.freeze

    attribute :file, String
    attribute :step, String
    attribute :import_users, Hash

    attr_reader :users, :error_child

    extend CarrierWave::Mount
    mount_uploader :file, ::UserFileUploader

    validate :file_format, :content_file

    def self.name
      "BatchCreate::UserImport"
    end

    def initialize(params = {})
      @users = {}
      @error_child = {}

      super params
    end

    def save
      return false if invalid?

      send "save_step_#{step}"
    end

    private

    def save_step_confirmation
      false
    end

    def save_step_done
      return false if invalid?

      ActiveRecord::Base.transaction do
        User.import! import_users.values
      end
      true
    end

    def file_format
      return if file.blank?

      errors.add(:file, :file_format) unless /\.(xlsx|xls)\Z/.match?(file.filename)
    end

    def content_file
      return if file.blank? || errors.added?(:file, :file_format)

      check_content_file
    end

    # rubocop:disable Metrics/AbcSize
    def check_content_file
      worksheet = RubyXL::Parser.parse(file.path)[0]
      i = 1
      list_email = []
      list_phone = []

      fields = Settings.import_users.header.to_h.keys
      fields_index = Settings.import_users.header.to_h.values

      worksheet.each_with_index do |row, index|
        next if index < Settings.import_users.line_start
        break if row.nil?

        row_value = []

        fields_index.each do |val|
          row_value << row[val].value
        end

        next unless row_value.any?

        users[i] = Hash[fields.zip(row_value)]
        users[i][:birthday] = users[i][:birthday]&.strftime("%d/%m/%Y")

        check_duplicate_email(users.dig(i, :email), list_email, i)
        check_duplicate_phone(users.dig(i, :phone), list_phone, i)
        check_exists_room(users.dig(i, :room_number), i)
        check_validate_form(i)

        i += 1
      end

      errors.add(:file, :content_file) unless error_child.empty?
    end
    # rubocop:enable Metrics/AbcSize

    def check_duplicate_email(email, list_email, index)
      if list_email.include?(email)
        dup_line = list_email.index(email) + 1

        message = I18n.t(".users_import_form.duplicated_email", dup_line: dup_line)
        error_child[index].nil? ? error_child[index] = [message] : error_child[index].push(message)
      else
        list_email << email
      end
    end

    def check_duplicate_phone(phone, list_phone, index)
      if list_phone.include?(phone)
        dup_line = list_phone.index(phone) + 1

        message = I18n.t(".users_import_form.duplicated_phone", dup_line: dup_line)
        error_child[index].nil? ? error_child[index] = [message] : error_child[index].push(message)
      else
        list_phone << phone
      end
    end

    def check_exists_room(room_number, index)
      if room_numbers.key(room_number).nil?
        message = I18n.t(".users_import_form.exists_room", room_number: room_number)
        error_child[index].nil? ? error_child[index] = [message] : error_child[index].push(message)
      else
        users[index].merge!(room_id: room_numbers.key(room_number))
      end
    end

    def check_validate_form(index)
      return unless error_child[index].nil?

      user_form = ::UsersForm.new(users[index].except(:room_number))
      return true if user_form.valid?

      error_child[index] = user_form.errors.full_messages
    end

    def room_numbers
      @room_numbers ||= Hash[Room.select(:id, :room_number).all.map { |r| [r.id, r.room_number] }]
    end
  end
end
