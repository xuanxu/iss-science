class SubcategoriesController < ApplicationController
  def index
    @subcategories = Subcategory.all
  end

  def show
    @subcategory = Subcategory.find(params[:id])
    @experiments = @subcategory.experiments
    @experiments = @experiments.where(space_agency_id: params[:by_space_agency]) if params[:by_space_agency].present?
  end
end
