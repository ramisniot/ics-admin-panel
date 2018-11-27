class BarCodesController < ApplicationController
  before_action :set_bar_code, only: [:show, :edit, :update, :destroy]

  # GET /bar_codes
  # GET /bar_codes.json
  def index
    @bar_codes = BarCode.all
  end

  # GET /bar_codes/1
  # GET /bar_codes/1.json
  def show
  end

  # GET /bar_codes/new
  def new
    @bar_code = BarCode.new
  end

  # GET /bar_codes/1/edit
  def edit
  end

  # POST /bar_codes
  # POST /bar_codes.json
  def create
    @bar_code = BarCode.new(bar_code_params)

    respond_to do |format|
      if @bar_code.save
        format.html { redirect_to @bar_code, notice: 'Bar code was successfully created.' }
        format.json { render :show, status: :created, location: @bar_code }
      else
        format.html { render :new }
        format.json { render json: @bar_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bar_codes/1
  # PATCH/PUT /bar_codes/1.json
  def update
    respond_to do |format|
      if @bar_code.update(bar_code_params)
        format.html { redirect_to @bar_code, notice: 'Bar code was successfully updated.' }
        format.json { render :show, status: :ok, location: @bar_code }
      else
        format.html { render :edit }
        format.json { render json: @bar_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bar_codes/1
  # DELETE /bar_codes/1.json
  def destroy
    @bar_code.destroy
    respond_to do |format|
      format.html { redirect_to bar_codes_url, notice: 'Bar code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bar_code
      @bar_code = BarCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bar_code_params
      params.require(:bar_code).permit(:asn, :part_code, :qty, :date, :lot_size, :target, :location)
    end
end
