class ExperimentsController < ApplicationController
  before_action :admin_required, except: [:index]

  def index
    if params[:by_initial].present?
      @experiments = Experiment.by_initial(params[:by_initial])
    else
      @experiments = Experiment.all
    end
  end

  def show
    @experiment = Experiment.complete.find(params[:id])
  end

  def update
    @experiment = Experiment.find(params[:id])
    if @experiment.update(experiment_params)
      @experiment.revised!
      redirect_to experiment_url(@experiment), notice: "Experiment was successfully updated!"
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def experiment_params
      params.require(:experiment).permit(:completed_successfully,
                                         :crew_involvement,
                                         :required_sample_return,
                                         :hardware_required,
                                         :data_in_repositories,
                                         :required_sample_return,
                                         :crew_involvement_description,
                                         :data_in_respositories_details,
                                         :hardware_required_details,
                                         { keyword_ids: [] })
    end
end
