module CurrencyHelper
  def number_to_brl(amount)
    number_to_currency(amount, unit: 'R$ ', delimiter: '.', separator: ',')
  end
end
