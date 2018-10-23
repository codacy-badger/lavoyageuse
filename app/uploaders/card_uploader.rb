class CardUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick

  # make_private # This will make sure you're images are uploaded as private
  make_private
  eager

  def public_id
    return "card_id/card_id_user_" + Time.now.to_s
  end

  version :medium do
    process :resize_to_fill => [500, 300, 'North']
    process :convert => 'jpg'
    cloudinary_transformation :quality => 80
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
