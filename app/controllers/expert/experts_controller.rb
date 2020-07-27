class Expert::ExpertsController < Expert::Base
  before_action :set_expert, only: %i[show edit update]

  def show
    gon.expert_office = @expert.office
  end

  def edit
    @career = @expert.careers.new
    @expertise_tag = @expert.expertise_tags.new
    @office = @expert.office
  end

  def update
    if @expert.update(expert_param)
      flash[:success] = t('success.update_profile')
      redirect_to edit_expert_experts_url
    else
      @career = @expert.careers.new
      @expertise_tag = @expert.expertise_tags.new
      @office = Office.new
      flash.now[:error] = t('error.validate_error')
      render :edit
    end
  end
  
  private

  # プロフィール情報を設定
  def set_expert
    @expert = Expert.find_by_id(current_expert.id)
  end

  # ストラングパラメーター
  def expert_param
    params.require(:expert)
    .permit(
      :avater_image,
      :email,
      :name,
      :name_kana,
      :gender,
      :age,
      :phone_number,
      :public_status,
      :introduction
    )
  end
end
