class SpaceAgenciesController < ApplicationController
  def index
    @space_agencies = SpaceAgency.all
  end

  def show
    @space_agency = SpaceAgency.find(params[:id])
    @experiments = @space_agency.experiments
    @experiments = @experiments.where(subcategory_id: params[:by_subcategory]) if params[:by_subcategory].present?
  end
end