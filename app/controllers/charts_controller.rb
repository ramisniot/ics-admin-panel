class ChartsController < ApplicationController
  before_action :set_chart, only: [:show, :edit, :update, :destroy]

  def index
    @charts = Chart.all
    @iot_data_for_1 = IotDatum.where("status = ? and count > ? and device_id = ?", 'Processing', 0, 1)
    @iot_data_for_2 = IotDatum.where("status = ? and count > ? and device_id = ?", 'Processing', 0, 2)
    
    @data_for_1 = []
    @data_for_2 = []
    @iot_data_for_1.each do |d|
      @data_for_1 << d.count
      @data_for_1 << d.target
      @data_for_1 << d.device_id
    end
    @iot_data_for_2.each do |f|
      @data_for_2 << f.count
      @data_for_2 << f.target
      @data_for_2 << f.device_id
    end

    @trackers_data_1 = Tracker.where("device_id = ?",1)
    @tracker_data_for_one = []
    @trackers_data_1.each do |one|
      @tracker_data_for_one << one.count
    end
    @trackers_data_2 = Tracker.where("device_id = ?",2)
    @tracker_data_for_two = []
    @trackers_data_1.each do |two|
      @tracker_data_for_two << two.count
    end

    adapt = ActiveRecord::Base.connection_config
    adapt = adapt.to_a
    puts adapt[0][1]

    if adapt[0][1] == 'mysql2'
      
    else
    # For PostgreSQL
      @day_wise = IotDatum.select("to_char(created_at, 'DD-MM-YYYY') as dates, to_char(created_at, 'Day') as day_name, sum(count) as actual, sum(target) as target, ROUND(((sum(count)::decimal/sum(target)::decimal) * 100),2) as progress").group("to_char(created_at, 'Day'), to_char(created_at, 'DD-MM-YYYY')")
      @@ds_wise = IotDatum.select("to_char(created_at, 'DD-MM-YYYY') as dates, to_char(created_at, 'Day') as day_name, device_id as workbench, shift, sum(target) as target, sum(count) as count, to_char(sum((updated_at - created_at)),'HH24:MI:SS') AS duration").where("status = 'Process Completed'").group("to_char(created_at, 'Day'), to_char(created_at, 'DD-MM-YYYY'), device_id, shift").order("to_char(created_at, 'DD-MM-YYYY')")
      @ds_wise = @@ds_wise
      @@sp_wise = IotDatum.select("to_char(created_at, 'DD-MM-YYYY') as dates, shift, device_id as workbench, part_number, to_char(sum((updated_at - created_at)),'HH24:MI:SS') AS duration").where("status = 'Process Completed'").group("part_number,shift,device_id,to_char(created_at, 'DD-MM-YYYY')").order("part_number")
      @sp_wise = @@sp_wise
      
      @weekly = IotDatum.select("extract(WEEK from created_at)::bigint as week_no, to_char(created_at, 'DD-MM-YYYY') as dates,to_char(created_at, 'Day') as day_name,sum(count) as actual, sum(target) as target, ROUND(((sum(count)::decimal/sum(target)::decimal) * 100),2) as progress").group("extract(WEEK from created_at),to_char(created_at, 'Day'),to_char(created_at, 'DD-MM-YYYY')")
      @monthly = IotDatum.select("to_char(created_at, 'Month') as month_name, sum(count) as actual, sum(target) as target, ROUND(((sum(count)::decimal/sum(target)::decimal) * 100),2) as progress").group("to_char(created_at, 'Month')")
      @yearly = IotDatum.select("extract(YEAR from created_at)::bigint as year_name, sum(count) as actual, sum(target) as target, ROUND(((sum(count)::decimal/sum(target)::decimal) * 100),2) as progress").group("extract(YEAR from created_at)")
    end

    @lb_result_cmp = IotDatum.select("employee_name, workbench_number, part_number, status, count, ROW_NUMBER() OVER (PARTITION BY status order by count desc)").where("status = 'Process Completed'").limit(5)
    @lb_result_pro = IotDatum.select("employee_name, workbench_number, part_number, status, target, count, RANK() OVER (PARTITION BY status order by count desc)").where("status = 'Processing'")
  end

  def download_report
    puts params[:chart_id]
    
    respond_to do |format|
      report_id = params[:chart_id]
      if report_id == 'ds'
        format.csv { send_data @@ds_wise.to_ds_csv, filename: "device_wise_report-#{Date.today}.csv" }
      elsif report_id == 'sp' 
        format.csv { send_data @@sp_wise.to_sp_csv, filename: "part_wise_report-#{Date.today}.csv" }
      end
    end
  end

  
  def show
  end

  
  def new
    @chart = Chart.new
  end

  
  def edit
  end

  
  def create
    @chart = Chart.new(chart_params)

    respond_to do |format|
      if @chart.save
        format.html { redirect_to @chart, notice: 'Chart was successfully created.' }
        format.json { render :show, status: :created, location: @chart }
      else
        format.html { render :new }
        format.json { render json: @chart.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    respond_to do |format|
      if @chart.update(chart_params)
        format.html { redirect_to @chart, notice: 'Chart was successfully updated.' }
        format.json { render :show, status: :ok, location: @chart }
      else
        format.html { render :edit }
        format.json { render json: @chart.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @chart.destroy
    respond_to do |format|
      format.html { redirect_to charts_url, notice: 'Chart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chart
      @chart = Chart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chart_params
      params.require(:chart).permit(:name)
    end
end
