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

#### match() for MatchData

With a "character class", also called "character set", you can tell the regex engine to match only one out of several characters

```ruby
source = 'abcdefghijklmnopqrstuvwxyz'

puts source.match(/[aeiou]/)

# a

puts source.match(/[12345]/)

# nil
```

#### match? for True/False

Regexp#match? executes a regexp match without creating a back reference object and changing \$~ to reduce object allocation.

Regexp#match? is listed as a performance enhancement in the release notes for 2.4.0

```ruby
source = 'abcdefghijklmnopqrstuvwxyz'

puts source.match?(/[aeiou]/)

# true
```

## Character ranges

Within a character class the hyphen (-) is a meta character denoting an inclusive range of characters.

#### scan for digits

[0-9] matches any number from 0 to 9

```ruby
source = '12-abcde-34-fghij-56-klmno-78-qrstu-90-vwxyz'

puts source.scan(/[0-9]/)

# 1
# 2
# 3
# 4
# 5
# 6
# 7
# 8
# 9
# 0
```

#### scan for letters

[a-z] matches any letter from a to z (no caps)

```ruby
source = '12-abcde-34'

puts source.scan(/[a-z]/)

# a
# b
# c
# d
# e
```

#### scan for upper case letters

[A-Z] matches any capital letter from A to Z

```ruby
source = 'The Quick Brown Fox'

puts source.scan(/[A-Z]/)

# T
# Q
# B
# F
```

#### scan for anything this not a-z

[^a-z] negated range

```ruby
source = '12-abcde-34'

puts source.scan(/[^a-z]/)

# 1
# 2
# -
# -
# 3
# 4
```

#### scan for upper/lower case letters

[a-zA-Z] matches common English (ASCII) letters

```ruby
source = 'David Cruwys'

puts source.scan(/[a-zA-Z]/).join

# DavidCruwys
```

#### scan range with dash

[a-z-] or [-a-z] or [\-a-z] matches characters that may be in a URL slug

```ruby
source = '/the-quick'

puts source.scan(/[a-z-]/).join

# the-quick

puts source.scan(/[-a-z]/).join

# the-quick

puts source.scan(/[the-quick]/).join # Ranges can get confused with dashes

# thequick

puts source.scan(/[the\-quick]/).join # So you can use escape for a literal dash

# the-quick
```

#### scan ASCII printable range

[\ -~] matches from space to tilda, aka ASCII characters 32 - 126

```ruby
puts 65.chr

# A

ascii_printable = [*32..126].map(&:chr).join

puts "How many characters: #{ascii_printable.length}"
puts ascii_printable

# How many characters: 95
#  !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~

source =
  " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"

scanned = source.scan(/[\ -~]/).join

puts scanned

#  !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~

expect(scanned).to eq(ascii_printable)
```

## Alternation (OR)

Alternation gives you a choice of alternate patterns to match

#### Match on multiple words

You can use pipe character (|) to match different words

```ruby
source = 'the quick brown fox jumped over the lazy dog'
animals = /fox|dog/

puts source.scan(animals)

# fox
# dog
```

## Meta Characters

Meta characters are the building blocks of regular expressions. Characters in RegEx are understood to be either a meta character with a special meaning or a regular character with a literal meaning

#### Match on any character (except newline)

You can use period character (.) to match any character

```ruby
source = "any character\n\n..."

output = source.scan(/./).join

puts output

# any character...

expect(output).to eq('any character...')
```

#### Match on the literal period (.)

You can match specifically on the period character (.) if needed by escaping

```ruby
source = 'any character...'

output = source.scan(/\./).join

puts output

# ...

expect(output).to eq('...')
```

#### Match on space character

You can use (\ ) for literal spaces, you do not always need to escape space, but it is a best practice that helps with problematic edge cases

```ruby
not always need to escape space, but it is a best practice that helps with problematic edge cases' do

     source = "hello     world"

     output = source.gsub(/\ /, '-')

     puts output

     # hello-----world

     expect(output).to eq('hello-----world')
```

#### Match on any letter characters

You can use \w to match any letter, number or underscore

```ruby
source = '!@#$ my_ruby_method_003 *($%'

output1 = source.scan(/[a-zA-Z0-9_]/).join
output2 = source.scan(/\w/).join

puts output1
puts output2

# my_ruby_method_003
# my_ruby_method_003

expect(output1).to eq(output2)
```

#### Do not match on any letter characters using negation

You can use \W to exclude any letter, number or underscore

```ruby
source = '!@#$ my_ruby_method_003 *($%'

output1 = source.scan(/[^a-zA-Z0-9_]/).join
output2 = source.scan(/\W/).join

puts output1
puts output2

# !@#$  *($%
# !@#$  *($%

expect(output1).to eq(output2)
```

#### Match on any digits

You can use \d to match any numerical digit

```ruby
source = 'my_ruby_method_003'

output1 = source.scan(/[0-9]/).join
output2 = source.scan(/\d/).join

puts output1
puts output2

# 003
# 003

expect(output1).to eq(output2)
```

#### Do not match on digits

You can use \D to exclude numerical digit

```ruby
source = 'my_ruby_method_003'

output1 = source.scan(/[0-9]/).join
output2 = source.scan(/\d/).join

puts output1
puts output2

# 003
# 003

expect(output1).to eq(output2)
```

#### Match on any space, tab, newline or linefeed

You can use \s as a redaction tool

```ruby
source = "sensitive document about linefeed\rtabs\t and newline\ncharacters"

output = source.scan(/\s/).join('redacted')

puts output

#  redacted redacted redacted\rredacted\tredacted redacted redacted\n

expect(output).to eq(
  " redacted redacted redacted\rredacted\tredacted redacted redacted\n"
)
```

#### Match on non space characters

You can use \S to get raw text values without space, newline, tabs or linefeed characters

```ruby
source = "convert\rdocument\tinto\nrawtext"

output = source.scan(/\S/).join

puts output

# convertdocumentintorawtext

expect(output).to eq('convertdocumentintorawtext')
```

#### Match on square brackets

You can use \[ and \] for literal brackets

```ruby
source = 'two_dimensional[:row][:column]'

output = source.gsub(/\[/, '(').gsub(/\]/, ')')

puts output

# two_dimensional(:row)(:column)

expect(output).to eq('two_dimensional(:row)(:column)')
```
