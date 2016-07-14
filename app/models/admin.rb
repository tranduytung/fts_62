class Admin < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: {maximum: 50}
  validates :chatwork_id, presence: true, length: {maximum: 50}

  def password_required?
    new_record? ? super : false
  end
end
