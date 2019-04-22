class HomeController < ApplicationController
  before_action :log_query, :only => :find
  rescue_from Exception, :with => :handle_exception

  def home
    @tunes = []
    @search_string = nil
  end

  def find
    @search_string = params[:search_string].try(:squish)

    if @search_string.present?
      # Escape search to handle quotes and such using Arel.
      tunes = Tune.arel_table
      @tunes = Tune.includes(:locations => :book).where(tunes[:title].matches("%#{@search_string}%"))
    else
      @tunes = []
      @message = "Please key in a search."
    end

    if @tunes.empty? && @message.blank?
      @message = "'#{@search_string}' turned up no results."
    end

    render :home
  end

  private

  def log_query
    if request.method == "POST"
      begin
        QueryLog.create!(:ip => request.ip, :query => params[:search_string])
      rescue => e
        Rails.logger.error "Unable to log query. #{request.ip}:'#{params[:search_string]}'"
        Rails.logger.error e.message
        Rails.logger e.backtrace
      end
    end
  end

  private

  def handle_exception(exception)
    @message = exception.message
    @tunes = [] # Make sure that page doesn't blow up.

    render :home
  end
end
