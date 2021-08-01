class AscentsController < ApplicationController
  before_action :set_ascent, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, :only => %i[ index show ]

  # GET /ascents or /ascents.json
  def index
    #@ascents = Ascent.all
    respond_to do |format|
      format.html
      format.json { render json: AscentsDatatable.new(view_context) }
    end
  end

  # GET /ascents/1 or /ascents/1.json
  def show
  end

  # GET /ascents/new
  def new
    @ascent = Ascent.new
    if params[:mountain]
      @mountain = Mountain.find(params[:mountain])
    end
  end

  # GET /ascents/1/edit
  def edit
    if params[:mountain]
      @mountain = Mountain.find(params[:mountain])
    end
  end

  # POST /ascents or /ascents.json
  def create
    params[:ascent][:year] = ascent_params[:ascent_date].to_date.year
    if !ascent_params[:no_month] and !ascent_params[:no_day] then
      params[:ascent][:month] = ascent_params[:ascent_date].to_date.month
      params[:ascent][:day] = ascent_params[:ascent_date].to_date.day
    elsif !ascent_params[:no_month] then
      params[:ascent][:month] = ascent_params[:ascent_date].to_date.month
      params[:ascent][:day] = nil
    else
      params[:ascent][:month] = nil
      params[:ascent][:day] = nil
    end

    @ascent = Ascent.new(ascent_params)
    
    respond_to do |format|
      if @ascent.save
        format.html { redirect_to @ascent.route.mountain, notice: "El ascenso fue creado satisfactoriamente." }
        format.json { render :show, status: :created, location: @ascent }
      else
        format.html { render :new, status: :unprocessable_entity, notice: "No se pudo crear Ascenso" }
        format.json { render json: @ascent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ascents/1 or /ascents/1.json
  def update

    params[:ascent][:year] = ascent_params[:ascent_date].to_date.year
    if !ascent_params[:no_month] and !ascent_params[:no_day] then
      params[:ascent][:month] = ascent_params[:ascent_date].to_date.month
      params[:ascent][:day] = ascent_params[:ascent_date].to_date.day
    elsif !ascent_params[:no_month] then
      params[:ascent][:month] = ascent_params[:ascent_date].to_date.month
      params[:ascent][:day] = nil
    else
      params[:ascent][:month] = nil
      params[:ascent][:day] = nil
    end

    respond_to do |format|
      if @ascent.update(ascent_params)
        format.html { redirect_to @ascent.route.mountain, notice: "Se actualizó el ascenso." }
        format.json { render :show, status: :ok, location: @ascent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ascent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ascents/1 or /ascents/1.json
  def destroy
    @ascent.destroy
    respond_to do |format|
      format.html { redirect_to ascents_url, notice: "Ascent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ascent
      @ascent = Ascent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ascent_params
      params.fetch(:ascent, {})
      params.require(:ascent).permit(:name, :year, :month, :day, :route_id, :andinist_nonexistent, :ascent_date, :no_month, :no_day, :andinist_ids => [])
    end
end
