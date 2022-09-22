class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        count = 0.0
        for rating in self.ratings do
            count += rating.score
        end
        return count / self.ratings.length
    end
end
