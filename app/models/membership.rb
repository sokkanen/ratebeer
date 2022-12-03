class Membership < ApplicationRecord
  belongs_to :beer_club
  belongs_to :user

  scope :confirmed, -> { where confirmed: true }
  scope :pending, -> { where confirmed: false }
end
