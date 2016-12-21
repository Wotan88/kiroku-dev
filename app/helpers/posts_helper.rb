module PostsHelper
  def to_mime(i)
    case i
    when 1
      return 'image/jpeg'
    when 2
      return 'image/png'
    end
    return nil
  end

  def mime_to_int(m)
    case m
    when 'image/jpeg'
      return 1
    when 'image/png'
      return 2
    end
    return -1
  end
end
