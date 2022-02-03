class PrincipalInvestigatorsController < ApplicationController
  def index
    if params[:by_initial].present?
      @principal_investigators = PrincipalInvestigator.by_initial(params[:by_initial])
    else
      @principal_investigators = PrincipalInvestigator.all
    end
  end

  def show
    @principal_investigator = PrincipalInvestigator.find(params[:id])
  end
end
