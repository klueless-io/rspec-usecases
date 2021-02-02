# Ruby RegExp by example

Working through various regular expression scenarios using Ruby syntax

## Character classes

#### match index `=~`

```ruby
source = 'abcdefghijklmnopqrstuvwxyz'

label_value('source =~ /[aeiou]/', source =~ /[aeiou]/)
label_value('source =~ /[crazy]/', source =~ /[crazy]/)
label_value('source =~ /[12345]/', source =~ /[12345]/)
```

```ruby
# source =~ /[aeiou]/           : 0
# source =~ /[crazy]/           : 0
# source =~ /[12345]/           : nil
```

#### global variable `$~` for MatchData

```ruby
source = 'abcdefghijklmnopqrstuvwxyz'

puts source =~ /[aeiou]/
puts $~
puts source =~ /[12345]/
puts $~
puts source =~ /[d]/
puts $~
```

```ruby
# 0
# a
# 3
# d
```

#### match() for MatchData

```ruby
source = 'abcdefghijklmnopqrstuvwxyz'

puts source.match(/[aeiou]/)
puts source.match(/[12345]/)
puts source.match(/[d]/)
```

```ruby
# a
# nil
```
