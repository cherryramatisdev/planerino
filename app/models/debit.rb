class Debit < ApplicationRecord
  before_save :transform_title

  validates :title, presence: { message: ' nao pode ser vazio' }
  validates :price, presence: { message: ' nao pode ser vazio' }
  validates :owner, presence: { message: 'Precisa informar dono' }

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
