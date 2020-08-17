require 'rails_helper'

RSpec.describe Career, type: :model do

  describe "正常系処理" do
    let(:career) { build(:career) } 
    context "必須項目が存在する場合" do
      it "有効であること" do
        expect(career).to be_valid
      end
    end
  end

  describe "異常系処理" do

    # 必須項目チェック
    shared_examples "blank_check" do
      let!(:career) { build(:career, column => nil) }
      it {
        career.valid?
        expect(career.errors[column].join(',')).to include("入力してください")
      }
    end
    # 一意制約チェック
    shared_examples "unique_check" do
      let!(:career) { create(:career, column => test_data) }
      let!(:career_unique) { build(:career, column => test_data) }
      it {
        career_unique.valid?
        expect(career_unique.errors[column].join(',')).to include("すでに存在します")
      }
    end

    describe "必須項目チェック" do
      context "経歴日付がnilの場合" do
        let(:column) { :occurrence_date } 
        it_behaves_like "blank_check"
      end
      context "経歴内容がnilの場合" do
        let(:column) { :content } 
        it_behaves_like "blank_check"
      end
    end

    describe "一意制約チェック" do
      context "経歴内容がnilの場合" do
        let(:column) { :content } 
        let(:test_data) { "司法試験合格" } 
        it_behaves_like "unique_check"
      end
    end
  end
end
