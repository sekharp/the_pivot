class Project < ActiveRecord::Base
  validates :title, presence: true,
                    uniqueness: true
  validates :goal_amount, presence: true
  validates :slug, presence: true
  # has_many :order_stickers
  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user
  has_many :loans

  before_validation :set_slug

  def set_slug
    self.slug = title.parameterize
  end
end
