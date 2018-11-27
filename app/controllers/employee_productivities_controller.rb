class EmployeeProductivitiesController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_employee_productivity, only: [:show, :edit, :update, :destroy]

  # GET /employee_productivities
  # GET /employee_productivities.json
  def index
    @employee_productivities = EmployeeProductivity.all

    device_id = params[:device_id]
    device_active = params[:device_active]
    axis_data = params[:axis_data]
    emp_activity = params[:emp_activity]
    idle = params[:idle]
    pick = params[:pick]

    @ep_data = EmployeeProductivity.where("device_id = ? and device_active = ? and axis_data = ? and emp_activity = ? and idle = ? and pick = ?", device_id, device_active, axis_data, emp_activity, idle, pick) if device_id && device_active && axis_data && emp_activity && idle && pick
    puts @ep_data.inspect

    if device_id != nil
      @iems_data = EmployeeProductivity.new
      @iems_data.device_id = device_id
      @iems_data.device_active = device_active
      @iems_data.axis_data = axis_data
      @iems_data.emp_activity = emp_activity
      @iems_data.idle = idle
      @iems_data.pick = pick
      @iems_data.save!
    end  
  end

  # GET /employee_productivities/1
  # GET /employee_productivities/1.json
  def show
  end

  # GET /employee_productivities/new
  def new
    @employee_productivity = EmployeeProductivity.new
  end

  # GET /employee_productivities/1/edit
  def edit
  end

  # POST /employee_productivities
  # POST /employee_productivities.json
  def create
    @employee_productivity = EmployeeProductivity.new(employee_productivity_params)

    respond_to do |format|
      if @employee_productivity.save
        format.html { redirect_to @employee_productivity, notice: 'Employee productivity was successfully created.' }
        format.json { render :show, status: :created, location: @employee_productivity }
      else
        format.html { render :new }
        format.json { render json: @employee_productivity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_productivities/1
  # PATCH/PUT /employee_productivities/1.json
  def update
    respond_to do |format|
      if @employee_productivity.update(employee_productivity_params)
        format.html { redirect_to @employee_productivity, notice: 'Employee productivity was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee_productivity }
      else
        format.html { render :edit }
        format.json { render json: @employee_productivity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_productivities/1
  # DELETE /employee_productivities/1.json
  def destroy
    @employee_productivity.destroy
    respond_to do |format|
      format.html { redirect_to employee_productivities_url, notice: 'Employee productivity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_productivity
      @employee_productivity = EmployeeProductivity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_productivity_params
      params.require(:employee_productivity).permit(:device_id, :device_active, :axis_data, :emp_activity, :idle, :pick)
    end
end
