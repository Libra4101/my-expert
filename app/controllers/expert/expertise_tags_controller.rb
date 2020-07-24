class Expert::ExpertiseTagsController < Expert::Base

  def create
    @expertise_tag = current_expert.expertise_tags.new(expertise_tag_param)
    if @expertise_tag.save
      @expertise_tags = current_expert.expertise_tags.includes(:trouble_tag)
      @expertise_tag = current_expert.expertise_tags.new
    end
  end

  def destroy
    @expertise_tag = current_expert.expertise_tags.find_by_id(params[:tag_id])
    if @expertise_tag.destroy
      @expertise_tags = current_expert.expertise_tags.includes(:trouble_tag)
    end
  end

  private
  # ストラングパラメーター
  def expertise_tag_param
    params.require(:expertise_tag)
    .permit(:trouble_tag_id)
    .merge(expert_id: current_expert.id)
  end
end
