# frozen_string_literal: true

RSpec.describe 'Document - Default Settings' do
  let(:instance) { Rspec::Usecases::Document.new(self.class, **options) }

  context 'json options' do
    describe '.json?' do
      subject { instance.json? }

      context 'no json options' do
        let(:options) { {} }
        it { is_expected.to eq(false) }
      end

      context 'has json options when symbol' do
        let(:options) { { json: :json } }
        it { is_expected.to eq(true) }
      end

      context 'has json options when boolean' do
        let(:options) { { json: true } }
        it { is_expected.to eq(true) }
      end
    end
  end

  context 'debug options' do
    describe '.debug?' do
      subject { instance.debug? }

      context 'no debug options' do
        let(:options) { {} }
        it { is_expected.to eq(false) }
      end

      context 'has debug options when symbol' do
        let(:options) { { debug: :debug } }
        it { is_expected.to eq(true) }
      end

      context 'has debug options when boolean' do
        let(:options) { { debug: true } }
        it { is_expected.to eq(true) }
      end
    end
  end

  context 'markdown options' do
    describe '.markdown?' do
      subject { instance.markdown? }

      context 'no markdown options' do
        let(:options) { {} }
        it { is_expected.to eq(false) }
      end

      context 'has markdown options when symbol' do
        let(:options) { { markdown: :markdown } }
        it { is_expected.to eq(true) }
      end

      context 'has markdown options' do
        let(:options) { { markdown: true } }
        it { is_expected.to eq(true) }
      end
    end
  end
end
