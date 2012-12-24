class SeriesController < ApplicationController
  # GET /series
  # GET /series.json
  def index
    @series = Series.all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @series }
    end
  end
  
  # GET /series/search
  # GET /series/search.json
  def search
    @q = params[:q]
    @results = Series.external_search(@q)

    respond_to do |format|
      format.html # search.html.haml
      format.json { render json: @results.to_json }
    end
  end

  # GET /series/1
  # GET /series/1.json
  def show
    @series = Series.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @series }
    end
  end

  # GET /series/new
  # GET /series/new.json
  def new
    @sid = params[:sid]
    @series = @sid.present? ? Series.find_or_new_from_sid(@sid) : Series.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @series }
    end
  end

  # GET /series/1/edit
  def edit
    @series = Series.find(params[:id])
  end

  # POST /series
  # POST /series.json
  def create
    params[:series] ||= {}
    @sid = params[:sid] || params[:series][:sid]
    @series = @sid.present? ? Series.find_or_new_from_sid(@sid, params[:series]) : Series.new(params[:series])

    respond_to do |format|
      if @series.save
        format.html { redirect_to @series, notice: 'Series was successfully created.' }
        format.json { render json: @series, status: :created, location: @series }
      else
        format.html { render action: "new" }
        format.json { render json: @series.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /series/1
  # PUT /series/1.json
  def update
    @series = Series.find(params[:id])

    respond_to do |format|
      if @series.update_attributes(params[:series])
        format.html { redirect_to @series, notice: 'Series was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @series.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /series/1
  # DELETE /series/1.json
  def destroy
    @series = Series.find(params[:id])
    @series.destroy

    respond_to do |format|
      format.html { redirect_to series_index_url }
      format.json { head :no_content }
    end
  end
end
