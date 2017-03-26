class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [50, 50]
  end

  version :small do
    process resize_to_fill: [150, 150]
  end

  version :medium do
    process resize_to_fill: [250, 250]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    "#{mounted_as}.#{file.extension}" if original_filename
  end
end
