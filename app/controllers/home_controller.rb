class HomeController < ApplicationController
  before_action :log_query, :only => :find
  rescue_from Exception, :with => :handle_exception

  layout false, :only => :i_real_import

  def home
    @tunes = []
    @search_string = nil
  end

  def find
    @search_string = params[:search_string].try(:squish)

    if @search_string.present?
      # Escape search to handle quotes and such using Arel.
      tunes = Tune.arel_table
      @tunes = Tune.includes(:i_real_files, :locations => :book).where(tunes[:title].matches("%#{@search_string}%"))
    else
      @tunes = []
      @message = "Please key in a search."
    end

    if @tunes.empty? && @message.blank?
      @message = "'#{@search_string}' turned up no results."
    end

    render :home
  end

  def i_real_import
    i_real_file = IRealFile.find(params[:id])
    song_hash = i_real_file.song_hash
    template = File.read(File.join(Rails.root, "lib/templates/ireal.html"))


    @file = template.gsub("{{ENCODED_SONG}}", i_real_file.to_i_real_url_encoded)
    @file = @file.gsub("{{SONG_TITLE}}", song_hash["title"])

    if !song_hash["composer"].blank?
      @file = @file.gsub("{{COMPOSER}}", " - #{song_hash["composer"]}")
    end
  end

  private

  def log_query
    if request.method == "POST"
      begin
        if params[:search_string].present?
          QueryLog.create!(:ip => request.ip, :query => params[:search_string])
        end
      rescue => e
        Rails.logger.error "Unable to log query. #{request.ip}:'#{params[:search_string]}'"
        Rails.logger.error e.message
        Rails.logger e.backtrace
      end
    end
  end



  def handle_exception(exception)
    @message = exception.message
    @tunes = [] # Make sure that page doesn't blow up.

    render :home
  end
end
