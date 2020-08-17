require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "正常系処理" do
    let(:favorite) { build(:favorite) } 
    context "必須項目が存在する場合" do
      it "有効であること" do
        expect(favorite).to be_valid
      end
    end
  end
  
  describe "異常系処理" do
    # 必須項目チェック
    shared_examples "blank_check" do
      let!(:favorite) { build(:favorite, column => nil) }
      it {
        favorite.valid?
        expect(favorite.errors[column].join(',')).to include("入力してください")
      }
    end

    describe "必須項目チェック" do
      context "専門家IDがnilの場合" do
        let(:column) { :expert_id } 
        it_behaves_like "blank_check"
      end
      context "会員IDがnilの場合" do
        let(:column) { :client_id } 
        it_behaves_like "blank_check"
      end
    end
  end
end
