# Usage Samples
Some examples of how to use Rspec::Usage

## Array load basics


> Array.load

Array.load - description goes here

### Initialize an array


```ruby
ar = [1, 2, 3]
```
```ruby
ar = [1, 2, 3]

expect(ar).to match_array([1, 2, 3])
```
> is expected to contain exactly 1, 2, and 3
---
```ruby
ar = [1,2,3]

puts ar
```
> 1
2
3

### Push to array


```ruby
ar = [1,2,3]

ar << 4
```
```ruby
ar = [1,2,3]

ar << 4

expect(ar).to match_array([1, 2, 3, 4])
```
> is expected to contain exactly 1, 2, 3, and 4
---
```ruby
ar = [1,2,3]

ar << 4

puts ar
```
> 1
2
3
4

## 2nd basics


> Array.load

Array.load - description goes here

---
#### Initialize an array
```ruby
display = true
[1,2,3].each do |i|
  puts "the quick brown fox: #{i}" if display

  ['A','B','C'].each do |x|
    puts "the quick brown fox: #{i}:#{x}" if display
  end
  puts '-----------------------' if display
end
```
```text
the quick brown fox: 1
the quick brown fox: 1:A
the quick brown fox: 1:B
the quick brown fox: 1:C
-----------------------
the quick brown fox: 2
the quick brown fox: 2:A
the quick brown fox: 2:B
the quick brown fox: 2:C
-----------------------
the quick brown fox: 3
the quick brown fox: 3:A
the quick brown fox: 3:B
the quick brown fox: 3:C
-----------------------

```
#### capture2source: goes here
```text
the quick brown fox: 1
the quick brown fox: 1:A
the quick brown fox: 1:B
the quick brown fox: 1:C
-----------------------
the quick brown fox: 2
the quick brown fox: 2:A
the quick brown fox: 2:B
the quick brown fox: 2:C
-----------------------
the quick brown fox: 3
the quick brown fox: 3:A
the quick brown fox: 3:B
the quick brown fox: 3:C
-----------------------

```
