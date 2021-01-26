# Ruby RegExp by example

Working through various regular expression scenarios using Ruby syntax

## Character classes X

With a "character class", also called "character set", you can tell the regex engine to match only one out of several characters

#### =~ for match index and \$~ for match data

The operator =~ returns the index of the first match (nil if no match) and stores the MatchData in the global variable \$~

```ruby
source = 'abcdefghijklmnopqrstuvwxyz'

puts source =~ /[aeiou]/

# 0

puts $~

# a
```
