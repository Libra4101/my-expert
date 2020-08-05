require 'rails_helper'

RSpec.describe Admin, type: :model do

  describe "正常系処理" do
    let(:admin) { build(:admin) } 
    context "必須項目が存在する場合" do
      it "有効であること" do
        expect(admin).to be_valid
      end
    end
  end

  describe "異常系処理" do

    # 必須項目チェック
    shared_examples "blank_check" do
      let!(:admin) { build(:admin, column => nil) }
      it {
        admin.valid?
        expect(admin.errors[column].join(',')).to include("入力してください")
      }
    end

    describe "必須項目チェック" do
      context "メールアドレスがnilの場合" do
        let(:column) { :email } 
        it_behaves_like "blank_check"
      end
      context "パスワードがnilの場合" do
        let(:column) { :password } 
        it_behaves_like "blank_check"
      end
    end
  end
end
