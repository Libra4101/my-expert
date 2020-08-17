require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe "正常系処理" do
    let!(:comment) { build(:comment) } 
    let(:expert) { create(:expert) }  
    context "必須項目が存在する場合" do
      it "会員コメントの投稿できること" do
        comment.client_id = comment.client_id
        expect(comment).to be_valid
      end
      it "専門家コメントの投稿できること" do
        comment.expert_id = expert.id
        expect(comment).to be_valid
      end
    end
  end
  
  describe "異常系処理" do
    # 必須項目チェック
    shared_examples "blank_check" do
      let!(:comment) { build(:comment, column => nil) }
      it {
        comment.valid?
        expect(comment.errors[column].join(',')).to include("入力してください")
      }
    end
    # 桁あふれチェック
    shared_examples "overflow_check" do
      let!(:comment) { build(:comment, column => "a"*(count+1)) }
      it {
        comment.valid?
        expect(comment.errors[column].join(',')).to include("#{count}文字以内で入力してください")
      }
    end

    describe "必須項目チェック" do
      context "お悩み内容がnilの場合" do
        let(:column) { :content } 
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
