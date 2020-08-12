class Admin::TroubleTagsController < Admin::Base
  before_action :set_trouble_tag, only: %i[update destroy]
  before_action :set_trouble_tag_list, only: %i[index create update]

  def index
    @trouble_tag = TroubleTag.new
  end

  def create
    @trouble_tag = TroubleTag.new(trouble_tag_param)
    if @trouble_tag.save
      flash[:success] = t('success.create', data: @trouble_tag.name)
      redirect_to admin_trouble_tags_url
    else
      flash.now[:error] = t('error.validate_error')
      render :index
    end
  end

  def update
    if @trouble_tag.update(trouble_tag_param)
      flash[:success] = t("success.update", data: @trouble_tag.name)
      redirect_to admin_trouble_tags_url
    else
      flash.now[:error] = t("error.validate_error")
      render :index
    end
  end
  
  def destroy
    if @trouble_tag.destroy
      flash[:success] = t("success.delete", data: @trouble_tag.name)
      redirect_to admin_trouble_tags_url
    else
      flash[:error] = t("error.delete_error")
      redirect_to admin_trouble_tags_url
    end
  end

  private

  def set_trouble_tag
    @trouble_tag = TroubleTag.find(params[:id])
  end

  def set_trouble_tag_list
    @trouble_tags = TroubleTag.page(params[:page]).per(5)
  end

  # ストラングパラメーター
  def trouble_tag_param
    params.require(:trouble_tag)
      .permit(:name)
  end
end
