require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "正常系処理" do
    let(:event) { build(:event) } 
    context "必須項目が存在する場合" do
      it "有効であること" do
        expect(event).to be_valid
      end
    end
  end
  
  describe "異常系処理" do
    # 必須項目チェック
    shared_examples "blank_check" do
      let!(:event) { build(:event, column => nil) }
      it {
        event.valid?
        expect(event.errors[column].join(',')).to include("入力してください")
      }
    end

    describe "必須項目チェック" do
      context "イベント名がnilの場合" do
        let(:column) { :title } 
        it_behaves_like "blank_check"
      end
      context "イベント開始日付がnilの場合" do
        let(:column) { :start_event_time } 
        it_behaves_like "blank_check"
      end
      context "イベント終了日付がnilの場合" do
        let(:column) { :end_event_time } 
        it_behaves_like "blank_check"
      end
    end
  end
end
