# frozen_string_literal: true

RSpec.describe Regexp, 
               :usecases,
               :jsonX,
               :debugX,
               :markdown,
               :markdown_prettier,
               :markdown_openX,
               markdown_file: 'docs/regexp-01.md',
               document_title: 'Ruby RegExp by example',
               document_description: 'Working through various regular expression scenarios using Ruby syntax' do

  # usecase '',
  #         title: 'Alternation (OR)',
  #         summary: '' do

  #   ruby '',
  #        summary: '' do

  #     source = ''

  #     puts source =~ /[aeiou]/
  #   end
  # end

  usecase 'Character classes',
    title: 'Character classes X',
    summary: 'With a "character class", also called "character set", you can tell the regex engine to match only one out of several characters' do

    ruby '=~ for match index and $~ for match data',
          summary: 'The operator =~ returns the index of the first match (nil if no match) and stores the MatchData in the global variable $~' do

      source = 'abcdefghijklmnopqrstuvwxyz'

      puts source =~ /[aeiou]/

      # 0

      puts $~

      # a
    end

    ruby 'match() for MatchData' do
      source = 'abcdefghijklmnopqrstuvwxyz'

      puts source.match(/[aeiou]/)
      
      # a

      puts source.match(/[12345]/)
      
      # nil
    end

    ruby 'match? for True/False',
          summary: "Regexp#match? executes a regexp match without creating a back reference object and changing $~ to reduce object allocation.\n\nRegexp#match? is listed as a performance enhancement in the release notes for 2.4.0" do

      source = 'abcdefghijklmnopqrstuvwxyz'

      puts source.match?(/[aeiou]/)

      # true
    end
  end

  usecase 'Character ranges',
    title: 'Character ranges',
    summary: 'Within a character class the hyphen (-) is a meta character denoting an inclusive range of characters.' do

    ruby 'scan for digits',
        summary: '[0-9] matches any number from 0 to 9' do

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
    end

    ruby 'scan for letters',
        summary: '[a-z] matches any letter from a to z (no caps)' do

      source = '12-abcde-34'

      puts source.scan(/[a-z]/)
      
      # a
      # b
      # c
      # d
      # e
    end

    ruby 'scan for upper case letters',
        summary: '[A-Z] matches any capital letter from A to Z' do

      source = 'The Quick Brown Fox'

      puts source.scan(/[A-Z]/)
      
      # T
      # Q
      # B
      # F
    end

    ruby 'scan for anything this not a-z',
        summary: '[^a-z] negated range' do

      source = '12-abcde-34'

      puts source.scan(/[^a-z]/)
      
      # 1
      # 2
      # -
      # -
      # 3
      # 4
    end

    ruby 'scan for upper/lower case letters',
        summary: '[a-zA-Z] matches common English (ASCII) letters' do

      source = 'David Cruwys'

      puts source.scan(/[a-zA-Z]/).join

      # DavidCruwys
    end

    ruby 'scan range with dash',
      summary: '[a-z-] or [-a-z] or [\-a-z] matches characters that may be in a URL slug' do

      source = '/the-quick'

      puts source.scan(/[a-z-]/).join

      # the-quick

      puts source.scan(/[-a-z]/).join

      # the-quick

      puts source.scan(/[the-quick]/).join # Ranges can get confused with dashes

      # thequick

      puts source.scan(/[the\-quick]/).join # So you can use escape for a literal dash

      # the-quick
    end

    ruby 'scan ASCII printable range',
         summary: '[\ -~] matches from space to tilda, aka ASCII characters 32 - 126' do

      puts 65.chr

      # A

      ascii_printable = [*32..126].map(&:chr).join

      puts "How many characters: #{ascii_printable.length}"
      puts ascii_printable

      # How many characters: 95
      #  !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~

      source = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"

      scanned = source.scan(/[\ -~]/).join

      puts scanned

      #  !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~

      expect(scanned).to eq(ascii_printable)
    end

  end

  usecase 'Alternation (OR)',
          title: 'Alternation (OR)',
          summary: 'Alternation gives you a choice of alternate patterns to match' do

    ruby 'Match on multiple words',
         summary: 'You can use pipe character (|) to match different words' do

      source = 'the quick brown fox jumped over the lazy dog'
      animals = /fox|dog/

      puts source.scan(animals)

      # fox
      # dog
    end
  end

  usecase 'Meta Characters',
          title: 'Meta Characters',
          summary: 'Meta characters are the building blocks of regular expressions. Characters in RegEx are understood to be either a meta character with a special meaning or a regular character with a literal meaning' do

    ruby 'Match on any character (except newline)',
         summary: 'You can use period character (.) to match any character' do

      source = "any character\n\n..."

      output = source.scan(/./).join

      puts output

      # any character...

      expect(output).to eq('any character...')
    end

    ruby 'Match on the literal period (.)',
         summary: 'You can match specifically on the period character (.) if needed by escaping' do

      source = 'any character...'

      output = source.scan(/\./).join

      puts output

      # ...

      expect(output).to eq('...')
    end

    ruby 'Match on space character',
         summary: 'You can use (\ ) for literal spaces, you do not always need to escape space, but it is a best practice that helps with problematic edge cases' do

      source = "hello     world"

      output = source.gsub(/\ /, '-')

      puts output

      # hello-----world

      expect(output).to eq('hello-----world')
    end

    ruby 'Match on any letter characters',
      summary: 'You can use \w to match any letter, number or underscore' do

      source = '!@#$ my_ruby_method_003 *($%'

      output1 = source.scan(/[a-zA-Z0-9_]/).join()
      output2 = source.scan(/\w/).join()

      puts output1
      puts output2

      # my_ruby_method_003
      # my_ruby_method_003

      expect(output1).to eq(output2)
    end

    ruby 'Do not match on any letter characters using negation',
      summary: 'You can use \W to exclude any letter, number or underscore' do

      source = '!@#$ my_ruby_method_003 *($%'

      output1 = source.scan(/[^a-zA-Z0-9_]/).join()
      output2 = source.scan(/\W/).join()

      puts output1
      puts output2

      # !@#$  *($%
      # !@#$  *($%

      expect(output1).to eq(output2)
    end

    ruby 'Match on any digits',
      summary: 'You can use \d to match any numerical digit' do

      source = 'my_ruby_method_003'

      output1 = source.scan(/[0-9]/).join()
      output2 = source.scan(/\d/).join()

      puts output1
      puts output2

      # 003
      # 003

      expect(output1).to eq(output2)
    end

    ruby 'Do not match on digits',
      summary: 'You can use \D to exclude numerical digit' do

      source = 'my_ruby_method_003'

      output1 = source.scan(/[0-9]/).join()
      output2 = source.scan(/\d/).join()

      puts output1
      puts output2

      # 003
      # 003

      expect(output1).to eq(output2)
    end

    ruby 'Match on any space, tab, newline or linefeed',
         summary: 'You can use \s as a redaction tool' do

      source = "sensitive document about linefeed\rtabs\t and newline\ncharacters"

      output = source.scan(/\s/).join('redacted')

      puts output

      #  redacted redacted redacted\rredacted\tredacted redacted redacted\n

      expect(output).to eq(" redacted redacted redacted\rredacted\tredacted redacted redacted\n")
    end

    ruby 'Match on non space characters',
         summary: 'You can use \S to get raw text values without space, newline, tabs or linefeed characters' do

      source = "convert\rdocument\tinto\nrawtext"

      output = source.scan(/\S/).join()

      puts output

      # convertdocumentintorawtext

      expect(output).to eq('convertdocumentintorawtext')
    end

    ruby 'Match on square brackets',
         summary: 'You can use \[ and \] for literal brackets' do

      source = "two_dimensional[:row][:column]"

      output = source.gsub(/\[/, '(').gsub(/\]/, ')')

      puts output

      # two_dimensional(:row)(:column)

      expect(output).to eq('two_dimensional(:row)(:column)')
    end
  end
end
