class Month < ApplicationRecord
  validates :name, presence: { message: ' deve ser informado' }

  has_many :debit, dependent: :destroy

  def total
    debits_not_paid.map(&:price).compact.inject(:+)
  end

  def total_per_owner
    debits_per_owner = []

    debits_not_paid.group_by(&:owner_id).each do |key, value|
      debits_per_owner << {
        owner: Owner.find(key).name,
        total: value.map(&:price).inject(:+)
      }
    end

    debits_per_owner
  end

  private

  def debits_not_paid
    debits_not_paid = debit.map { |d| d unless d.paid }

    debits_not_paid.compact
  end
end
