# frozen_string_literal: true

RSpec.describe Array, 
               :usecases,
               :json,
               :debugX,
               :markdownX,
               :markdown_prettier,
               :markdown_open,
               markdown_file: 'docs/samples.md',
               document_title: 'Usage Samples',
               document_description: 'Some examples of how to use Rspec::Usage' do

  describe 'load' do
    usecase '1st basics',
            usage: "#{described_class.name}.load",
            usage_description: "#{described_class.name}.load - description goes here" do

      ruby 'Initialize an array' do
        ar = [1,2,3]
      end

      code 'Push to array' do
        # ar << 4
      end

      outcome 'AAAAAA' do
        ar = [1,2,3]
        expect(ar).to match_array([1, 2, 3])
      end

      outcome 'BBBBBB' do
        ar = [1,2,3]
        ar << 4
        expect(ar).to match_array([1, 2, 3, 4])
      end
    end

    usecase '2nd basics',
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

      # code: is not supported, should it be?
      # ruby '',
      #   code: 'ar << 4' do
      # end

      # css '',
      #   code: 'a { color: "blue" }' do
      # end

      # outcome 'Some content', :hr do
      #   ar = [1,2,3]
      #   expect(ar).to match_array([1, 2, 3])
      # end

      # outcome 'Some more content with', 
      #   summary: 'A detailed summary provided' do
      #   ar = [1,2,3]
      #   expect(ar).to match_array([1, 2, 3])
      # end
      end

    usecase 'Overwrite the title',
            usage: "#{described_class.name}.load",
            title: 'Default.load will load your application configuration from your `.env` file found in the project root' do
      outcome 'aaaa' do
        # puts @document
      end
    end

    describe '-> namespace ->' do

      usecase 'Can I move content_block into a test block',
        usage: "#{described_class.name}.load" do

        code 'example' do
          #
        end

        outcome 'xxxxx' do
          # 
        end
      end

    end

    context 'and this' do
      #
    end
  end

  # describe 'more stuff' do
  #   context 'with deeper' do
  #     context 'and deeper levels' do
  #     end
  #   end
  # end
end
