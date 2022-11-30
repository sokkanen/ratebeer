# frozen_string_literal: true

module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.empty?

    (ratings.map(&:score).sum / ratings.count.to_f).round(2)
  end
end
