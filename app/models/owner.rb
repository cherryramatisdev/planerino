class Owner < ApplicationRecord
  validates :name, :presence => {:message => " nao pode ser vazio"}
  has_many :debit, dependent: :destroy

  def group_by_same_title
    self.debit.group_by {|value| value[:title]}
  end
end
