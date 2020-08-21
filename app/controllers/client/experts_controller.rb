class Client::ExpertsController < Client::Base
  def index
    @searchForm = new_search_info
    @experts = @searchForm.search_expert
  end

  def show
    @expert = Expert.find(params[:id])
    gon.latitude = @expert.office.latitude
    gon.longitude =  @expert.office.longitude
  end

  private

  # ストラングパラメーター
  def set_search_form_params
    params.require(:search_form)
      .permit(:keyword, :prefectures, :job, :category, :favorite)
      .merge(client_id: current_client.id)
  end

  def new_search_info
    if params[:search_form].present?
      SearchForm.new(set_search_form_params)
    else
      SearchForm.new
    end
  end
  
end
