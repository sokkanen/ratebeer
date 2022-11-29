# frozen_string_literal: true

class Brewery < ApplicationRecord
  include RatingAverage
  include TopN

  validates :name, presence: true

  validates :year, numericality: {
    greater_than_or_equal_to: 1040,
    less_than_or_equal_to: ->(_brewery) { Date.current.year },
    only_integer: true
  }

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }
end
