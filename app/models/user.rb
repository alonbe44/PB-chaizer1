class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :power_banks

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: %w[admin normal] }
  def admin?
    self.role == 'admin'
  end
  def to_param
    id.to_s
  end
  def normal?
    role == 'normal'
  end
end
