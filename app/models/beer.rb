class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    def average_rating
        return self.ratings.inject(0.0) do |count, rating|
            count += rating.score
        end / self.ratings.length
    end

    def to_s
        return "#{self.brewery.name}: #{self.name}"
    end

end
