require 'application_system_test_case'

class DebitsTest < ApplicationSystemTestCase
  setup do
    @debit = debits(:one)
    @month = months(:one)
  end

  # @param month Month
  def visit_a_month month
    visit months_url
    click_on month.name
  end

  test 'creating a new debit' do
    visit_a_month @month

    click_on '+ Adicionar Transação'
    fill_in "Titulo", with: "Test debit"
    fill_in "Preço", with: "200,55"
    fill_in "Dono", with: "Owner 1"

    click_on "Criar um novo debito"
    assert_selector 'p', text: 'Debito foi adicionado com sucesso.'
    assert_selector 'a', text: 'R$ 200.55'
  end
end
