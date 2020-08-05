require 'rails_helper'

RSpec.describe Job, type: :model do
  describe "正常系処理" do
    let(:job) { build(:job) } 
    context "必須項目が存在する場合" do
      it "有効であること" do
        expect(job).to be_valid
      end
    end
  end
  
  describe "異常系処理" do
    # 必須項目チェック
    shared_examples "blank_check" do
      let!(:job) { build(:job, column => nil) }
      it {
        job.valid?
        expect(job.errors[column].join(',')).to include("入力してください")
      }
    end
    # 桁あふれチェック
    shared_examples "overflow_check" do
      let!(:job) { build(:job, column => "a"*(count+1)) }
      it {
        job.valid?
        expect(job.errors[column].join(',')).to include("#{count}文字以内で入力してください")
      }
    end

    describe "必須項目チェック" do
      context "職業名がnilの場合" do
        let(:column) { :title } 
        it_behaves_like "blank_check"
      end
      context "職業説明がnilの場合" do
        let(:column) { :content } 
        it_behaves_like "blank_check"
      end
    end

    describe "桁数チェック" do
      context "職業説明が250桁以上の場合" do
        let(:column) { :content }
        let(:count) { 250 } 
        it_behaves_like "overflow_check"
      end
    end
  end
end
