require 'rails_helper'

RSpec.describe Consultation, type: :model do
  describe "正常系処理" do
    let(:consultation) { build(:consultation) } 
    context "必須項目が存在する場合" do
      it "有効であること" do
        expect(consultation).to be_valid
      end
    end
  end
  
  describe "異常系処理" do
    # 必須項目チェック
    shared_examples "blank_check" do
      let!(:consultation) { build(:consultation, column => nil) }
      it {
        consultation.valid?
        expect(consultation.errors[column].join(',')).to include("入力してください")
      }
    end
    # 桁あふれチェック
    shared_examples "overflow_check" do
      let!(:consultation) { build(:consultation, column => "a"*(count+1)) }
      it {
        consultation.valid?
        expect(consultation.errors[column].join(',')).to include("#{count}文字以内で入力してください")
      }
    end

    describe "必須項目チェック" do
      context "お悩み内容がnilの場合" do
        let(:column) { :content } 
        it_behaves_like "blank_check"
      end
      context "会員IDがnilの場合" do
        let(:column) { :client_id } 
        it_behaves_like "blank_check"
      end
      context "専門家IDがnilの場合" do
        let(:column) { :expert_id } 
        it_behaves_like "blank_check"
      end
      context "予約IDがnilの場合" do
        let(:column) { :event_id } 
        it_behaves_like "blank_check"
      end
      context "相談カテゴリがnilの場合" do
        let(:column) { :trouble_tag_id } 
        it_behaves_like "blank_check"
      end
    end

    describe "桁数チェック" do
      context "相談内容が2500桁以上の場合" do
        let(:column) { :content }
        let(:count) { 2500 } 
        it_behaves_like "overflow_check"
      end
    end
  end
end
