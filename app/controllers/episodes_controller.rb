class EpisodesController < ApplicationController
  before_filter :set_series
  
  # GET /episodes
  # GET /episodes.json
  def index
    @episodes = @series.episodes.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @episodes }
    end
  end

  # GET /episodes/1
  # GET /episodes/1.json
  def show
    @episode = @series.episodes.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @episode }
    end
  end

  # GET /episodes/1/edit
  def edit
    @episode = @series.episodes.find(params[:id])
  end

  # PUT /episodes/1
  # PUT /episodes/1.json
  def update
    @episode = @series.episodes.find(params[:id])

    respond_to do |format|
      if @episode.update_attributes(params[:episode])
        format.html { redirect_to [@series, @episode], notice: 'Episode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
  def set_series
    @series = Series.find(params[:series_id])
  end
end
