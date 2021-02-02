# frozen_string_literal: true

RSpec.describe 'valid usecase but missing the :usecases initialization attribute' do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  subject { @documentor }

  it 'documentor should not be created' do
    is_expected.to be_nil
  end

  usecase 'valid usecase' do
    # Nothing here yet
  end
end
