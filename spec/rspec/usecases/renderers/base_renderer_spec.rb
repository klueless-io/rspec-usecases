# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Renderers::BaseRenderer do
  subject { instance }

  let(:instance) { described_class.new }

  describe '#constructor' do
    context 'with default parameters' do
      it { is_expected.not_to be_nil }
      it { is_expected.to have_attributes(output: '') }
    end
  end

  describe '#write_line' do
    before { instance.write_line('some text') }
    it { is_expected.to have_attributes(output: "some text\n") }
  end

  describe '#write_lf' do
    before { 3.times { |_| instance.write_lf } }
    it { is_expected.to have_attributes(output: "\n\n\n") }
  end

  context 'file related' do
    let(:tempfile) { Tempfile.new('file') }

    before do
      tempfile

      subject.write_line('def initialize(a)')
      subject.write_line('# comment')
      subject.write_line('end')
    end
    after { tempfile.unlink }

    describe '#write_file' do
      before do
        instance.write_file(tempfile.path)
      end

      it 'will write the correct output' do
        output = File.read(tempfile.path)
        expect(output).to eq("def initialize(a)\n# comment\nend\n")
      end

      # WARNING: the following functional tests should only be enabled for manual testing
      # describe 'functional tests' do
      #   describe 'open in vscode' do
      #     # it 'should open the tempfile in VSCode' do
      #     #   # puts tempfile.path
      #     #   # puts File.read(tempfile.path)
      #     #   instance.open_file_in_vscode(tempfile.path)
      #     #   puts File.read(tempfile.path)
      #     # end
      #   end
      # end
    end
  end
end
