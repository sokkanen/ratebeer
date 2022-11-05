class Brewery < ApplicationRecord
    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    def average_rating
        return self.ratings.inject(0.0) do |count, rating|
            count += rating.score
        end / self.ratings.length
    end
end
