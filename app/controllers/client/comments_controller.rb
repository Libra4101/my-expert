class Client::CommentsController < Client::Base
  before_action :set_problem, only: %i[create destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.save
  end

  def destroy
    @comment = @problem.comments.find_by_id(params[:id])
    @comment.destroy
  end
  
  private

  # ストロングパラメーター
  def comment_params
    params.require(:comment)
      .permit(:content)
      .merge(problem_id: params[:problem_id], client_id: current_client.id)
  end
  
  # 投稿情報を設定
  def set_problem
    @problem = Problem.find_by(id: params[:problem_id], client_id: current_client.id)
  end
end
