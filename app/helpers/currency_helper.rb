# typed: true

module CurrencyHelper
  extend T::Sig
  include ActionView::Helpers::NumberHelper

  sig { params(amount: T.any(Float, Integer)).returns(String) }
  def number_to_brl(amount)
    number_to_currency(amount, unit: 'R$ ', delimiter: '.', separator: ',') || ''
  end

  sig { params(amount: T.nilable(T.any(Float, Integer))).returns(String) }
  def number_to_string_with_delimiter(amount)
    number_with_delimiter(amount, unit: '', delimiter: '.', separator: ',') || ''
  end
end
