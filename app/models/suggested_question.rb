class SuggestedQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  delegate :subject, to: :question
end
