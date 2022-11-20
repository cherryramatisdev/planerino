class Debit < ApplicationRecord
  before_save :transform_title

  validates :title, presence: { message: ' deve ser informado' }
  validates :price, presence: { message: ' deve ser informado' }

  belongs_to :owner
  belongs_to :month

  def self.toggle_paid(id)
    debit = find(id)

    update(debit.id, paid: !debit.paid)
  end

  def transform_title
    title.upcase!
  end
end
