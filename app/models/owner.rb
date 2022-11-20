class Owner < ApplicationRecord
  before_save :transform_name

  validates :name, presence: { message: ' nao pode ser vazio' }
  has_many :debit, dependent: :destroy

  def group_by_same_title
    debit.group_by { |value| value[:title] }
  end

  def transform_name
    name.upcase!
  end
end
