# frozen_string_literal: true

class RatingsController < ApplicationController
  before_action :expire_brewerylist, only: [:new, :create, :destroy]

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
    @ratings = Rating.all
    @recent = Rating.recent
    @top_beers = Beer.top 3
    @top_breweries = Brewery.top 3
    @top_styles = Style.top 3
    @most_active = User.most_active
  end

  private
  
  def expire_brewerylist
    expire_fragment("brewerylist")
  end
end
