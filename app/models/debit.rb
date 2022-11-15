class Debit < ApplicationRecord
  validates :title, :presence => {:message => " nao pode ser vazio"}
  validates :price, :presence => {:message => " nao pode ser vazio"}
  validates :owner, :presence => {:message => "Precisa informar dono"}

  belongs_to :owner
  belongs_to :month

  def self.toggle_paid(id)
    debit = self.find(id)
    
    self.update(debit.id, paid: !debit.paid)
  end
end
