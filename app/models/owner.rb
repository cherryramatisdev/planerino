# typed: true

class Owner < ApplicationRecord
  before_save :transform_name

  validates :name, presence: { message: ' deve ser informado' }
  has_many :debit, dependent: :destroy

  def group_by_same_title(month_id)
    debit.where(month_id:).group_by { |value| value[:title] }
  end

  def debit_not_paid(month_id)
    debit.where(month_id:, paid: false)
  end

  def transform_name
    return '' if name.nil?

    T.must(name).upcase!
  end

  def initials
    return '' if name.nil?
    return T.must(T.must(name)[0]).upcase if T.must(name).split.length == 1

    initials = T.must(name).split.map { |n| T.must(n[0]).upcase }

    initials.join.upcase
  end
end
