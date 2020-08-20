module Client::ExpertsHelper
  # お気に入りチェックボックス初期値
  def favorite_status(status)
    "checked" if status == "true" || status == "1"
  end
  
end
