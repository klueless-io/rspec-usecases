# frozen_string_literal: true

RSpec.shared_context 'comprehensive usecases', shared_context: :metadata do
  usecase 'valid level 1 usecase #1',
          summary: 'first encountered usecases',
          usage: 'SomeClass.some_method',
          usage_description: 'Calls some_method on SomeClass' do
    outcome do
      # Title should be blank on this outcome
    end

    outcome 'this outcome has a title' do
      # Source code goes here
    end

    outcome 'this outcome has a note', note: 'outcome note' do
      # Source code goes here
    end

    outcome 'this outcome has an hr', :hr do
      # HR after this
    end

    code 'this is some unknown code' do
      # Source code goes here
    end

    code 'this is some ruby code' do
      # Source code goes here
    end

    usecase 'valid level 2 usecase #1.1',
            summary: 'override the summary',
            usage: '',
            usage_description: '' do
      # Override inherited summary
      # Clear inherited usage_*
    end

    usecase 'valid level 2 usecase #1.2',
            summary: '',
            usage: '',
            usage_description: '' do
      # Clear inherited summary
      # Clear inherited usage_*
    end
  end

  describe '#some_method' do
    usecase 'valid level 1 usecase #2' do
      # Nothing here yet
      context 'flatten me out of the hierarchy' do
        usecase 'valid level 2 usecase #2.1' do
          # Nothing here yet
        end
      end
      usecase 'valid level 2 usecase #2.2' do
        code 'some code code' do
          # code goes here
        end

        ruby 'some ruby code' do
          # ruby goes here
        end

        css 'some css code' do
          # css goes here
        end

        js 'some js code' do
          # js goes here
        end

        javascript 'some javascript code' do
          # javascript  goes here
        end
      end
    end
  end

  # context 'when configuration is setup' do
  #   usecase 'valid level 1 usecase #3' do
  #     # Nothing here yet
  #     describe 'flatten me out of the hierarchy' do
  #       usecase 'valid level 2 usecase #3.1' do
  #         # Nothing here yet

  #         usecase 'valid level 3 usecase #3.1.1' do
  #           # Nothing here yet
  #         end

  #         describe 'flatten me out of the hierarchy' do
  #           usecase 'valid level 3 usecase #3.1.2' do
  #             # Nothing here yet
  #           end
  #         end

  #         usecase 'valid level 3 usecase #3.1.3' do
  #           # Nothing here yet
  #         end
  #       end
  #     end
  #   end
  # end
end
