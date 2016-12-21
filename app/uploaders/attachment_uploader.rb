class AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file
  
  version :thumb do
    process :resize_to_fit => [200,200]
    process :convert => 'jpg'

    def full_filename(for_file = model.attachment.file)
      n = File.basename(for_file, File.extname(for_file))
      "#{n}.jpg"
    end

    def store_dir
      "s"
    end
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename
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

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end