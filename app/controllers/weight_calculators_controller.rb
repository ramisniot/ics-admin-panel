class WeightCalculatorsController < ApplicationController
  # protect_from_forgery with: :null_session
  include ActionView::Helpers::NumberHelper
  protect_from_forgery :except => :totals
  before_action :set_weight_calculator, only: [:show, :edit, :update, :destroy]

  # GET /weight_calculators
  # GET /weight_calculators.json
  def index
    @weight_calculators = WeightCalculator.all
    # a = rand(0..26)
    # b = rand(0..26)

    # value = a + b

    # # puts data
    # # value = rand(0..26) # Some expensive database query
    # render js: "$('#dashboard-totals').html('#{value}')"
  end

  def totals
    weight_per_part = params[:wpp]
    count = params[:count]

    if weight_per_part && count
      value = number_with_precision((weight_per_part.to_f * count.to_f), :precision => 2)
      # value = number_to_rounded((weight_per_part.to_f * count.to_f), :precision => 2)
      # value = number_to_currency((weight_per_part.to_f * count.to_f))
    else
      value = 0.00
    end
    # a = rand(0..26)
    # b = rand(0..26)

    # value = a + b

    # puts data
    # value = rand(0..26) # Some expensive database query
    render js: "$('#dashboard-totals').html('#{value} Kgs')"
  end

  # GET /weight_calculators/1
  # GET /weight_calculators/1.json
  def show
  end

  # GET /weight_calculators/new
  def new
    @weight_calculator = WeightCalculator.new
  end

  # GET /weight_calculators/1/edit
  def edit
  end

  # POST /weight_calculators
  # POST /weight_calculators.json
  def create
    @weight_calculator = WeightCalculator.new(weight_calculator_params)

    respond_to do |format|
      if @weight_calculator.save
        format.html { redirect_to @weight_calculator, notice: 'Weight calculator was successfully created.' }
        format.json { render :show, status: :created, location: @weight_calculator }
      else
        format.html { render :new }
        format.json { render json: @weight_calculator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weight_calculators/1
  # PATCH/PUT /weight_calculators/1.json
  def update
    respond_to do |format|
      if @weight_calculator.update(weight_calculator_params)
        format.html { redirect_to @weight_calculator, notice: 'Weight calculator was successfully updated.' }
        format.json { render :show, status: :ok, location: @weight_calculator }
      else
        format.html { render :edit }
        format.json { render json: @weight_calculator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weight_calculators/1
  # DELETE /weight_calculators/1.json
  def destroy
    @weight_calculator.destroy
    respond_to do |format|
      format.html { redirect_to weight_calculators_url, notice: 'Weight calculator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weight_calculator
      @weight_calculator = WeightCalculator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weight_calculator_params
      params.require(:weight_calculator).permit(:part_code, :wpp, :count, :idm, :mpq)
    end
end
