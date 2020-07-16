class Client::FavoritesController < Client::Base
  before_action :set_expert

  def create
    favorite = current_client.favorites.build(expert_id: @expert.id)
    favorite.save
  end

  def destroy
    favorite = Favorite.find_by(expert_id: @expert.id, client_id: current_client.id)
    favorite.destroy
  end

  private

  # 専門家情報を設定
  def set_expert
    @expert = Expert.find(params[:expert_id])
  end
end
