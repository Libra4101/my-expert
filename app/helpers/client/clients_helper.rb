module Client::ClientsHelper
  # プロフィール未登録表示
  def show_unregistered(attribute)
    return "未登録" if attribute.blank?
  end

  # 並び順 お悩み内容
  def select_sort_problem_list
    {
      "新着順" => "new_sort",
      "更新順" => "update_sort",
      "コメントが多い順" => "many_coment_sort",
      "コメントが新しい順" => "new_coment_sort"
    }
  end

  # 相談状況リスト
  def select_sort_consultation_list
    return { "全て" => "all" }.merge(Consultation.reservation_statuses_i18n.invert)
  end

  # タブ初期化処理
  def active?(nav_type, tab_name)
    if nav_type.blank? && tab_name == 'expert'
      'active'
    elsif nav_type == tab_name
      'active'
    end
  end
  
end
