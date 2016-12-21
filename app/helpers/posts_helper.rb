module PostsHelper
  def to_mime(i)
    case i
    when 1
      return 'image/jpeg'
    end
    return nil
  end
end
