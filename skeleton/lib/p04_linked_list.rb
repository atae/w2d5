require 'byebug'
class Link

  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  def initialize
    @dummy = Link.new
    @head = @dummy
    @tail = @dummy
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail
  end

  def empty?
    @head == @tail
  end

  def get(key)
    each do |link|
      return link.val if link.key == key
    end
  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end
    false
  end

  def insert(key, val)
    new_node = Link.new(key,val)
    new_node.prev = @tail
    @tail.next = new_node
    @tail = new_node
  end

  def remove(key)
    each do |link|
      if link.key == key
        previous_link = link.prev
        next_link = link.next
        previous_link.next = next_link unless previous_link.nil?
        next_link.prev = previous_link unless next_link.nil?
      end
      link = link.next

    end

  end

  def each(&block)
    links = []
    temp_link = @head.next
    while temp_link
      current_enumerable = yield(temp_link)
      temp_link = temp_link.next
    end
    #byebug
    current_enumerable
  end

  def update(key, val)
    each do |link|
      link.val = val if link.key == key
    end
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
