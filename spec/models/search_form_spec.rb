require 'rails_helper'

RSpec.describe SearchForm, type: :model do
  describe "検索処理" do
    let!(:client) { create(:client) } 
    let!(:expert_tarou) { create(:expert) }
    let!(:expert_jiro) { create(:expert_jiro) }  
    let!(:expert_saburo) { create(:expert_saburo) }  
    let!(:expertise_tag) { create(:expertise_tag, expert: expert_tarou) }
    let!(:favorite_expert) { create(:favorite_expert, expert: expert_jiro, client: client) } 

    context "検索条件" do
      let!(:search_form) { SearchForm.new } 
      it "検索条件が無い場合は、全専門家が取得できること" do
        expect(search_form.search_expert.length).to eq Expert.all.count
      end
      it "検索キーワードに該当する専門家が取得できること" do
        search_form.keyword = expert_tarou.name
        expect(search_form.search_expert.length).to eq 1
        expect(search_form.search_expert).to contain_exactly(expert_tarou)
      end
      it "都道府県に該当する専門家が取得できること" do
        search_form.prefectures = "大阪府"
        be_addrest = -> expert {expert.office.address.include?("大阪府")}
        expect(search_form.search_expert).to all(satisfy &be_addrest)
      end
      it "職業に該当する専門家が取得できること" do
        search_form.job = expert_saburo.job
        expect(search_form.search_expert.length).to eq 1
        expect(search_form.search_expert).to contain_exactly(expert_saburo)
      end
      it "お悩みカテゴリに該当する専門家が取得できること" do
        search_form.category = expertise_tag.trouble_tag_id
        be_category = -> expert {expert.trouble_tags.map(&:name).join(',').include?(expertise_tag.trouble_tag.name)}
        expect(search_form.search_expert).to all(satisfy &be_category)
      end
      it "お気に入り専門家が取得できること" do
        search_form.favorite = true
        search_form.client_id = favorite_expert.client_id
        expect(search_form.search_expert.length).to eq 1
        expect(search_form.search_expert).to contain_exactly(expert_jiro)
      end
    end
  end
end