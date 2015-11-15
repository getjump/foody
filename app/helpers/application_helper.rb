module ApplicationHelper
  def pretty_iterate(hash, deep = 0)
    buf = ''
    if hash.class == Array
      hash.each { |v|
        buf += pretty_iterate_iter(0, v, deep)
      }
    elsif hash.class == Hash
      hash.each { |k, v|
        buf += pretty_iterate_iter(k, v, deep)
      }
    end
    buf
  end

  def pretty_iterate_iter(k, v, deep)
    buf = ''
    spaces = ' '*deep
    buf += spaces
    unless k.to_s["?"].nil?
      k = k.to_s
      k.to_s["?"] = ""
      k += " (optional)"
    end
    case v
    when Hash
      if k != 0
        buf += k.to_s + ":\n" + spaces
      elsif
        buf += ""
      end
      buf += "{\n" + pretty_iterate(v, deep+4) + spaces + "}\n"
    when Array
      buf += k.to_s + " " + "\n" + spaces + "[\n" + pretty_iterate(v, deep+4) + spaces + "]\n"
    else
      if k != 0
        buf += k.to_s + " : "
      end
      buf += v.to_s + "\n"
    end
    return buf
  end
end
