require 'rails_helper'

RSpec.describe Problem, type: :model do

  describe "正常系処理" do
    let(:problem) { build(:problem) } 
    context "必須項目が存在する場合" do
      it "有効であること" do
        expect(problem).to be_valid
      end
    end
  end
  
  describe "異常系処理" do
    # 必須項目チェック
    shared_examples "blank_check" do
      let!(:problem) { build(:problem, column => nil) }
      it {
        problem.valid?
        expect(problem.errors[column].join(',')).to include("入力してください")
      }
    end
    # 桁あふれチェック
    shared_examples "overflow_check" do
      let!(:problem) { build(:problem, column => "a"*(count+1)) }
      it {
        problem.valid?
        expect(problem.errors[column].join(',')).to include("#{count}文字以内で入力してください")
      }
    end

    describe "必須項目チェック" do
      context "お悩み内容がnilの場合" do
        let(:column) { :content } 
        it_behaves_like "blank_check"
      end
      context "優先度がnilの場合" do
        let(:column) { :priority_status } 
        it_behaves_like "blank_check"
      end
      context "お悩みカテゴリがnilの場合" do
        let(:column) { :trouble_tag_id } 
        it_behaves_like "blank_check"
      end
    end

    describe "桁数チェック" do
      context "お悩み内容が2500桁以上の場合" do
        let(:column) { :content }
        let(:count) { 2500 } 
        it_behaves_like "overflow_check"
      end
    end
  end
end
