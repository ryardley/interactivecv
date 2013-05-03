class Api::V1::ContentImagesController < ApplicationController
  respond_to :json

  def index
    respond_with ContentImage.all
  end

  def show
    respond_with ContentImage.find(params[:id])
  end
end
