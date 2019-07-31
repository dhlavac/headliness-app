require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:headline) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:up_vote) }
  it { should validate_presence_of(:down_vote) }
end
