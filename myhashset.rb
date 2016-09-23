require_relative 'hashfunction'

class MyHashSet
  include HashFunction

  def initialize
    @store = Array.new(2) { [] }
  end

  def insert(n)
    resize
    self[n] << n unless include?(n)
  end

  def delete(n)
    self[n].delete(n)
  end

  def include?(n)
    self[n].include?(n)
  end

  private

  def resize_check
    total_size = 0
    @store.each do |bucket|
      total_size += bucket.size
    end
    total_size

  end

  def resize
    if resize_check == @store.size
      @store.size.times do
        @store << []
      end
      relocate
    end
  end

  def relocate
    current_elements = []

    @store.map! do |bucket|
      current_elements.push(*bucket)
      []
    end
    current_elements.each do |element|
      insert(element)
    end

  end

  def [](val)
    hash_value = hash(val)
    bucket = hash_value % @store.size
    @store[bucket]
  end


end
