# typed: true

class Debit < ApplicationRecord
  extend T::Sig
  before_save :transform_title

  validates :title, presence: { message: ' deve ser informado' }
  validates :price, presence: { message: ' deve ser informado' }

  default_scope { order('created_at DESC') }

  belongs_to :owner
  belongs_to :month

  sig { params(id: Integer).returns(Debit) }
  def self.toggle_paid(id)
    debit = find(id)

    update(debit.id, paid: !debit.paid)

    debit
  end

  def transform_title
    return '' if title.nil?

    T.must(title).upcase!
  end
end
