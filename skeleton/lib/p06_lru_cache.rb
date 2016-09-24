require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    #check if included, delete it, and replace (update_linK!)
    if @map.include?(key)
      return update_link!(@map[key])
    elsif @max == count
      eject!
    end
    calc!(key)
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)

    current_value = @prc.call(key)
    pointer = @store.insert(key, current_value)
    @map[key] = pointer
    current_value
  end

  def update_link!(link)
    @store.remove(link.key)
    pointer = @store.insert(link.key, link.val)
    @map[link.key] = pointer
    link.val
  end

  def eject!
    key_to_delete = @store.first.key
    @map.delete(key_to_delete)
    @store.remove(key_to_delete)
  end
end
