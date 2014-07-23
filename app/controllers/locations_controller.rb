class LocationsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @locations = Location.sorted
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    respond_to do |format|
      if @location.save
        format.html { redirect_to locations_path, notice: "地點新增完成!"  }
      else
        format.html { render 'new' }
      end
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def edit
  end

  def update
  	
  end

  def destroy
  	@location = Location.find(params[:id])
    respond_to do |format|
      if @location.destroy
        #format.html { redirect_to locations_path, notice: "已刪除一個地點" }
        format.js { @locations = Location.sorted if Location.any? }
      else
        
      end
    end
  end

  private

    def location_params
      params.require(:location).permit(:name, :address, :description)
    end
end
