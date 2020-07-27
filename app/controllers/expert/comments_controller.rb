class Expert::CommentsController < Expert::Base

  def create
    @comment = Comment.new(comment_params)
    @comment = Comment.new if @comment.save
    set_comment_info
  end
  
  def update
    @comment = Comment.find_by_id(params[:id])
    @comment = Comment.new if @comment.update(comment_params)
    set_comment_info
  end
  
  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy
    set_comment_info
  end

  private
  # ストロングパラメーター
  def comment_params
    params.require(:comment)
      .permit(:content)
      .merge(problem_id: params[:problem_id], expert_id: current_expert.id)
  end

  def set_comment_info
    @problem = Problem.find_by_id(params[:problem_id])
    @comments = @problem.comments.includes(:client).includes(:expert)
  end
  
end
