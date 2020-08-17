class Admin::OfficesController < Admin::Base
  before_action :set_office, only: %i[edit update]
  before_action :set_expert, only: %i[new edit update]

  def new
    @office = Office.new
  end
  
  def create

    unless  @office = Office.find_by(name: office_param[:name], email: office_param[:email])
      @office = Office.new(office_param)
    end
    @expert = Expert.new(session[:expert])

    if @office.save
      @expert.office_id = @office.id
      @expert.save!
      session[:expert].clear
      flash[:success] = t('success.create', data: @expert.name)
      redirect_to admin_expert_url(@expert)
    else
      flash.now[:error] = t('error.validate_error') 
      render :new
    end
  end

  def edit
    gon.latitude = @office.latitude
    gon.longitude = @office.longitude
  end

  def update
    if @office.update(office_param)
      flash[:success] = t('success.update_profile')
      redirect_to admin_expert_url(params[:expert_id])
    else
      flash.now[:error] = t('error.validate_error')
      render template: 'admin/offices/edit'
    end
  end

  private
  def set_expert
    @expert = Expert.find_by(id: params[:expert_id])
  end

  def set_office
    @office = Office.find(params[:id])
  end

  # ストラングパラメーター
  def office_param
    params.require(:office)
    .permit(
      :email,
      :name,
      :tel,
      :postcode,
      :address,
      :reception_start_time,
      :reception_end_time
    )
  end
end
