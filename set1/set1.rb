module Set1
  # O(n)
  def self.swap_small(array)
    min = array.min
    array[array.index(min)] = array[0]
    array[0] = min
    return array
  end

  # O(n^2)
  def self.find_sum_2(array, sum = 0)
    array.each do |val|
      array.each do |value|
        if val + value == 0 #&& ind != index
          return true
        end
      end
    end
    false
  end

  #O()
  def self.find_sum_3(array)
    array.each do |v|
      array.each do |val|
        array.each do |value|
          if val + value + v == 0 #&& ind != index
            return true
          end
        end
      end
    end
    false
  end
end
