class Comment < ApplicationRecord
  belongs_to :headline

  validates_presence_of :author, :up_vote, :down_vote

end
