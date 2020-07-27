class Expert::OfficesController < Expert::Base
  before_action :set_expert, only: %i[create update]

  def create
    @office = @expert.office.new(office_param)
    if @office.save
      flash[:success] = t('success.update_profile')
      redirect_to edit_expert_experts_url
    else
      @career = @expert.careers.new
      @expertise_tag = @expert.expertise_tags.new
      render template: 'expert/experts/edit'
    end
  end
  
  def update
    @office = Office.find_by_id(params[:office_id])
    if @office.update(office_param)
      flash[:success] = t('success.update_profile')
      redirect_to edit_expert_experts_url
    else
      @career = @expert.careers.new
      @expertise_tag = @expert.expertise_tags.new
      render template: 'expert/experts/edit'
    end
  end
  

  private
  # プロフィール情報を設定
  def set_expert
    @expert = Expert.find_by_id(current_expert.id)
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
