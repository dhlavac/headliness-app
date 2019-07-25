class Headline < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates_presence_of :text
end
