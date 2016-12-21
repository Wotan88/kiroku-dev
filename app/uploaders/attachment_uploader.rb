class AttachmentUploader < CarrierWave::Uploader::Base
  storage :file
   
  def filename
    "#{SecureRandom.uuid}.#{file.extension}"
  end

  def store_dir
    "i"
  end
   
  def extension_white_list
    %w(jpeg jpg png)
  end

  def content_type_whitelist
    [/image\//]
  end
end