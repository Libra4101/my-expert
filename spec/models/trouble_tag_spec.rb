require 'rails_helper'

RSpec.describe TroubleTag, type: :model do
  describe "正常系処理" do
    let(:trouble_tag) { build(:trouble_tag) } 
    context "必須項目が存在する場合" do
      it "有効であること" do
        expect(trouble_tag).to be_valid
      end
    end
  end
  
  describe "異常系処理" do
    # 必須項目チェック
    shared_examples "blank_check" do
      let!(:trouble_tag) { build(:trouble_tag, column => nil) }
      it {
        trouble_tag.valid?
        expect(trouble_tag.errors[column].join(',')).to include("入力してください")
      }
    end

    describe "必須項目チェック" do
      context "カテゴリ名がnilの場合" do
        let(:column) { :name } 
        it_behaves_like "blank_check"
      end
    end
  end
end
