class Api::V1::SkillsController < ApplicationController
  
  respond_to :json

  def index
    respond_with Skill.all
  end

  def show
    respond_with Skill.find(params[:id])
  end
  
end
