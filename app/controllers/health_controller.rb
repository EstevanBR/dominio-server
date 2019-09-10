class HealthController < ApplicationController
  skip_before_action :authenticate_request

  def index
    render json: {STATUS: "UP"}, status: :ok
  end
end
