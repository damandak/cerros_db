class SourcesController < ApplicationController
  before_action :set_source, only: %i[ show edit update destroy ]

  # GET /sources or /sources.json
  def index
    @sources = Source.all
  end

  # GET /sources/1 or /sources/1.json
  def show
  end

  # GET /sources/new
  def new
    @source = Source.new
    if params[:mountain]
      @referenceable = referenceable_object("Mountain", params[:mountain])
    elsif params[:route]
      @referenceable = referenceable_object("Route", params[:route])
    elsif params[:ascent]
      @referenceable = referenceable_object("Ascent", params[:ascent])
    elsif params[:andinist]
      @referenceable = referenceable_object("Andinist", params[:andinist])
    end
  end

  # GET /sources/1/edit
  def edit
    if params[:mountain]
      @referenceable = referenceable_object("Mountain", params[:mountain])
    elsif params[:route]
      @referenceable = referenceable_object("Route", params[:route])
    elsif params[:ascent]
      @referenceable = referenceable_object("Ascent", params[:ascent])
    elsif params[:andinist]
      @referenceable = referenceable_object("Andinist", params[:andinist])
    end
  end

  # POST /sources or /sources.json
  def create
    @source = Source.new(source_params)
    @referenceable = referenceable_object(@source.referenceable_type, @source.referenceable_id)
    
    respond_to do |format|
      if @source.save
        format.html { redirect_to @referenceable, notice: "Se creó la referencia." }
        format.json { render :show, status: :created, location: @source }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sources/1 or /sources/1.json
  def update
    @referenceable = referenceable_object(@source.referenceable_type, @source.referenceable_id)
    
    respond_to do |format|
      if @source.update(source_params)
        format.html { redirect_to @referenceable, notice: "Se actualizó la referencia." }
        format.json { render :show, status: :ok, location: @source }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sources/1 or /sources/1.json
  def destroy
    @referenceable = referenceable_object(@source.referenceable_type, @source.referenceable_id)
    @source.destroy
    respond_to do |format|
      format.html { redirect_to @referenceable, notice: "Se eliminó la referencia." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source
      @source = Source.find(params[:id])
    end

    def referenceable_object(obj_type, obj_id)
      if obj_type == "Mountain"
        return Mountain.find(obj_id)
      elsif obj_type == "Route"
        return Route.find(obj_id)
      elsif obj_type == "Andinist"
        return Andinist.find(obj_id)
      elsif obj_type == "Ascent"
        return Ascent.find(obj_id)
      else
        return nil
      end
    end

    # Only allow a list of trusted parameters through.
    def source_params
      params.require(:source).permit(:name, :link, :referenceable_id, :referenceable_type)
    end
end
