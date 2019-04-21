class HomeController < ApplicationController
  def home
    @tunes = []
    @search_string = nil
  end

  def find
    @search_string = params[:search_string].try(:squish)

    if @search_string.present?
      @tunes = Tune.includes(:locations => :book).where("tunes.title like '%#{@search_string}%'")
    else
      @tunes = []
      @message = "Please key in a search."
    end

    if @tunes.empty? && @message.blank?
      @message = "'#{@search_string}' turned up no results."
    end

    render :home
  end
end
