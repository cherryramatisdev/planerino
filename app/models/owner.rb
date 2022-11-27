class Owner < ApplicationRecord
  before_save :transform_name

  validates :name, presence: { message: ' deve ser informado' }
  has_many :debit, dependent: :destroy

  def group_by_same_title
    debit.group_by { |value| value[:title] }
  end

  def debit_not_paid
    debit.where(paid: false)
  end

  def transform_name
    name.upcase!
  end

  def get_initials
    return name[0].upcase if name.split.length == 1

    initials = name.split.map {|n| n[0].upcase }
    return initials.join.upcase
  end
end
