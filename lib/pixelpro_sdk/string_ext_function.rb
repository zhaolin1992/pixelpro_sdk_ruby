class String
  #if the string is all numbers
  def is_all_num?
    return self.to_i.to_s == self
  end

  #if the string is all upcase letter
  def is_all_up?
    return self.upcase == self
  end

  #if the string is all lowercase letter
  def is_all_low?
    return self.downcase == self
  end
end
