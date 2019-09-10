class LevelsController < ApplicationController
  before_action :set_level, only: [:show, :update, :destroy]

  def index
    # TODO paginate?
    @levels = Level.all
    render json: @levels.to_json
  end

  def show
    render json: @level
  end

  def create
    @level = Level.new(level_params)
    @level.user_id = current_user.id
    if @level.save
      render json: @level.to_json
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
      params.require(:level).permit(:data, :name)
    end
end
