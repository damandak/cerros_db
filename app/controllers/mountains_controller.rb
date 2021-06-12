class MountainsController < ApplicationController
  before_action :set_mountain, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, :only => %i[ index show ]

  attr_accessor :first_country, :second_country, :third_country
  
  # GET /mountains or /mountains.json
  def index
    @mountains = Mountain.search(params[:mountain])
  end

  # GET /mountains/1 or /mountains/1.json
  def show
  end

  # GET /mountains/new
  def new
    @mountain = Mountain.new
  end

  # GET /mountains/1/edit
  def edit
  end

  # POST /mountains or /mountains.json
  def create
    @mountain = Mountain.new(mountain_params)

    if mountain_params[:first_country] then
      if mountain_params[:first_country] != "" then
        @country_one = Country.where(:name => mountain_params[:first_country]).first
      end
    end
    if mountain_params[:second_country] then
      if mountain_params[:second_country] != "" then
        @country_two = Country.where(:name => mountain_params[:second_country]).first
      end
    end
    if mountain_params[:third_country] then
      if mountain_params[:third_country] != "" then
        if Country.where(:name => mountain_params[:third_country]).count > 0 then
          @country_three = Country.where(:name => mountain_params[:third_country]).first
        else
          @country_three = Country.new
          @country_three.name = mountain_params[:third_country]
          @country_three.save!
        end
      end
    end

    respond_to do |format|
      if @mountain.save
        if @country_one then
          @mountain.countries << @country_one
        end
        if @country_two then
          @mountain.countries << @country_two
        end
        if @country_three then
          @mountain.countries << @country_three
        end
        format.html { redirect_to @mountain, notice: "El cerro fue creado satisfactoriamente." }
        format.json { render :show, status: :created, location: @mountain }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mountain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mountains/1 or /mountains/1.json
  def update

    if mountain_params[:first_country] then
      if mountain_params[:first_country] != "" then
        @country_one = Country.where(:name => mountain_params[:first_country]).first
      end
    end
    if mountain_params[:second_country] then
      if mountain_params[:second_country] != "" then
        @country_two = Country.where(:name => mountain_params[:second_country]).first
      end
    end
    if mountain_params[:third_country] then
      if mountain_params[:third_country] != "" then
        if Country.where(:name => mountain_params[:third_country]).count > 0 then
          @country_three = Country.where(:name => mountain_params[:third_country]).first
        else
          @country_three = Country.new
          @country_three.name = mountain_params[:third_country]
          @country_three.save!
        end
      end
    end

    respond_to do |format|
      if @mountain.update(mountain_params)
        @mountain.countries.each do |country|
          if country != @country_one and country != @country_two and country != @country_three then
            @mountain.countries.delete(country)
          end
        end 
        if @country_one and not @mountain.countries.exists?(@country_one.id) then
          @mountain.countries << @country_one
        end
        if @country_two and not @mountain.countries.exists?(@country_two.id) then
          @mountain.countries << @country_two
        end
        if @country_three and not @mountain.countries.exists?(@country_three.id) then
          @mountain.countries << @country_three
        end
        format.html { redirect_to @mountain, notice: "El cerro fue editado satisfactoriamente" }
        format.json { render :show, status: :ok, location: @mountain }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mountain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mountains/1 or /mountains/1.json
  def destroy
    @mountain.destroy
    respond_to do |format|
      format.html { redirect_to mountains_url, notice: "El cerro fue eliminado satisfactoriamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mountain
      @mountain = Mountain.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mountain_params
      params.require(:mountain).permit(:prefix, :name, :altitude, :latitude, :longitude, :search_type, :parent_id, :img_url, :img_author, :first_country, :second_country, :third_country)
    end
end
