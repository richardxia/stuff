require './primes'
require './fib'
require './eulerlib'
require './pythagoras'
require './grid'
require './triangle'
require './collatz'

P = Primes.new
C = Collatz.new

prob11_string =
'08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48'
def prob11(gridstring, length=4)
  grid = Grid.from_string(gridstring).lines(4).map(&:product).max
end
puts prob11(prob11_string)

def prob12(num_divisors=500)
  Triangle.numbers do |triangle_num|
    return triangle_num if triangle_num.num_divisors > num_divisors
  end
end
puts prob12(5) == 28
puts prob12(500)

def prob13(url="http://projecteuler.net/index.php?section=problems&id=13")
  require 'nokogiri'
  require 'open-uri'
  document = Nokogiri::HTML(open(url))
  elem = document.xpath('.//div[@class="problem_content"]/div')
  texts = elem.children.select(&:text?).map(&:to_s).map(&:strip)
  return texts.map {|text| text.to_i }.sum.to_s.slice(0, 10)
end
puts prob13

def prob14(max_n=1000000)
  biggest_length = 0
  biggest_length_n = nil
  (1..max_n).each do |n|
    l = C.length(n)
    if l > biggest_length
      biggest_length = l
      biggest_length_n = n
    end
  end
  return biggest_length_n
end

puts prob14

def prob15(size_x=20, size_y=20, solutions={})
  if solutions.key? [size_x, size_y]
    return solutions[[size_x, size_y]]
  end

  solution = nil
  if size_x == 0
    solution = 1
  elsif size_y == 0
    solution = 1
  end
  if solution.nil?
    solution = prob15(size_x - 1, size_y, solutions) + prob15(size_x, size_y - 1, solutions)
  end
  solutions[[size_x, size_y]] = solution
  return solution
end

puts prob15(2, 2) == 6
puts prob15


# problem 16
puts (2**1000).to_s.to_a.map(&:to_i).sum

# problem 17
# See http://deveiate.org/projects/Linguistics/wiki/English
require 'linguistics'  # gem install linguistics
Linguistics::use :en
def prob17(n0=1, n1=1000)
  (n0..n1).to_a.map(&:en).map(&:numwords).join('').gsub(/[- ]/, '').length
end

puts prob17

prob18_string =
'75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23'
def prob18(triangle_string)
  TriangleGrid.from_string(triangle_string).max_sum
end

puts prob18(prob18_string)

require 'date'
def prob19(weekday=7, start_year=1901, end_year=2000, month_day='01')
  years_months = (start_year..end_year).to_a.cartesian_product((1..12))
  years_months.map {|year, month| Date.strptime("#{year}-#{month}-#{month_day}", '%Y-%m-%d').cwday }.counts[weekday]
end
puts prob19

# prob20
puts 100.factorial.to_s.to_a.map(&:to_i).sum