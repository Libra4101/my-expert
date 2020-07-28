class Expert::BookmarksController < Expert::Base
  before_action :set_problem

  def create
    bookmark = current_expert.bookmarks.build(problem_id: @problem.id)
    bookmark.save!
  end

  def destroy
    bookmark = Bookmark.find_by(problem_id: @problem.id, expert_id: current_expert.id)
    bookmark.destroy!
  end

  private

  # 投稿内容を取得
  def set_problem
    @problem = Problem.find(params[:problem_id])
  end
end
