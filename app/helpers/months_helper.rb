# frozen_string_literal: true

module MonthsHelper
  # @param first [Month]
  # @param second [Month]
  def self.sort_by_name(first, second)
    regexp = /,|-|./
    first_name = first.name.gsub(regexp, '')
    second_name = second.name.gsub(regexp, '')
    Month::MONTH_NAMES[first_name.split[0]] <=> Month::MONTH_NAMES[second_name.split[0]]
  end
end
