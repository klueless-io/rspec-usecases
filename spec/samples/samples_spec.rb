# frozen_string_literal: true

RSpec.describe Array, 
               :usecases,
               :skip_render,
               document_title: 'Usage Samples',
               document_description: 'Some examples of how to use Rspec::Usage',
               xjson: { write: true, open: true, file: 'docs/samples.json', print: false },
               xmarkdown: { write: true, open: true, file: 'docs/samples.md', pretty: false, print: false } do

  describe 'load' do
    usecase 'Array load basics',
            usage: "#{described_class.name}.load",
            usage_description: "#{described_class.name}.load - description goes here" do

      # Should be able to deprecate this: , usage: '', usage_description: ''
      usecase 'Initialize an array', usage: '', usage_description: '' do
        ruby do
          ar = [1, 2, 3]
        end

        ruby nil, id: :initArray1 do
          ar = [1, 2, 3]

          expect(ar).to match_array([1, 2, 3])
        end

        outcome nil, after_context: lambda { |document, content| content.source = document.lookup_content[:initArray1].expected_description } do
          #
        end
        
        hr do; end

        ruby nil, id: :initArray2 do
          ar = [1,2,3]

          puts ar
        end

        outcome nil, capture2source: :initArray2 do
          #
        end
      end

      usecase 'Push to array', usage: '', usage_description: '' do
        ruby do
          ar = [1,2,3]

          ar << 4
        end

        ruby nil, id: :pushArray1  do
          ar = [1,2,3]

          ar << 4
          
          expect(ar).to match_array([1, 2, 3, 4])
        end

        outcome nil, expected2source: :pushArray1 do
          #
        end
        

        hr do; end

        ruby nil, id: :pushArray2  do
          ar = [1,2,3]

          ar << 4
          
          puts ar
        end

        outcome nil, capture2source: :pushArray2 do
          #
        end
      end
    end

    usecase '2nd basics',
      usage: "#{described_class.name}.load",
      usage_description: "#{described_class.name}.load - description goes here" do

      ruby 'Initialize an array', :hr, id: :example2 do
        display = true
        [1,2,3].each do |i|
          puts "the quick brown fox: #{i}" if display

          ['A','B','C'].each do |x|
            puts "the quick brown fox: #{i}:#{x}" if display
          end
          puts '-----------------------' if display
        end
      end

      text nil, after_context: lambda { |document, content| content.source = document.lookup_content[:example2].captured_output } do
        #
      end

      text 'capture2source: goes here', capture2source: :example2 do
        #
      end
    end
  end
end
