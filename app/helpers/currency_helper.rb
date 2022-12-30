module CurrencyHelper
  def number_to_brl(amount)
    number_to_currency(amount, unit: 'R$ ', delimiter: '.', separator: ',')
  end

  def number_to_string_with_delimiter(amount)
    number_with_delimiter(amount, unit: '', delimiter: '.', separator: ',')
  end
end
