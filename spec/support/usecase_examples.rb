# frozen_string_literal: true

module UsecaseExamples
  def create_complex_document(json: false,
                              debug: false,
                              markdown: false,
                              markdown_file: 'generate_markdown.md',
                              markdown_prettier: false,
                              markdown_open: false,
                              document_title: 'title',
                              document_description: 'description')

    documentor_settings = {
      usecases: true,
      json: json,
      debug: debug,
      markdown: markdown,
      markdown_file: markdown_file,
      markdown_prettier: markdown_prettier,
      markdown_open: markdown_open,
      document_title: document_title,
      document_description: document_description
    }

    descendant_children = [
      create_describe,
      create_usecase1,
      create_usecase2
    ]

    double('RootExampleGroup',
           descendants: descendant_children,
           metadata: documentor_settings)
  end

  def create_example_group
    double('RootExampleGroup',
           descendants: descendant_children,
           metadata: documentor_settings)
  end

  # Create multiple depth context groups
  #
  # Equivalent to:
  # describe 'A' do
  #   context 'B' do
  #     context 'C' do
  #       describe 'Default Title' do
  #       end
  #     end
  #   end
  # end
  def create_descendant_parents
    double(parent_groups: [
             double(description: 'Default Title'),
             double(description: 'C'),
             double(description: 'B'),
             double(description: 'A')
           ])
  end

  def create_describe
    double('ExampleGroup',
           metadata: {},
           example_group: descendant_parents,
           descendants: [])
  end

  def create_usecase1
    double('ExampleGroupUsecase',
           metadata: { usecase: true, description: 'Fuckit' },
           name: 'usecase1',
           example_group: descendant_parents,
           descendants: [],
           examples: [])
  end

  def create_usecase2
    double('ExampleGroupUsecase',
           metadata: {
             usecase: true,
             usage: 'MyClass.load',
             usage_description: 'My custom usage description',
             title: 'My custom title',
             summary: 'My usecase summary'
           },
           name: 'usecase2',
           example_group: descendant_parents,
           descendants: [],
           examples: [
             create_content_outcome1,
             create_content_code1
           ])
  end

  def create_usecase3
    double('ExampleGroupUsecase',
           metadata: {
             usecase: true,
             title: 'My custom title with content examples',
             usage: 'MyClass.load',
             usage_description: 'MyClass.load - description goes here'
           },
           name: 'usecase3',
           example_group: descendant_parents,
           descendants: [],
           examples: [
             create_content_outcome1,
             create_content_code1
           ])
  end

  def create_content_outcome1
    double('Example',
           description: 'outcome 1',
           metadata: {
             summary: 'outcome summary 1',
             content_type: :outcome
           })
  end

  def create_content_code1
    double('Example',
           description: 'code 1',
           metadata: {
             content_type: :code,
             summary: 'code summary 1',
             code_type: :ruby,
             block: double(source: 'ruby "xyz" do # some code goes here; end')
           })
  end
end
