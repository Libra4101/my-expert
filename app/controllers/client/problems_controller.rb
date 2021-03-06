class Client::ProblemsController < Client::Base
  before_action :set_problem, only: %i[show update destroy]
  before_action :set_comment, only: %i[show update destroy]

  def new
    @problem = Problem.new
  end

  def create
    @problem = current_client.problems.build(problem_params)
    if @problem.save
      flash[:success] = t('success.create_problem')
      redirect_to problem_url(@problem)
    else
      flash.now[:error] =t('error.validate_error') 
      render :new
    end
  end
  
  def show
    limit_show_problem(@problem)
  end

  def update
    if @problem.update(problem_params)
      flash[:success] = t('success.update_problem')
      redirect_to problem_url(@problem)
    else
      flash.now[:error] = t('error.validate_error')
      render :show
    end
  end
  
  def destroy
    if @problem.destroy
      flash[:success] = t('success.destroy_problem')
      redirect_to clients_url(nav_type: 'problems')
    else
      flash[:success] = t('error.delete_error')
      render :show
    end
  end
  
  private
  # ストロングパラメータ
  def problem_params
    params.require(:problem)
      .permit(:priority_status,:content)
      .merge(trouble_tag_id: get_trouble_tag_id)
  end

  # 投稿内容を設定
  def set_problem
    @problem = current_client.problems.find_by_id(params[:id])
  end

  # 投稿コメントを設定
  def set_comment
    @comment = current_client.comments.new
  end
  
  # お悩みカテゴリIDを取得
  def get_trouble_tag_id
    trouble_category = TroubleTag.find_by_id(params[:problem][:trouble_tag_id].to_i)
    trouble_category.id if trouble_category
  end

  # 投稿内容の閲覧制限
  def limit_show_problem(problem)
    correct_client?(problem&.client_id)
  end
end
