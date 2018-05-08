class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order created_at: :desc }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: Settings.user_model.max_length_micropost }
  validate  :picture_size

  private

  def picture_size
    errors.add :picture, t("max_sizef") if
      picture.size > Settings.user_model.img_size.megabytes
  end
end
