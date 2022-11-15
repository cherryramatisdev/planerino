require "application_system_test_case"

class DebitsTest < ApplicationSystemTestCase
  setup do
    @debit = debits(:one)
  end

  test "visiting the index" do
    visit debits_url
    assert_selector "h1", text: "Debits"
  end

  test "should create debit" do
    visit debits_url
    click_on "New debit"

    fill_in "Month", with: @debit.month_id
    fill_in "Owner", with: @debit.owner_id
    check "Paid" if @debit.paid
    fill_in "Price", with: @debit.price
    fill_in "Title", with: @debit.title
    click_on "Create Debit"

    assert_text "Debit was successfully created"
    click_on "Back"
  end

  test "should update Debit" do
    visit debit_url(@debit)
    click_on "Edit this debit", match: :first

    fill_in "Month", with: @debit.month_id
    fill_in "Owner", with: @debit.owner_id
    check "Paid" if @debit.paid
    fill_in "Price", with: @debit.price
    fill_in "Title", with: @debit.title
    click_on "Update Debit"

    assert_text "Debit was successfully updated"
    click_on "Back"
  end

  test "should destroy Debit" do
    visit debit_url(@debit)
    click_on "Destroy this debit", match: :first

    assert_text "Debit was successfully destroyed"
  end
end
