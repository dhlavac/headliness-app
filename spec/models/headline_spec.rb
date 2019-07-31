require 'rails_helper'

RSpec.describe Headline, type: :model do
  it { should have_many(:comments).dependent(:destroy) }
  it { should validate_presence_of(:text) }
end
