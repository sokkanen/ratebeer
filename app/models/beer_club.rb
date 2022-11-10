class BeerClub < ApplicationRecord
  has_many :memberships
  has_many :members, -> { distinct }, through: :memberships, source: :user
end
