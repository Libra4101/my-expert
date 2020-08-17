require 'rails_helper'

RSpec.describe Office, type: :model do
  describe "正常系処理" do
    let(:office) { build(:office) } 
    context "必須項目が存在する場合" do
      it "有効であること" do
        expect(office).to be_valid
      end
    end
  end

  describe "異常系処理" do

    # 必須項目チェック
    shared_examples "blank_check" do
      let!(:office) { build(:office, column => nil) }
      it {
        office.valid?
        expect(office.errors[column].join(',')).to include("入力してください")
      }
    end
    # 桁あふれチェック
    shared_examples "overflow_check" do
      let!(:office) { build(:office, column => "a"*(count+1)) }
      it {
        office.valid?
        expect(office.errors[column].join(',')).to include("#{count}文字以内で入力してください")
      }
    end
    # 入力形式チェック
    shared_examples "format_check" do
      let!(:office) { build(:office, column => test_format_data) }
      it {
        office.valid?
        expect(office.errors[column].join(',')).to include("不正な値です")
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
      context "受付開始時間がnilの場合" do
        let(:column) { :reception_start_time } 
        it_behaves_like "blank_check"
      end
      context "受付終了時間がnilの場合" do
        let(:column) { :reception_end_time } 
        it_behaves_like "blank_check"
      end
    end

    describe "桁数チェック" do
      context "名前が60桁以上の場合" do
        let(:column) { :name }
        let(:count) { 60 } 
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
      context "電話番号の入力形式が異なる場合" do
        let(:column) { :tel }
        let(:test_format_data) { "0-00" } 
        it_behaves_like "format_check"
      end
      context "郵便番号の入力形式が異なる場合" do
        let(:column) { :postcode }
        let(:test_format_data) { "9999-9999" } 
        it_behaves_like "format_check"
      end
    end
  end
end
