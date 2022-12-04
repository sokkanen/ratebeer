# frozen_string_literal: true

module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    rating_count = ratings.size
    return 0 if ratings.empty?

    (ratings.map(&:score).sum / rating_count.to_f)
  end
end
