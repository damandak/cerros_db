class AndinistsController < ApplicationController
  before_action :set_andinist, only: %i[ show edit update destroy ]

  # GET /andinists or /andinists.json
  def index
    @andinists = Andinist.all
  end

  # GET /andinists/1 or /andinists/1.json
  def show
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

    respond_to do |format|
      if @andinist.save
        format.html { redirect_to @andinist, notice: "Se creó a " + @andinist.fullname }
        format.json { render :show, status: :created, location: @andinist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @andinist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /andinists/1 or /andinists/1.json
  def update
    respond_to do |format|
      if @andinist.update(andinist_params)
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
      format.html { redirect_to andinists_url, notice: "Se eliminó a " + @andinist.fullname }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_andinist
      @andinist = Andinist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def andinist_params
      params.require(:andinist).permit(:name, :surname, :country, :club, :gender)
    end
end
