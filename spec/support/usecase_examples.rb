# frozen_string_literal: true

module UsecaseExamples
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
           metadata: { usecase: true },
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
             code_type: :ruby,
             block: double(source: 'ruby "xyz" do code summary 1 end')
           })
  end
end
