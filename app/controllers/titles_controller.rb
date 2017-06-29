class TitlesController < ApplicationController
  def new
    @title = Title.new
  end

  def create
    @title = Title.new(permit_params)

    if @title.save
      redirect_to titles_url
    else
      render action: new_titles
    end
  end

  def index
    @titles = Title.all
  end

  def show
    @title = Title.find(params[:id])
  end

  def destroy
    Title.find(params[:id]).destroy
    redirect_to titles_url
  end

  private
  def permit_params
    params.require(:title).permit(:name, :year, :title_type, :description)
  end

end
