class IntSet
  SIZE = 20

  def initialize
    @store = Array.new(SIZE) {[]}
  end

  def [](val)
    bucket = val % SIZE
    @store[bucket]
  end

  def insert(n)
    self[n] << n
  end

  def remove(n)
    self[n].delete(n)
  end

  def include?(n)
    self[n].include?(n)
  end

end
