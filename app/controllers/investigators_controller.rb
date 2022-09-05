class InvestigatorsController < ApplicationController
  def index
    if params[:by_initial].present?
      @investigators = Investigator.by_initial(params[:by_initial])
    else
      @investigators = Investigator.all
    end
  end

  def show
    @investigator = Investigator.find(params[:id])
  end
end
