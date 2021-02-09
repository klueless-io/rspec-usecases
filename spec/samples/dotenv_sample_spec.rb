# frozen_string_literal: true

RSpec.describe 'dotenv', 
               :usecases,
               :skip_render,
               document_title: 'dotenv',
               document_description: 'Some examples of how to use Rspec::Usage',
               xjson: { write: true, open: true, file: 'docs/dotenv-installation.json', print: false },
               markdown: { write: true, open: true, file: 'docs/dotenv-installation.md', pretty: false, print: false } do

  src_folder = '/Users/davidcruwys/dev/gems_3rd/dotenv'
  src_readme = File.join(src_folder, 'README.md')
              
  usecase 'Overview' do

    raw nil, source_override: uc_file_as_markdown_content(src_readme, lines: [*(3..43)]) do
      #
    end
  end
end
