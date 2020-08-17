require 'rails_helper'

RSpec.describe ExpertiseTag, type: :model do
  describe "正常系処理" do
    let(:expertise_tag) { build(:expertise_tag) } 
    context "必須項目が存在する場合" do
      it "有効であること" do
        expect(expertise_tag).to be_valid
      end
    end
  end
  
  describe "異常系処理" do
    # 必須項目チェック
    shared_examples "blank_check" do
      let!(:expertise_tag) { build(:expertise_tag, column => nil) }
      it {
        expertise_tag.valid?
        expect(expertise_tag.errors[column].join(',')).to include("入力してください")
      }
    end

    describe "必須項目チェック" do
      context "専門家IDがnilの場合" do
        let(:column) { :expert_id } 
        it_behaves_like "blank_check"
      end
      context "カテゴリIDがnilの場合" do
        let(:column) { :trouble_tag_id } 
        it_behaves_like "blank_check"
      end
    end
  end
end
