# frozen_string_literal: true

module MonthsHelper
  # @param first [Month]
  # @param second [Month]
  def self.sort_by_name(first, second)
    Month::MONTH_NAMES[first.name.split[0]] <=> Month::MONTH_NAMES[second.name.split[0]]
  end
end
