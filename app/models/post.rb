class Post < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader

  before_destroy :decrease_tags
  before_save :decrease_tags
  after_save :increase_tags

  validates :tags, presence: true

  private

  def inc_tag(n)
    t = Tag.where(label: n).first
    unless t.nil?
      t.update_attribute(:count, t.count + 1)
    else
      t = Tag.new
      t.label = n
      t.count = 1
      t.save
    end
  end

  def dec_tag(n)
    t = Tag.where(label: n).first
    unless t.nil?
      if t.count > 1
        t.update_attribute(:count, t.count - 1)
      else
        t.destroy
      end
    end
  end

  def tags_to_arr
    return JSON.parse tags
  end

  def decrease_tags
    unless new_record?
      a = tags_to_arr
      for t in a
        dec_tag t
      end
    end
  end

  def increase_tags
    a = tags_to_arr
    for t in a
      inc_tag t
    end
  end
end
