class Expert::CareersController < Expert::Base

  def create
    @career = current_expert.careers.new(career_param)
    if @career.save
      @careers = current_expert.careers
      @career = current_expert.careers.new
    end
  end

  def destroy
    @career = current_expert.careers.find_by_id(params[:career_id])
    if @career.destroy
      @careers = current_expert.careers
    end
  end
  
  private
  # ストラングパラメーター
  def career_param
    params.require(:career)
    .permit(
      :occurrence_date,
      :content
    )
  end
end
