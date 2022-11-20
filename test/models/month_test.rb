require 'test_helper'

class MonthTest < ActiveSupport::TestCase
  def create_month_and_owner
    month = Month.create(name: 'Teste')
    owner = Owner.create(name: 'Owner 1')

    { month:, owner: }
  end

  test 'Calculate total debits that are not paid' do
    month, owner = create_month_and_owner.values_at(:month, :owner)
    Debit.create(title: 'Debit 1', price: 200, paid: false, owner_id: owner.id, month_id: month.id)
    Debit.create(title: 'Debit 1', price: 200, paid: true, owner_id: owner.id, month_id: month.id)

    assert_equal month.total, 200
  end

  test 'Calculate total per owner that are not paid' do
    month, owner = create_month_and_owner.values_at(:month, :owner)
    Debit.create(title: 'Debit 1', price: 200, paid: false, owner_id: owner.id, month_id: month.id)
    Debit.create(title: 'Debit 1', price: 200, paid: false, owner_id: owner.id, month_id: month.id)
    Debit.create(title: 'Debit 1', price: 200, paid: true, owner_id: owner.id, month_id: month.id)

    total_per_owner = month.total_per_owner
    total_per_owner.each do |total|
      assert_equal total[:owner], "OWNER 1"
      assert_equal total[:total].to_i, 400.0
    end
  end
end
