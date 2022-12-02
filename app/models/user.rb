class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :books, dependent: :destroy
  
  validates :name, length: { minimum: 2, maximum: 20}, uniqueness: { case_sensitive: false }
  validates :introduction, length: { maximum: 50}
  
  has_one_attached :profile_image
  
  def get_profile_image(widht, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/profile_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    profile_image.variant(resize_to_limit: [widht, height]).processed
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end