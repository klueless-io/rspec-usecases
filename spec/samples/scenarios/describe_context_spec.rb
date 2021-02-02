# frozen_string_literal: true

RSpec.describe 'one context and one describe block', :usecases do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  subject { @documentor.document }

  it 'has no configured usecases' do
    is_expected.to have_attributes(usecases: [])
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
