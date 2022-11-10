# frozen_string_literal: true

class Beer < ApplicationRecord
  include RatingAverage

  validates :name, presence: true

  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  def to_s
    "#{brewery.name}: #{name}"
  end
end
