# frozen_string_literal: true

class Debit < ApplicationRecord
  before_save :transform_title

  validates :title, presence: { message: ' deve ser informado' }
  validates :price, presence: { message: ' deve ser informado' }

  default_scope { order('title ASC') }

  belongs_to :owner
  belongs_to :month

  # @param id Integer
  # @returns Debit
  def self.toggle_paid(id)
    debit = find(id)

    update(debit.id, paid: !debit.paid)

    debit
  end

  def transform_title
    return '' if title.nil?

    title.upcase!
  end
end
