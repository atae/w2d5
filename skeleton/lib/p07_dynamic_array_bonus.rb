class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    @store[i]
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
  end

  def push(val)
    if @count == capacity
      resize!
    end

    capacity.times do |i|
      if self[i].nil?
        self[i] = val
        @count += 1
        break
      end
    end

  end

  def unshift(val)
    if self[capacity - 1]
      resize!
    end
    idx1 = capacity - 1
    until idx1 == 1
      idx2 = idx1 - 1
      self[idx1] = self[idx2]
      idx1 -= 1
    end
    self[idx1] = val
  end

  def pop
  end

  def shift
  end

  def first
  end

  def last
  end

  def each
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
  end
end
