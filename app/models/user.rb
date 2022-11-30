class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 }, format: { with: /(?=.*[A-Z])(?=.*\d)/, message: "Password must contain at least one capital letter and one number" }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  scope :most_active, -> { scope :recent, -> { order(created_at: :desc).limit(3) } }

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    highest = [0.0, nil]
    beers.map(&:style).uniq.each do |style|
      highest = get_avg_for_and_return_highest(style, highest, true)
    end
    highest[1]
  end

  def favorite_brewery
    highest = [0.0, nil]
    beers.map(&:brewery).uniq.each do |brewery|
      highest = get_avg_for_and_return_highest(brewery, highest, false)
    end
    highest[1]
  end

  def member_of?(beer_club_id)
    !memberships.select { |membership| membership.beer_club_id == beer_club_id }.empty?
  end

  private

  def get_avg_for_and_return_highest(object, storage, is_style)
    all = ratings.find_all{ |r| is_style ? r.beer.style == object : r.beer.brewery == object }
    avg = all.empty? ? return : all.map(&:score).sum / all.count.to_f
    storage = [avg, object] unless avg < storage[0]
    storage
  end
end
