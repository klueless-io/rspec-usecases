
# frozen_string_literal: true

RSpec.describe 'many usecases at levels 1,2 & 3 + some  of them are nested inside describe/context blocks', :usecases do

  # Describe / Context blocks are not considered part of the usecase hierarchy
  #
  # this means that if a usecase is nested inside of a context/describe then
  # the context/describe do not factor into it's hierarchial position

  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  subject { @documentor.document.groups }

  let(:documentor) { Rspec::Usecases::Documentor.new(@example_group) }

  context 'level 1' do
    it do
      is_expected.to include(have_attributes(title: 'valid level 1 usecase #1'),
                             have_attributes(title: 'valid level 1 usecase #2'),
                             have_attributes(title: 'valid level 1 usecase #3'))
    end
  end

  context 'level 2 children for #1' do
    subject { @documentor.document.groups[0].groups }
    it do
      is_expected.to include(have_attributes(title: 'valid level 2 usecase #1.1', ),
                             have_attributes(title: 'valid level 2 usecase #1.2'))
    end
  end

  context 'level 2 children for #2' do
    subject { @documentor.document.groups[1].groups }
    it do
      is_expected.to include(have_attributes(title: 'valid level 2 usecase #2.1', ),
                             have_attributes(title: 'valid level 2 usecase #2.2'))
    end
  end

  context 'level 2 children for #3' do
    subject { @documentor.document.groups[2].groups }
    it do
      is_expected.to include(have_attributes(title: 'valid level 2 usecase #3.1'))
    end

    context 'level 3 children for #3.1' do
      subject { @documentor.document.groups[2].groups[0].groups }
      it do
        is_expected.to include(have_attributes(title: 'valid level 3 usecase #3.1.1'),
                               have_attributes(title: 'valid level 3 usecase #3.1.2'),
                               have_attributes(title: 'valid level 3 usecase #3.1.3'))
      end
    end
  end

    # context 'level 2' do
    #   subject { @documentor.document.groups }
    #   it do
    #     @documentor.document.groups[0].groups.map(&:title)
    #     @documentor.document.groups[1].groups.map(&:title)
    #     @documentor.document.groups[2].groups.map(&:title)
    #     @documentor.document.groups[2].groups[0].groups.map(&:title)
    #     is_expected.to include(have_attributes(title: 'valid level 1 usecase #1'),
    #                            have_attributes(title: 'valid level 1 usecase #2'),
    #                            have_attributes(title: 'valid level 1 usecase #3'))
    #   end

# ["valid level 2 usecase #1.1", "valid level 2 usecase #1.2"]
# ["valid level 2 usecase #2.1", "valid level 2 usecase #2.2"]
# ["valid level 2 usecase #3.1"]
# ["valid level 3 usecase #3.1.1", "valid level 3 usecase #3.1.2"]
    # end
  

  usecase 'valid level 1 usecase #1' do
    # Nothing here yet

    usecase 'valid level 2 usecase #1.1' do
      # Nothing here yet
    end

    usecase 'valid level 2 usecase #1.2' do
      # Nothing here yet
    end
  end

  describe '#some_method' do
    usecase 'valid level 1 usecase #2' do
      # Nothing here yet
      context 'flatten me out of the hierarchy' do
        usecase 'valid level 2 usecase #2.1' do
          # Nothing here yet
        end
      end
      usecase 'valid level 2 usecase #2.2' do
        # Nothing here yet
      end
    end
  end

  context 'when configuration is setup' do
    usecase 'valid level 1 usecase #3' do
      # Nothing here yet
      describe 'flatten me out of the hierarchy' do
        usecase 'valid level 2 usecase #3.1' do
          # Nothing here yet

          usecase 'valid level 3 usecase #3.1.1' do
            # Nothing here yet
          end

          describe 'flatten me out of the hierarchy' do
            usecase 'valid level 3 usecase #3.1.2' do
              # Nothing here yet
            end
          end

          usecase 'valid level 3 usecase #3.1.3' do
            # Nothing here yet
          end
        end
      end
    end
  end
end
