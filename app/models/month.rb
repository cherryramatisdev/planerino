class Month < ApplicationRecord
  validates :name, :presence => {:message => " nao pode ser vazio"}
end
