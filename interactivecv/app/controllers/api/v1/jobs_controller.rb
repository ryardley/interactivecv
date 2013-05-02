class Api::V1::JobsController < ApplicationController
  respond_to :json

  def index
    respond_with Job.all
  end

  def show
    respond_with Job.find(params[:id])
  end
end
