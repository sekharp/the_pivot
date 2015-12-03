class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :projects

  validates :username, presence: true,
                       uniqueness: true
  validates :password, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :slug, presence: true

  before_validation :set_slug

  enum role: %w(default admin)

  def set_slug
    self.slug = full_name.parameterize
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
