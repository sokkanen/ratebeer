class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        return self.ratings.inject(0.0) do |count, rating|
            count += rating.score
        end / self.ratings.length
    end
end
