class IotDataController < ApplicationController
  skip_before_filter :authenticate_user!
  # protect_from_forgery with: :null_session
  before_action :set_iot_datum, only: [:show, :edit, :update, :destroy]

  def index

    device_id = params[:device_id] if params[:device_id]
    count = params[:count] if params[:count]
    part = params[:part_number] if params[:part_number]
    @iot_data = IotDatum.where("device_id = ? and count = ? and part_number = ?", params[:device_id],params[:count], params[:part_number]) if device_id && count && part
      
      if params[:status] && params[:device_id]
        @iot_datas = IotDatum.where("status = ? and device_id = ?", 'Processing', params[:device_id]) 
        render json: @iot_datas
      end
      
    if device_id != nil && part != nil
      status = 'Processing'
      @iot_dataa = IotDatum.find_by(device_id: device_id, part_number: part, status: status) 
      @iot_dataa.part_number
      target = @iot_dataa.target if @iot_dataa
      if (count.to_i <= target.to_i && @iot_dataa.status = 'Processing')
        @iot_dataa.device_id = device_id
        @iot_dataa.count = count
        @iot_dataa.save! 
        if @iot_dataa.save
          seq_data_entry(@iot_dataa)
        end
      else count.to_i == 0
        redirect_to root_url, notice: 'Process Completed'
      end

      if count.to_i == target
        @iot_dataa.status = 'Process Completed'
        @iot_dataa.save!
      end
    end 

    @iot_data_yts = IotDatum.where("status = ?", 'YTS')
    @iot_data_pro = IotDatum.where("status = ?", 'Processing')
    @iot_data_comp = IotDatum.where("status = ?", 'Process Completed')
    
    @active_devices = WorkbenchMaster.where("machine_status = ?", 'A')
    @inactive_devices = WorkbenchMaster.where("machine_status = ?", 'IA')
    @completed_parts = IotDatum.where("status = ?", 'Process Completed')
    @processing_parts = IotDatum.where("status = ?", 'Processing')

    @duration = IotDatum.select("(updated_at - created_at) AS duration").where("status = ?", 'Process Completed')

    
  end

  
  def show
  end

  def download_report
    puts params[:chart_id]
    @@comp_rec = IotDatum.select("workbench_number, employee_name, shift, part_number, target, count, to_char(created_at, 'DD-MM-YYYY') as date, to_char(created_at, 'HH:MI:SS') as start_time, to_char(updated_at, 'HH:MI:SS') as end_time, to_char((updated_at - created_at),'HH24:MI:SS') as duration").where("status = ?", 'Process Completed')
    respond_to do |format|
      format.csv { send_data @@comp_rec.to_report_csv, filename: "ics_report-#{Date.today}.csv" }
    end
    
  end

  def seq_data_entry(data)
    @tracker = Tracker.new
    @tracker.wb_id = data.workbench_number
    @tracker.part_code = data.part_number
    @tracker.employee_id = data.employee_id
    @tracker.shift = data.shift
    @tracker.target = data.target
    @tracker.device_id = data.device_id
    @tracker.count = data.count
    @tracker.save!
  end

  def process_start

      id = params[:iot_datum_id]
        @process_rec = IotDatum.find_by(id: id) if id
        deviceId = @process_rec.device_id
        part_number = @process_rec.part_number
        
        @iot_data = IotDatum.where("device_id = ? and status = ?", deviceId, 'YTS');
        @uniq_data = IotDatum.where("device_id = ? and part_number = ? and status = ?", deviceId, part_number, 'Processing');
        puts @uniq_data.count
        puts "2 begin"
        if @uniq_data.count == 0
            @process_rec.status = 'Processing'
            @process_rec.save!
            redirect_to iot_data_path, notice: 'Process Started'
            puts " 0 start"
        else
          @uniq_data.each do |u|
            puts u.part_number
            puts u.device_id
            puts part_number
            if (u.part_number == part_number && u.device_id == deviceId)
              puts "Validate"
              redirect_to iot_data_path, alert: "Part code #{part_number} is running on device No. #{deviceId}. Please Wait to complete"
            else
              puts "other part start----"
              @process_rec.status = 'Processing'
              @process_rec.save!
              redirect_to iot_data_path, notice: 'Process Started'
              puts "other part end----"
            end
          end
        end
      # else
      #   puts "-----#{seq_data.id}---seq id----"
      #   @seq = seq_data.id + 1
      #   puts @seq
      #   @iot_data = IotDatum.find_by(id: @seq) 
      #   @iot_data.status = 'Processing'
      #   @iot_data.save!
      # end

      # device_id = @iot_data.device_id
      # part_no = @iot_data.part_number
      # target = @iot_data.target
      # lot_size = @iot_data.lot_size
      # @iot_datas = IotDatum.where("device_id = ? and part_number = ? and target = ? and lot_size = ?", device_id, part_no, target, lot_size) if @iot_data
      # puts @iot_datas.inspect
      # puts @iot_data.inspect
      # render json: @iot_data

      # require 'net/http'
      # # t = Thread.start do
      #   uri = URI('http://192.168.1.112')
      #   res = Net::HTTP.post_form(uri, 'q' => 'ruby', 'max' => '50')
      #   puts res.body
      # # end
      # # t.kill
      
      # respond_to do |format|
      #   format.json { render :json, status: :created, location: @iot_data }
      # end
    # @iot_data = IotDatum.where("device_id = ? and count = ?", params[:device_id],params[:count]) if device_id && count
      # redirect_to iot_data_path, notice: 'Process Started'
  end

  def import
    IotDatum.import(params[:file])
    redirect_to iot_data_path, notice: 'Data imported.'
  end

  # GET /iot_data/new
  def new
    @iot_datum = IotDatum.new
  end

  # GET /iot_data/1/edit
  def edit
  end

  # POST /iot_data
  # POST /iot_data.json
  def create
    @iot_datum = IotDatum.new(iot_datum_params)

    respond_to do |format|
      if @iot_datum.save
        format.html { redirect_to @iot_datum, notice: 'Iot datum was successfully created.' }
        format.json { render :show, status: :created, location: @iot_datum }
      else
        format.html { render :new }
        format.json { render json: @iot_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /iot_data/1
  # PATCH/PUT /iot_data/1.json
  def update
    respond_to do |format|
      if @iot_datum.update(iot_datum_params)
        format.html { redirect_to @iot_datum, notice: 'Iot datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @iot_datum }
      else
        format.html { render :edit }
        format.json { render json: @iot_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /iot_data/1
  # DELETE /iot_data/1.json
  def destroy
    puts @iot_datum.count
    if @iot_datum.count > 0
      @deleted_rec = IotDatum.new
      @deleted_rec.workbench_number = @iot_datum.workbench_number
      @deleted_rec.part_number = @iot_datum.part_number
      @deleted_rec.target = @iot_datum.target
      @deleted_rec.lot_size = @iot_datum.lot_size
      @deleted_rec.employee_name = @iot_datum.employee_name
      @deleted_rec.shift = @iot_datum.shift
      @deleted_rec.device_id = @iot_datum.device_id
      @deleted_rec.count = @iot_datum.count
      @deleted_rec.status = 'Deleted'
      @deleted_rec.save!
      @iot_datum.destroy
    else
      @iot_datum.destroy
    end
    respond_to do |format|
      format.html { redirect_to iot_data_url, notice: 'Planner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_iot_datum
      @iot_datum = IotDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def iot_datum_params
      params.require(:iot_datum).permit(:workbench_number, :part_number, :target, :lot_size, :employee_name, :employee_id, :shift, :device_id, :count, :status)
    end
end
