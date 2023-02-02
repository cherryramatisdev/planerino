# frozen_string_literal: true

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

    name.upcase!
  end

  def initials
    return '' if name.nil?
    return name[0].upcase if name.split.length == 1

    initials = name.split.map { |n| n[0].upcase }

    initials.join.upcase
  end
end
