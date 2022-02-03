class SpaceAgenciesController < ApplicationController
  def index
    @space_agencies = SpaceAgency.all
  end

  def show
    @space_agency = SpaceAgency.find(params[:id])
  end
end