class CheeseController < ApplicationController

  # GET /cheese
  def index
    # send a response!
    render json: { hello: "Cheese World" }
  end

end