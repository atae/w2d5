require "byebug"
module HashFunction

  ARBITRARY_NUMBER = 646109884

  def hash(el)
    if el.class == Fixnum
      el.hash
    elsif el.class == Array
      hash_array(el)
    elsif el.class == String
      hash_string(el)
    elsif el.class == Symbol
      hash_string(el.to_s)
    elsif el.class == Hash
      hash_hash(el)
    end
  end

  def hash_array(array)
    copy = array.dup
    depth(copy).times do
      copy << ARBITRARY_NUMBER
    end
    copy.flatten!
    hashes = []
    copy.map do |el|
      hash(el)
    end.inject(:+)
    
  end

  def hash_string(string)
    array = string.chars
    array.inject(0) do |sum, letter|
      hashed_letter = letter.ord.hash
      sum + hashed_letter
    end
  end

  def hash_hash(hash)
    hash_array(hash.to_a.sort)
  end

  def depth (a)
    return 0 unless a.is_a?(Array)
    return 1 + depth(a[0])
  end

end

class MyHash
  include HashFunction
end
