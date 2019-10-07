  class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :update, :destroy, :create]
  
  # GET /ratings
  def index
    @ratings = current_user.ratings

    render json: @ratings
  end

  # GET /ratings/1
  def show
    render json: @rating
  end

  # POST /ratings
  def create
    
    @rating.value = rating_params[:value]

    if @rating.save
      render json: @rating, status: :created, location: @rating
    else
      render json: @rating.errors, status: :unprocessable_entity
    end

    @rating.level.update_ratings!
  end

  # PATCH/PUT /ratings/1
  def update
    @rating.value = rating_params[:value]

    if @rating.save
      render json: @rating
    else
      render json: @rating.errors, status: :unprocessable_entity
    end

    @rating.level.update_ratings!
  end

  # DELETE /ratings/1
  def destroy
    l = @rating.level

    @rating.destroy

    l.update_ratings!
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find_by(id: params[:id])
      @rating ||= Rating.find_or_initialize_by(user_id: rating_params[:user_id], level_id: rating_params[:level_id])
    end

    # Only allow a trusted parameter "white list" through.
    def rating_params
      params.require(:rating).permit(:value, :user_id, :level_id)
    end
end
