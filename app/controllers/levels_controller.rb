class LevelsController < ApplicationController
  def index
    # TODO paginate?
    render json: Level.all.to_json
  end

  def show
    render json: Level.find(params[:id]).to_json
  end

  def create
    @level = Level.create(data: params[:data], name: params[:name], user_id: current_user.id)
    render json: @level.to_json
  end

  def update
    @level = Level.find(params[:id])
    @level.update(params)
  end
end
