# Usage Samples
Some examples of how to use Rspec::Usage

## Array load basics


> Array.load

Array.load - description goes here

### Initialize an array


```ruby
ar = [1,2,3]
```
```ruby
ar = [1,2,3]

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

