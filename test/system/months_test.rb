require 'application_system_test_case'

class MonthsTest < ApplicationSystemTestCase
  setup do
    @month = months(:one)
  end

  test 'visiting the index' do
    visit months_url
    assert_selector 'a', text: 'Planerino'

    months.each do |month|
      assert_selector 'a', text: month.name
    end
  end

  test 'visualizing an specific month' do
    visit months_url

    click_on @month.name

    assert_selector 'h1', text: "Débitos referente ao mês #{@month.name.capitalize}"
  end
end
