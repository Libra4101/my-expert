require 'rails_helper'

RSpec.describe Client, type: :model do 

  describe "正常系処理" do
    let(:client) { build(:client) }
    it "名前、メール、パスワードがある場合は有効" do
      expect(client).to be_valid
    end
  end

  describe "異常系処理" do

    # 必須項目チェック
    shared_examples "blank_check" do
      let!(:client) { build(:client, column => nil) }
      it {
        client.valid?
        expect(client.errors[column].join(',')).to include("入力してください")
      }
    end
    # 桁あふれチェック
    shared_examples "overflow_check" do
      let!(:client) { build(:client, column => "a"*(count+1)) }
      it {
        client.valid?
        expect(client.errors[column].join(',')).to include("#{count}文字以内で入力してください")
      }
    end
    # 入力形式チェック
    shared_examples "format_check" do
      let!(:client) { build(:client, column => test_format_data) }
      it {
        client.valid?
        expect(client.errors[column].join(',')).to include("不正な値です")
      }
    end
    # 数字チェック
    shared_examples "numericality_check" do
      let!(:client) { build(:client, column => test_data) }
      it {
        client.valid?
        expect(client.errors[column].join(',')).to include("数値で入力してください")
      }
    end


    describe "必須項目チェック" do
      context "名前がnilの場合" do
        let(:column) { :name } 
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
      context "住所が160桁以上の場合" do
        let(:column) { :address }
        let(:count) { 160 } 
        it_behaves_like "overflow_check"
      end
    end

    describe "入力形式チェック" do
      context "メールアドレスの入力形式が異なる場合" do
        let(:column) { :email }
        let(:test_format_data) { "testtesttest" } 
        it_behaves_like "format_check"
      end
      context "郵便番号の入力形式が異なる場合" do
        let(:column) { :postcode }
        let(:test_format_data) { "9999-9999" } 
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
      let!(:client) { create(:client) }
      context "同一メールアドレスで登録した場合" do
        let!(:client_unique_email) { build(:client) }
        it "一意制約エラーになること" do
          client_unique_email.valid?
          expect(client_unique_email.errors[:email].join(',')).to include("は既に登録されています。")
        end
      end
    end
  end
end
