require_relative 'hashfunction'

class HashSet
  include HashFunction
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(n)
    check_resize
    self[n] << n unless include?(n)
    @count += 1
  end

  def include?(n)
    self[n].include?(n)
  end

  def remove(n)
    self[n].delete(n)
    @count -= 1
  end

  private

  def [](val)
    hash_value = hash(val)
    bucket = hash_value % num_buckets
    @store[bucket]
  end

  def num_buckets
    @store.length
  end

  def check_resize
    if @count == num_buckets
      num_buckets.times do
        @store << []
      end
      resize!
    end
  end

  def resize!
    @count = 0
    current_elements = []

    @store.map! do |bucket|
      current_elements.push(*bucket)
      []
    end
    current_elements.each do |element|
      insert(element)
    end

  end
end
