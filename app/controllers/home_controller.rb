class HomeController < ApplicationController
  def home
    @tunes = Tune.includes(:locations => :book).order("tunes.title").all
  end

  def find
    @search_string = params[:search_string]
    @tunes = Tune.includes(:locations => :book).where("tunes.title like '%#{@search_string}%'")

    render :home
  end
end
