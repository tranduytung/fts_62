class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :validatable

  has_many :suggested_questions, dependent: :destroy
  has_many :exams, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}
  validates :chatwork_id, presence: true, length: {maximum: 50}

  def password_required?
    new_record? ? super : false
  end
end
