class SearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  attr_accessor :keyword, :prefectures, :job, :category, :favorite, :order_pattern, :client_id
  
  def search_expert
    #--- 条件に合致する専門家を取得 ---#
    @experts = Expert
              .where(public_status: true)
              .left_joins(:office)
              .includes(:office)
              .includes(:job)
              .includes(:expertise_tags)
              .includes(:trouble_tags)
              .left_joins(:favorites)
              .select("distinct experts.*")

    # 検索ワードに該当
    if self.keyword.present?
      @experts = @experts.where("experts.name = ? OR offices.name = ?", keyword, keyword)
    end

    # 都道府県を指定
    if self.prefectures.present?
      @experts = @experts.where("offices.address LIKE ?", "%#{self.prefectures}%")
    end

    # 職業名を指定
    if self.job.present?
      @experts = @experts.where(jobs: {id: self.job})
    end

    # お悩みカテゴリ
    if self.category.present?
      @experts = @experts.where(expertise_tags: {trouble_tag_id: category})
    end

    # お気に入り判定
    if self.favorite.present?
      @experts = @experts.where(favorites: {client_id: client_id})
    end

    return @experts
  end

end
