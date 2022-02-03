class ExpeditionsController < ApplicationController
  def index
    @expeditions = Expedition.all
  end

  def show
    @expedition = Expedition.find(params[:id])
  end
end