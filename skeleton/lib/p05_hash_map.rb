require_relative 'hashfunction'
require_relative 'p04_linked_list'
require 'byebug'
class HashMap
  attr_reader :count
  include HashFunction
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    current_bucket = @store[bucket(key)]

     if current_bucket.include?(key)
       current_bucket.update(key, val)
     else
       resize! if @count == num_buckets
       current_bucket.insert(key, val)
       @count += 1
     end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    if include?(key)
      @store[bucket(key)].remove(key)
      @count -= 1
    end
  end

  def each(&block)
    result = []
    @store.each do |bucket|
      bucket.each do |link|
        result = yield([link.key, link.val])
      end
    end

    result

  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    current_elements = []
    each { |pair| current_elements << pair }

    @store = Array.new(num_buckets * 2) { LinkedList.new }
    current_elements.each do |(key, value)|
      set(key, value)
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    hash(key)%num_buckets
  end
end
