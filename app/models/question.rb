class Question < ActiveRecord::Base
  belongs_to :subject

  has_one :suggested_question, dependent: :destroy

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
end
