class AndinistsController < ApplicationController
  before_action :set_andinist, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, :only => %i[ index show ]
  attr_accessor :first_club, :second_club, :third_club
  attr_accessor :first_country, :second_country, :third_country

  # GET /andinists or /andinists.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: AndinistsDatatable.new(view_context) }
    end
  end

  # GET /andinists/1 or /andinists/1.json
  def show
    @andinist = Andinist.friendly.find(params[:id])
  end

  # GET /andinists/new
  def new
    @andinist = Andinist.new
  end

  # GET /andinists/1/edit
  def edit
  end

  # POST /andinists or /andinists.json
  def create
    @andinist = Andinist.new(andinist_params)
    if andinist_params[:first_club] then
      if andinist_params[:first_club] != "" then
        @club_one = Club.where(:name => andinist_params[:first_club]).first
      end
    end
    if andinist_params[:second_club] then
      if andinist_params[:second_club] != "" then
        @club_two = Club.where(:name => andinist_params[:second_club]).first
      end
    end
    if andinist_params[:third_club] then
      if andinist_params[:third_club] != "" then
        if Club.where(:name => andinist_params[:third_club]).count > 0 then
          @club_three = Club.where(:name => andinist_params[:third_club]).first
        else
          @club_three = Club.new
          @club_three.name = andinist_params[:third_club]
          @club_three.save!
        end
      end
    end

    if andinist_params[:first_country] then
      if andinist_params[:first_country] != "" then
        @country_one = Country.where(:name => andinist_params[:first_country]).first
      end
    end
    if andinist_params[:second_country] then
      if andinist_params[:second_country] != "" then
        @country_two = Country.where(:name => andinist_params[:second_country]).first
      end
    end
    if andinist_params[:third_country] then
      if andinist_params[:third_country] != "" then
        if Country.where(:name => andinist_params[:third_country]).count > 0 then
          @country_three = Country.where(:name => andinist_params[:third_country]).first
        else
          @country_three = Country.new
          @country_three.name = andinist_params[:third_country]
          @country_three.save!
        end
      end
    end

    respond_to do |format|
      if @andinist.save
        if @club_one then
          @andinist.clubs << @club_one
        end
        if @club_two then
          @andinist.clubs << @club_two
        end
        if @club_three then
          @andinist.clubs << @club_three
        end
        if @country_one then
          @andinist.countries << @country_one
        end
        if @country_two then
          @andinist.countries << @country_two
        end
        if @country_three then
          @andinist.countries << @country_three
        end
        format.html { redirect_to @andinist, notice: "Se cre?? a " + @andinist.fullname }
        format.json { render :show, status: :created, location: @andinist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @andinist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /andinists/1 or /andinists/1.json
  def update
    if andinist_params[:first_club] then
      if andinist_params[:first_club] != "" then
        @club_one = Club.where(:name => andinist_params[:first_club]).first
      end
    end
    if andinist_params[:second_club] then
      if andinist_params[:second_club] != "" then
        @club_two = Club.where(:name => andinist_params[:second_club]).first
      end
    end
    if andinist_params[:third_club] then
      if andinist_params[:third_club] != "" then
        if Club.where(:name => andinist_params[:third_club]).count > 0 then
          @club_three = Club.where(:name => andinist_params[:third_club]).first
        else
          @club_three = Club.new
          @club_three.name = andinist_params[:third_club]
          @club_three.save!
        end
      end
    end

    if andinist_params[:first_country] then
      if andinist_params[:first_country] != "" then
        @country_one = Country.where(:name => andinist_params[:first_country]).first
      end
    end
    if andinist_params[:second_country] then
      if andinist_params[:second_country] != "" then
        @country_two = Country.where(:name => andinist_params[:second_country]).first
      end
    end
    if andinist_params[:third_country] then
      if andinist_params[:third_country] != "" then
        if Country.where(:name => andinist_params[:third_country]).count > 0 then
          @country_three = Country.where(:name => andinist_params[:third_country]).first
        else
          @country_three = Country.new
          @country_three.name = andinist_params[:third_country]
          @country_three.save!
        end
      end
    end

    respond_to do |format|
      if @andinist.update(andinist_params)
        @andinist.clubs.each do |club|
          if club != @club_one and club != @club_two and club != @club_three then
            @andinist.clubs.delete(club)
          end
        end 
        if @club_one and not @andinist.clubs.exists?(@club_one.id) then
          @andinist.clubs << @club_one
        end
        if @club_two and not @andinist.clubs.exists?(@club_two.id) then
          @andinist.clubs << @club_two
        end
        if @club_three and not @andinist.clubs.exists?(@club_three.id) then
          @andinist.clubs << @club_three
        end

        @andinist.countries.each do |country|
          if country != @country_one and country != @country_two and country != @country_three then
            @andinist.countries.delete(country)
          end
        end 
        if @country_one and not @andinist.countries.exists?(@country_one.id) then
          @andinist.countries << @country_one
        end
        if @country_two and not @andinist.countries.exists?(@country_two.id) then
          @andinist.countries << @country_two
        end
        if @country_three and not @andinist.countries.exists?(@country_three.id) then
          @andinist.countries << @country_three
        end

        format.html { redirect_to @andinist, notice: "Se actualizaron los datos de " + @andinist.fullname }
        format.json { render :show, status: :ok, location: @andinist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @andinist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /andinists/1 or /andinists/1.json
  def destroy
    @andinist.destroy
    respond_to do |format|
      format.html { redirect_to andinists_url, notice: "Se elimin?? a " + @andinist.fullname }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_andinist
      @andinist = Andinist.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def andinist_params
      params.require(:andinist).permit(:name, :surname, :gender, :first_club, :second_club, :third_club, :first_country, :second_country, :third_country, :img_url, :img_author)
    end
end
