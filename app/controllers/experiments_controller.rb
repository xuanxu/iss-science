class ExperimentsController < ApplicationController
  before_action :set_experiment, only: %i[ show edit update destroy ]

  # GET /experiments or /experiments.json
  def index
    @experiments = Experiment.all
  end

  # GET /experiments/1 or /experiments/1.json
  def show
  end

  # PATCH/PUT /experiments/1 or /experiments/1.json
  def update
    respond_to do |format|
      if @experiment.update(experiment_params)
        format.html { redirect_to experiment_url(@experiment), notice: "Experiment was successfully updated." }
        format.json { render :show, status: :ok, location: @experiment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experiment
      @experiment = Experiment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def experiment_params
      params.require(:experiment).permit(:short_name, :full_name)
    end
end
