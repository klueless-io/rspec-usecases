# frozen_string_literal: true

RSpec.describe Rspec::Usecases do
  it 'has a version number' do
    expect(Rspec::Usecases::VERSION).not_to be nil
  end

  it 'has a standard error' do
    expect { raise Rspec::Usecases::Error, 'some message' }
      .to raise_error('some message')
  end
end
