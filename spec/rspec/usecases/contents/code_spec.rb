# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Contents::Code, :usecases do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  let(:document) { @documentor.document }

  let(:usecase) { document.groups[0] }
  let(:usecase_code) { usecase.contents[0] }
  let(:usecase_ruby) { usecase.contents[1] }
  let(:usecase_css) { usecase.contents[2] }
  let(:usecase_js) { usecase.contents[3] }
  let(:usecase_javascript) { usecase.contents[4] }

  context 'with code blocks' do
    context 'general purpose code' do
      subject { usecase_code }
      it { is_expected.to have_attributes(category: :code, source: "puts 'some code'", type: :unknown) }
    end
    context 'ruby code' do
      subject { usecase_ruby }
      it { is_expected.to have_attributes(category: :code, source: "puts 'some ruby'", type: :ruby) }
    end
    context 'css' do
      subject { usecase_css }
      it { is_expected.to have_attributes(category: :code, source: "puts 'some css'", type: :css) }
    end
    context 'js code' do
      subject { usecase_js }
      it { is_expected.to have_attributes(category: :code, source: "puts 'some js'", type: :javascript) }
    end
    context 'javascript code' do
      subject { usecase_javascript }
      it { is_expected.to have_attributes(category: :code, source: "puts 'some javascript'", type: :javascript) }
    end
  end

  # ----------------------------------------------------------------------
  # configured usecases for the tests above
  # ----------------------------------------------------------------------

  # aka: usecase
  usecase 'usecase: handle code blocks' do
    # aka :usecase_code
    code do
      puts 'some code'
    end
    # aka :usecase_ruby
    ruby do
      puts 'some ruby'
    end
    # aka :usecase_css
    css do
      puts 'some css'
    end
    # aka :usecase_js
    js do
      puts 'some js'
    end
    # aka :usecase_javascript
    javascript do
      puts 'some javascript'
    end
  end

  # ruby :extract_comment do
  # #  a = 'hello'
  # #  # I'm a real comment
  # #  if a
  # #    puts "#{a}"
  # #  end
  # end

  # css :extract_heredoc do
  #   <<-CSS
  #   .some_class {
  #     color: blue
  #   }
  #   CSS
  # end
end
