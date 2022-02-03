class DevelopersController < ApplicationController
  def index
    if params[:by_initial].present?
      @developers = Developer.by_initial(params[:by_initial])
    else
      @developers = Developer.all
    end
  end

  def show
    @developer = Developer.find(params[:id])
  end
end
