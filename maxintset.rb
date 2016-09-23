class MaxIntSet
  def initialize (maxsize)
    @maxsize = maxsize
    @store = Array.new(maxsize,false)
  end

  def insert(n)
    out_of_range if n >= @maxsize
    @store[n] = true
  end

  def remove(n)
    out_of_range if n >= @maxsize
    @store[n] = false
  end

  def include?(n)
    out_of_range if n >= @maxsize
    @store[n]
  end


  private

  def out_of_range
    raise "Element is out of range."
  end

end
