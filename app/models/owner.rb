class Owner < ApplicationRecord
  validates :name, :presence => {:message => " nao pode ser vazio"}
  has_many :debit, dependent: :destroy
end
