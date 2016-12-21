class Post < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
end
