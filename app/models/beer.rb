# frozen_string_literal: true

class Beer < ApplicationRecord
  include RatingAverage

  validates :name, presence: true

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def to_s
    "#{brewery.name}: #{name}"
  end
end
