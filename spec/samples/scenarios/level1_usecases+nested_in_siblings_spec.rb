
# frozen_string_literal: true

RSpec.describe 'three usecases at level 1 + some of them are nested inside describe/context blocks', :usecases do

  # Describe / Context blocks are not considered part of the usecase hierarchy
  #
  # this means that if a usecase is nested inside of a context/describe then
  # the context/describe do not factor into it's hierarchial position

  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  subject { @documentor.document.usecases }

  let(:documentor) { Rspec::Usecases::Documentor.new(@example_group) }

  it do
    is_expected.to include(have_attributes(title: 'valid level 1 usecase #1'),
                           have_attributes(title: 'valid level 1 usecase #2'),
                           have_attributes(title: 'valid level 1 usecase #3'))
  end

  usecase 'valid level 1 usecase #1' do
    # Nothing here yet
  end

  describe '#some_method' do
    usecase 'valid level 1 usecase #2' do
      # Nothing here yet
    end
  end

  context 'when configuration is setup' do
    usecase 'valid level 1 usecase #3' do
      # Nothing here yet
    end
  end
end
