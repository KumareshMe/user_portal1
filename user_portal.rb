class UserPortal < ApplicationRecord
  # auditing the changes in the model during update and destroy actions
  audited on: %i[update destroy]

  # validating the below columns are present and length is between 3 to 50
  validates :first_name, presence: true, length: { minimum: 3, maximum: 50 } 
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }

  # role should be one of the below values (key value pair) and it should be present in the model
  validates :role, :image, presence: true
  enum role: { admin_user: 0, client_user: 1, client_admin: 2, client_manager: 3, client_staff: 4, client_guest: 5 }

  # we can use CarrierWave gem to upload image to AWS S3 bucket and store the image url
  # mount_uploader :image, ImageUploader
  validate :image_size_validation

  def self.search(params)
    user = UserPortal.page(params[:page] || 1).per(params[:per] || 20).order('created_at DESC')
    user = user.where('title ILIKE ?', "%#{params[:first_name]}%") if params[:first_name].present?
    user = user.where('title ILIKE ?', "%#{params[:last_name]}%") if params[:last_name].present?
    user = user.where(role: params[:role]) if params[:role].present?
    user
  end

  def image_size_validation
    errors.add(:image, "should be less than 1MB") if image.size > 1.megabytes
  end
end
