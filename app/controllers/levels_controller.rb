class LevelsController < ApplicationController
  def index
    render json: Level.all.to_json
  end

  def show
    render json: Level.find(levels_params[:id]).to_json
  end

  def create
    @level = Level.create(data: params[:data], name: params[:name])
    render json: @level.to_json
  end

  def update
    @level = Level.find(levels_params[:id])
    @level.update(levels_params)
  end

  def levels_params
    params.permit(:data, :name, :id)
  end
end
