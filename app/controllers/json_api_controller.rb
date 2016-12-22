class JsonApiController < ApplicationController

  def complete
    render json: {
      :matches => Tag.select(:label, :count).where('label LIKE :prefix', prefix: "#{params[:term]}%", limit: 10)
    }
  end

end
