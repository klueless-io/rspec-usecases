# frozen_string_literal: true

RSpec.describe 'two usecases at level 1 + describe and context block', :usecases do

  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  subject { @documentor.document.usecases }

  let(:documentor) { Rspec::Usecases::Documentor.new(@example_group) }

  it do
    is_expected.to include(have_attributes(title: 'valid usecase #1'),
                           have_attributes(title: 'valid usecase #2'))
  end

  usecase 'valid usecase #1' do
    # Nothing here yet
  end

  usecase 'valid usecase #2' do
    # Nothing here yet
  end

  describe '#some_method' do
    context 'when data is set' do
      it 'does a test' do
        expect(true).to be_truthy
      end
    end
  end

  context 'when configuration is setup' do
    describe '#another_method' do
      it 'does a test' do
        expect(true).to be_truthy
      end
    end
  end
end
