# frozen_string_literal: true

class RatingsController < ApplicationController
  before_action :expire_brewerylist, only: [:new, :create, :destroy]

  #
  # Performance improvements:
  # - Not using scope for @recent, but sorting & picking from an already fetched array @ratings.
  # - Using config.after_initialize to initially run a job, which stores all top 3 -items to cache.
  #   Cache is re-written (job is run..) in 5 minute intervals.
  #
  def index
    set_variables
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if @rating.save
      redirect_to current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete unless rating.user != current_user
    redirect_to current_user, status: 303
  end

  def set_variables
    @ratings = Rating.includes(:user).all
    @recent = @ratings.sort_by(&:created_at).reverse[0..4]
    @top_beers = Rails.cache.read("beer_top_3") || []
    @top_breweries = Rails.cache.read("brewery_top_3") || []
    @top_styles = Rails.cache.read("style_top_3") || []
    @most_active = User.most_active
  end

  private

  def expire_brewerylist
    expire_fragment("brewerylist")
  end
end
