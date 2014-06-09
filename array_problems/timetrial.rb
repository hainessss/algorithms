def time(count=1000, &block)
  start = Time.now
  1000.times { yield }
  end_time = Time.now
  puts (end_time - start) * 1000
end

def create_array(size)
  Array.new(size) { |x| x }
end

10.times do |n|
  size = 10000 * (n + 1)
  arr = create_array(size)
  time do
    arr.include?(size + 1)
    # arr.insert(2, size/2 )
    # arr.push(2)
  end
end
