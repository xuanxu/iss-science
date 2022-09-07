class KeywordsController < ApplicationController
  before_action :admin_required, except: [:index, :show]

  def index
    @keywords = Keyword.all
  end

  def show
    @keyword = Keyword.includes(:experiments).find(params[:id])
  end

  def new
    @keyword = Keyword.new
  end

  def create
    @keyword = Keyword.new(keyword_params)

    if @keyword.save
      redirect_to keywords_path, notice: 'Keyword added!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @keyword = Keyword.find(params[:id])
  end

  def update
    @keyword = Keyword.find(params[:id])
    if @keyword.update(keyword_params)
      redirect_to keywords_url, notice: 'Keyword updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @keyword.destroy
    redirect_to keywords_url, notice: 'Keyword destroyed!'
  end

  private

    def keyword_params
      params.require(:keyword).permit(:name, :variations)
    end
end