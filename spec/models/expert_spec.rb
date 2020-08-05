require 'rails_helper'

RSpec.describe Expert, type: :model do

  describe "正常系処理" do
    let(:expert) { build(:expert) } 
    context "必須項目が存在する場合" do
      it "有効であること" do
        expect(expert).to be_valid
      end
    end
  end

  describe "異常系処理" do

    # 必須項目チェック
    shared_examples "blank_check" do
      let!(:expert) { build(:expert, column => nil) }
      it {
        expert.valid?
        expect(expert.errors[column].join(',')).to include("入力してください")
      }
    end
    # 桁あふれチェック
    shared_examples "overflow_check" do
      let!(:expert) { build(:expert, column => "a"*(count+1)) }
      it {
        expert.valid?
        expect(expert.errors[column].join(',')).to include("#{count}文字以内で入力してください")
      }
    end
    # 入力形式チェック
    shared_examples "format_check" do
      let!(:expert) { build(:expert, column => test_format_data) }
      it {
        expert.valid?
        expect(expert.errors[column].join(',')).to include("不正な値です")
      }
    end
    # 数字チェック
    shared_examples "numericality_check" do
      let!(:expert) { build(:expert, column => test_data) }
      it {
        expert.valid?
        expect(expert.errors[column].join(',')).to include("数値で入力してください")
      }
    end
    # 一意制約チェック
    shared_examples "unique_check" do
      let!(:expert) { create(:expert, column => test_data) }
      let!(:expert_unique) { build(:expert, column => test_data) }
      it {
        expert_unique.valid?
        expect(expert_unique.errors[column].join(',')).to include("すでに存在します")
      }
    end

    describe "必須項目チェック" do
      context "名前がnilの場合" do
        let(:column) { :name } 
        it_behaves_like "blank_check"
      end
      context "フリガナがnilの場合" do
        let(:column) { :name_kana } 
        it_behaves_like "blank_check"
      end
      context "メールアドレスがnilの場合" do
        let(:column) { :email } 
        it_behaves_like "blank_check"
      end
      context "パスワードがnilの場合" do
        let(:column) { :password } 
        it_behaves_like "blank_check"
      end
      context "電話番号がnilの場合" do
        let(:column) { :phone_number } 
        it_behaves_like "blank_check"
      end
    end

    describe "桁数チェック" do
      context "名前が60桁以上の場合" do
        let(:column) { :name }
        let(:count) { 60 } 
        it_behaves_like "overflow_check"
      end
      context "フリガナが75桁以上の場合" do
        let(:column) { :name_kana }
        let(:count) { 75 } 
        it_behaves_like "overflow_check"
      end
      context "自己紹介が2500桁以上の場合" do
        let(:column) { :introduction }
        let(:count) { 2500 } 
        it_behaves_like "overflow_check"
      end
    end

    describe "入力形式チェック" do
      context "メールアドレスの入力形式が異なる場合" do
        let(:column) { :email }
        let(:test_format_data) { "testtesttest" } 
        it_behaves_like "format_check"
      end
      context "電話番号の入力形式が異なる場合" do
        let(:column) { :phone_number }
        let(:test_format_data) { "0-00" } 
        it_behaves_like "format_check"
      end
    end

    describe "数値チェック" do
      context "年齢が数字以外の場合" do
        let(:column) { :age }
        let(:test_data) { "test" } 
        it_behaves_like "numericality_check"
      end
    end

    describe "一意成約チェック" do
      context "同一メールアドレスで登録した場合" do
        let(:column) { :email }
        let(:test_data) { "yamamoto@example.com" } 
        it_behaves_like "unique_check"
      end
    end
  end
end
