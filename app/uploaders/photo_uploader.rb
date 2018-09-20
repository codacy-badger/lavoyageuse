class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick

  # make_private # This will make sure you're images are uploaded as private
  eager


  def public_id
    return "users/user_" + Time.now.to_s
  end

  version :medium do
    process :resize_to_fill => [500, 500, 'North']
    process :convert => 'jpg'
    cloudinary_transformation :quality => 80
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
