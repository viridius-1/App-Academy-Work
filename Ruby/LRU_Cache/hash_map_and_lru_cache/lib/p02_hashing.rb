class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    integer_from_array = self.join.to_i
    Integer(integer_from_array).hash 
  end
end

class String
  def hash
    integer_string = ''
    ltr_and_num_arr = ('a'..'z').to_a + ('0'..'9').to_a
    self.each_char { |char| integer_string << ltr_and_num_arr.index(char).to_s }
    Integer(integer_string.to_i).hash 
  end
end

class Hash
  def hash
    string_from_hash = self.to_a.sort.join
    String(string_from_hash).hash 
  end
end

