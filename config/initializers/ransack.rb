Ransack.configure do |config|
  config.custom_arrows = {
    up_arrow: '<i class="fa fa-caret-up"></i>',
    down_arrow: '<i class="fa fa-caret-down"></i>',
    default_arrow: ""
  }

  config.add_predicate "cont_multi",
                       arel_predicate: "cont_multi",
                       formatter: proc { |v| v.split(/[ ]+/) },
                       validator: proc { |v| v.present? },
                       type: :string

  config.add_predicate "matchesarray",
                       arel_predicate: "cont_multi",
                       formatter: proc { |v| v.split(/[ 　]+/) },
                       validator: proc { |v| v.present? },
                       type: :string

  config.add_predicate "cont_any_multi",
                       arel_predicate: "matches_any",
                       formatter: proc { |v| v.split(/[ 　]+/).map { |e| "%#{e}%" } },
                       validator: proc { |v| v.present? },
                       type: :string

  config.add_predicate "arraystring",
                       arel_predicate: "arraystring",
                       validator: proc { |v| v.present? },
                       type: :string

  config.add_predicate "arraycharacter",
                       arel_predicate: "arraycharacter",
                       validator: proc { |v| v.present? },
                       type: :string

  config.add_predicate "jsonsearches",
                       arel_predicate: "jsonsearches",
                       formatter: proc { |v| v.split(/[ 　]+/) },
                       validator: proc { |v| v.present? },
                       type: :string
  # rubocop:disable Style/RescueModifier
  config.add_predicate "from",
                       arel_predicate: "gteq",
                       formatter: proc { |v| Time.zone.parse(v) },
                       validator: proc { |v| v.present? && (Time.zone.parse(v) rescue nil).present? },
                       type: :string

  config.add_predicate "to",
                       arel_predicate: "lteq",
                       formatter: proc { |v| Time.zone.parse(v).end_of_day },
                       validator: proc { |v| v.present? && (Time.zone.parse(v) rescue nil).present? },
                       type: :string

  config.add_predicate "time_to",
                       arel_predicate: "lteq",
                       formatter: proc { |v| Time.zone.parse(v) },
                       validator: proc { |v| v.present? && (Time.zone.parse(v) rescue nil).present? },
                       type: :string
  # rubocop:enable Style/RescueModifier
end

module Arel
  module Nodes
    class ContMulti < Binary
      CONCAT_WS = "CONCAT_WS".freeze
      attr_reader :escape
      attr_accessor :case_sensitive

      def initialize(left, right, escape = nil, case_sensitive = false)
        key_name = left.name
        word = Nodes.build_quoted("%#{ApplicationRecord.sanitize_sql_like(right.val)}%").to_sql
        if key_name == CONCAT_WS
          custom_left = Arel.sql("#{left.to_sql} LIKE #{word}")
        else
          table_name = left.relation.name
          custom_left = Arel.sql("(`#{table_name}`.`#{key_name}` LIKE #{word})")
        end
        super(custom_left, nil)

        @escape = escape && Nodes.build_quoted(escape)
        @case_sensitive = case_sensitive
      end
    end

    class Jsonsearches < Binary
      attr_reader :escape
      attr_accessor :case_sensitive

      def initialize(left, right, escape = nil, case_sensitive = false)
        table_name = left.relation.name
        key_name = left.name

        word = Nodes.build_quoted("%#{ApplicationRecord.sanitize_sql_like(right.val)}%").to_sql
        custom_left = Arel.sql("JSON_SEARCH(`#{table_name}`.`#{key_name}`, 'one', #{word}) IS NOT NULL")
        super(custom_left, nil)

        @escape = escape && Nodes.build_quoted(escape)
        @case_sensitive = case_sensitive
      end
    end
  end
end

module Arel
  module Predications
    def cont_multi(other, escape = nil, case_sensitive = true)
      children = other.map do |word|
        Nodes::ContMulti.new self, quoted_node(word), escape, case_sensitive
      end
      Nodes::And.new(children)
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def arraystring(other)
      parts = other.gsub(/(\s)*[-〜](\s)*/, "-").split(/[\s,  ]+/).uniq

      list = []
      conditions = []

      parts.each do |part|
        case part
        when /\A\d+\Z/
          list.concat(part.scan(/\A\d+\Z/))
        when /\A(\d+)-(\d+)\Z/
          range = part.scan(/\A(\d+)-(\d+)\Z/)[0].sort! do |a, b|
            a.to_i <=> b.to_i
          end
          conditions << between(OpenStruct.new(begin: range.first, end: range.last))
        when /\A(\d+)-\Z/
          range = part.scan(/\A(\d+)-\Z/)[0]
          conditions << gteq(range.first)
        when /\A-(\d+)\Z/
          range = part.scan(/\A-(\d+)\Z/)[0]
          conditions << lteq(range.first)
        end
      end

      if list.empty?
        conditions
      else
        left = self.in(list)
        conditions.prepend(left)
      end.reduce(:or)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def arraycharacter(other)
      parts = other.split(/[,\s\t\r\n\f　 ]+/).uniq

      list = []
      conditions = []

      parts.each do |part|
        list.concat(part.scan(/\A.+\Z/)) if part.match?(/\A.+\Z/)
      end

      left = self.in(list)
      conditions.prepend(left).reduce(:or)
    end

    def jsonsearches(other, escape = nil, case_sensitive = true)
      other.map do |word|
        Nodes::Jsonsearches.new self, quoted_node(word), escape, case_sensitive
      end.reduce(:or)
    end
  end
end

module Arel
  module Visitors
    class MySQL < Arel::Visitors::ToSql
      private

      # rubocop:disable Naming/MethodName, Naming/MethodParameterName
      def visit_Arel_Nodes_ContMulti(o, collector)
        visit o.left, collector
      end

      def visit_Arel_Nodes_Jsonsearches(o, collector)
        visit o.left, collector
      end
      # rubocop:enable Naming/MethodName, Naming/MethodParameterName
    end
  end
end
