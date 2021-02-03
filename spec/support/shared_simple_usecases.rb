# frozen_string_literal: true

RSpec.shared_context 'simple usecases', shared_context: :metadata do
  describe 'B' do
    context 'C' do
      usecase 'Simple usecase block' do
        # Nothing to see here
      end

      usecase 'Fully configured usecase block',
              title: 'Override Title',
              summary: 'Will all usecase attributes',
              usage: 'Array.new',
              usage_description: 'Create a new array' do
        outcome 'this outcome has a note',
                :hr,
                note: 'outcome note' do
          # Source code goes here
        end

        ruby 'this is some ruby code' do
          # Source code goes here
        end
      end
    end
  end
end
