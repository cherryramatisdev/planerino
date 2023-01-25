# typed: true

class Year < ApplicationRecord
  has_many :month
  belongs_to :user
end
