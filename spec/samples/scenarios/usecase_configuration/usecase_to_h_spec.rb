# frozen_string_literal: true

RSpec.describe 'UsecaseAttributes', :usecases do

  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  subject { @documentor.document.usecases }

  context 'check deep hash' do
    subject { instance.to_h }

    # it do
    #   is_expected.to eq(
    #     title: '',
    #     description: '',
    #     settings: {
    #       debug: false,
    #       json: false,
    #       markdown: false,
    #       markdown_file: 'generate_markdown.md',
    #       markdown_prettier: false,
    #       markdown_open: false
    #     },
    #     usecases: [{
    #       key: 'usecase1',
    #       title: 'Simple usecase block',
    #       deep_title: 'A B C Simple usecase block',
    #       summary: '',
    #       usage: '',
    #       usage_description: '',
    #       contents: []
    #     }, {
    #       title: 'Usecase block with multiple content',
    #       deep_title: 'A B C Usecase block with multiple content',
    #       summary: 'My usecase summary',
    #       usage: 'MyClass.load',
    #       usage_description: 'My custom usage description',
    #       key: 'usecase2',
    #       contents: [{
    #         title: 'outcome 1',
    #         source: '',
    #         summary: 'outcome summary 1',
    #         type: 'outcome',
    #         options: [
    #           is_hr: false
    #         ]
    #       }, {
    #         title: 'code 1',
    #         summary: 'code summary 1',
    #         source: '# some code goes here;',
    #         type: 'code',
    #         code_type: 'ruby',
    #         options: [
    #           is_hr: false
    #         ]
    #       }]
    #     }]
    #   )
    # end
  end

end
