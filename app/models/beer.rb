# frozen_string_literal: true

class Beer < ApplicationRecord
  include RatingAverage
  include TopN

  validates :name, :style, presence: true

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  def to_s
    "#{brewery.name}: #{name}"
  end
end
