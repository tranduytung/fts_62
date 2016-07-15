class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  has_many :results, dependent: :destroy

  enum status: {start: 0, test: 1, unchecked: 2, checked: 3}
end
