class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :validatable, :omniauthable

  has_many :suggested_questions, dependent: :destroy
  has_many :exams, dependent: :destroy

  validates :name, presence: true
  validates :chatwork_id, presence: true

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.name = auth.info.name
        user.email = auth.info.email
      end
    end

    def new_with_session params, session
      if session["devise.user_attributes"]
        new session["devise.user_attributes"], without_protection: true do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end
    end
  end

  def password_required?
    super && provider.blank?
  end
end
