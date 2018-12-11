class TrackersController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_tracker, only: [:show, :edit, :update, :destroy]

  # GET /trackers
  # GET /trackers.json
  def index
    @trackers = Tracker.all
  end

  # GET /trackers/1
  # GET /trackers/1.json
  def show
    # render js: "alert('The number is: #{params[:id]}')"
  end

  def new
    @tracker = Tracker.new
  end

  def search
    @track_filter = Tracker.select("wb_id, part_code, employee_id, shift, device_id, count, target, to_char(created_at,'yyyy-mm-dd HH12:MI:SS') as datetime").where("to_char(created_at,'yyyy-mm-dd') >= ? and to_char(created_at,'yyyy-mm-dd') <= ?", params[:created_at],params[:updated_at]).order(:part_code)
    respond_to do |format|
      format.csv { send_data @track_filter.to_csv, filename: 'tracker_report.csv' }
    end


  end

  # GET /trackers/1/edit
  def edit
  end

  # POST /trackers
  # POST /trackers.json
  def create
    @tracker = Tracker.new(tracker_params)

    respond_to do |format|
      if @tracker.save
        format.html { redirect_to @tracker, notice: 'Tracker was successfully created.' }
        format.json { render :show, status: :created, location: @tracker }
      else
        format.html { render :new }
        format.json { render json: @tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trackers/1
  # PATCH/PUT /trackers/1.json
  def update
    respond_to do |format|
      if @tracker.update(tracker_params)
        format.html { redirect_to @tracker, notice: 'Tracker was successfully updated.' }
        format.json { render :show, status: :ok, location: @tracker }
      else
        format.html { render :edit }
        format.json { render json: @tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trackers/1
  # DELETE /trackers/1.json
  def destroy
    @tracker.destroy
    respond_to do |format|
      format.html { redirect_to trackers_url, notice: 'Tracker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tracker
      @tracker = Tracker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tracker_params
      params.require(:tracker).permit(:wb_id, :part_code, :employee_id, :shift, :device_id, :count, :created_at, :updated_at)
    end
end
