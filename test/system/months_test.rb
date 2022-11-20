require 'application_system_test_case'

class MonthsTest < ApplicationSystemTestCase
  setup do
    @month = months(:one)
  end

  test 'visiting the index' do
    visit months_url
    assert_selector 'a', text: 'Planerino'
    assert_selector 'a', text: 'ADICIONAR UM NOVO MÊS'

    months.each do |month|
      assert_selector 'a', text: month.name
    end
  end

  test 'creating a new month' do
    visit months_url

    click_on 'Adicionar um novo mês'
    fill_in 'month_name', with: @month.name
    click_on "Criar mês"

    assert_selector 'p', text: 'Mês foi criado com sucesso'
  end

  test 'visualizing an specific month' do
    visit months_url

    click_on @month.name

    assert_selector 'h1', text: "Débitos relacionados a #{@month.name}"
  end
end
