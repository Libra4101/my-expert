module Admin::AdminHelper

  # 選択中のサイドメニューのクラスを返す
  def sidebar_activate(sidebar_link_url)
    current_url = request.headers['PATH_INFO']
    if current_url.match(sidebar_link_url)
      ' class="active"'
    else
      ''
    end
  end

  # サイドメニューの項目を出力する
  def sidebar_list_items
    items = [
      {:text => '会員情報',      :path => admin_clients_path},
      {:text => '専門家情報',   :path => admin_experts_path},
      {:text => '職業マスタ情報',   :path => admin_jobs_path}
    ]

    html = ''
    items.each do |item|
      text = item[:text]
      path = item[:path]
      html = html + %Q(<li#{sidebar_activate(path)} class="nav-item"><a href="#{path}" class="d-block">#{text}</a></li>)
    end

    raw(html)
  end
end