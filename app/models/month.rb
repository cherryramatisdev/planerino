# frozen_string_literal: true

class Month < ApplicationRecord
  before_save :transform_name

  MONTH_NAMES = {
    'JANEIRO' => 0,
    'FEVEREIRO' => 1,
    'MARÇO' => 2,
    'MARCO' => 2,
    'ABRIL' => 3,
    'MAIO' => 4,
    'JUNHO' => 5,
    'JULHO' => 6,
    'AGOSTO' => 7,
    'SETEMBRO' => 8,
    'OUTUBRO' => 9,
    'NOVEMBRO' => 10,
    'DEZEMBRO' => 11
  }.freeze
  validates :name, presence: { message: ' deve ser informado' }

  belongs_to :user
  belongs_to :year
  has_many :debit, dependent: :destroy

  def transform_name
    return '' if name.nil?

    name.upcase!
  end

  def total
    debits_not_paid.map(&:price).compact.inject(:+)
  end

  def total_per_owner
    debits_per_owner = []

    debits_not_paid.group_by(&:owner_id).each do |key, value|
      debits_per_owner << {
        owner: Owner.find(key).name,
        total: value.map(&:price).inject(:+)
      }
    end

    debits_per_owner
  end

  def debits_not_paid
    debits_not_paid = debit.map { |d| d unless d.paid }

    debits_not_paid.compact
  end
end
