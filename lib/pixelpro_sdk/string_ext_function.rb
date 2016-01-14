class String
  def is_all_num?
    return self.to_i.to_s == self
  end

  def is_all_up?
    return self.upcase == self
  end

  def is_all_low?
    return self.downcase == self
  end
end
