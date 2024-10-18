require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(
      "pending" => "pending",
      "in_progress" => "in_progress",
      "completed" => "completed",
      "failed" => "failed"
    ).backed_by_column_of_type(:string) }
  end
end
