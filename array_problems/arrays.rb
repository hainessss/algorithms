require 'rubygems'
require 'pry-debugger'

module ArrayUtil
  def self.max(array)
    max = 0
    if array.length == 0
      return nil
    else
      array.each_index do |x|
        if x == 0
          max = array[x]
        elsif max < array[x]
          max = array[x]
        end
      end
    end
    return max
  end

  def self.middle_element(array)
    mid = array.length / 2
    if array.length == 0
      nil
    elsif array.length % 2 == 0
      temp = (array[mid] + array[mid - 1]).to_f / 2
        if temp % 2 == 0
          temp.to_i
        end
        return temp
    else
      array[mid]
    end
  end

  def self.sum_arrays(array1, array2)
    sum = Array.new
    array1.each_index do |x|
      sum << array1[x] + array2[x]
    end
    return sum
  end
end

def time(count=1000, &block)
  start = Time.now
  1000.times { yield }
  end_time = Time.now
  puts (end_time - start) * 1000
end

binding.pry
