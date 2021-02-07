# frozen_string_literal: true

RSpec.describe Array, 
               :usecases,
               document_title: 'Usage Samples',
               document_description: 'Some examples of how to use Rspec::Usage',
               json: { write: true, open: true, file: 'docs/samples.json', print: false },
               xmarkdown: { write: true, open: true, file: 'docs/samples.md', pretty: false, print: false } do

  after(:each) do |example|
    # puts 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    # puts example.metadata[:scoped_id]
    # puts example.description
    # puts 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    if example.exception

      # ...
    end
  end

  fdescribe 'load' do
    usecase 'Array load basics',
            usage: "#{described_class.name}.load",
            usage_description: "#{described_class.name}.load - description goes here" do

      # Should be able to deprecate this: , usage: '', usage_description: ''
      usecase 'Initialize an array', usage: '', usage_description: '' do
        ruby do
          ar = [1,2,3]
        end

        ruby nil, id: :initArray1 do
          ar = [1,2,3]

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

        outcome nil, after_context: lambda { |document, content| content.source = document.lookup_content[:initArray2].captured_output } do
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

        outcome nil, after_context: lambda { |document, content| content.source = document.lookup_content[:pushArray1].expected_description } do
          #
        end

        hr do; end

        ruby nil, id: :pushArray2  do
          ar = [1,2,3]

          ar << 4
          
          puts ar
        end

        outcome nil, after_context: lambda { |document, content| content.source = document.lookup_content[:pushArray2].captured_output } do
          #
        end
      end
    end

    xusecase '2nd basics',
      usage: "#{described_class.name}.load",
      usage_description: "#{described_class.name}.load - description goes here" do

      ruby 'Initialize an array', :hr do
        display = false
        [1,2,3].each do |i|
          puts "the quick brown fox: #{i}" if display

          ['A','B','C'].each do |x|
            puts "the quick brown fox: #{i}:#{x}" if display
          end
          puts '-----------------------' if display
        end
      end

      ruby '', code: 'ar << 6' do
        # 
      end

      css '', code: 'a { color: "blue" }' do
        # 
      end

      outcome 'Some content', :hr do
        ar = [1,2,3]
        # expect(ar).to match_array([1, 2, 3])
      end

      outcome 'Some more content with', 
        summary: 'A detailed summary provided' do
        ar = [1,2,3]
        # expect(ar).to match_array([1, 2, 3])
      end
    end

    xusecase 'Overwrite the title',
            usage: "#{described_class.name}.load",
            title: 'Default.load will load your application configuration from your `.env` file found in the project root' do
      outcome 'aaaa' do
        # puts @document
      end
    end
  end
end
