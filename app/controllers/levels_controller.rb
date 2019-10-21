class LevelsController < ApplicationController
  before_action :set_level, only: [:show, :update, :destroy, :rating]

  KEYS=[
    "GROUND",
    "SPIKE LONG",
    "SPIKE SHORT N",
    "SPIKE BALL",
    "LADDER",
    "DARTS LEFT",
    "DARTS RIGHT",
    "EXIT",
    "ENTRANCE",
    "FALL THROUGH",
    "LADDER TOP",
    "COIN",
    "SPIKE SHORT E",
    "SPIKE SHORT S",
    "SPIKE SHORT W"
  ]

  def index
    # TODO paginate?
    @levels = Level.all
    render json: @levels
  end

  def show
    render json: @level
  end

  def create
    @level = Level.new(level_params)
    @level.user_id = current_user.id
    if @level.save
      render json: @level
    else
      render json: @level.errors, status: :unprocessable_entity
    end
  end

  def update
    if @level.update(level_params)
      render json: @level
    else
      render json: @level.errors, status: :unprocessable_entity
    end
  end

  def rating
    render json: {rating: @level.ratings.calculate(:average, :value)}
  end

  def destroy
    @level.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_level
      @level = Level.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def level_params
      params["level"]["data"] = params["level"]["data"].slice(*KEYS) unless params.dig("level", "data").blank?
      params.require(:level).permit(:name, data:{})
    end
end
