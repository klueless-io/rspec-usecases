# Rspec Usecases

> Rspec Usecases helps to write self-documenting code usage examples that execute as normal unit tests while outputting documentation in varied formats

As a Ruby Developer, I want to document code usage examples, so that people can get going quickly with implementation

## Development radar

### Stories next on list

As a Developer, I can generate documentation in various formats, so that I easily document ruby applications

- Build Documentor with flexible renderer plugins

As a Developer, I can build documentable usecases, so that I easily document usage examples

- Build Usecase

As a Developer, I can build documentation presentations, so that I can create videos quickly

- https://revealjs.com/
- https://mofesolapaul.github.io/sectionizr/

### Tasks next on list

Setup GitHub Action (test and lint)

- Setup Rspec action
- Setup RuboCop action

## Stories and tasks

### Stories - completed

As a Developer, I can extend Rspec with code specific documentation extensions, so that I easily build documentation that parses unit tests

As a Developer, I can have component based renderers, so that I easily extend documentation output renders

- Build JSON renderer
- Build Debug renderer
- Build Markdown renderer

Remove cooline and jazz_fingers gem from github actions by running from env variable

- On Mac `export RUBY_DEBUG_DEVELOPMENT=true`

As a Developer, I can extract code and other content from unit test, so that I can inject it into documentation

- Build Content, ContentCode an ContentOutcome

### Tasks - completed

Move content.\* into a namespace called contents

- Content items take on the same role as Rspec::Example

Setup RubyGems and RubyDoc

- Build and deploy gem to [rubygems.org](https://rubygems.org/gems/rspec-usecases)
- Attach documentation to [rubydoc.info](https://rubydoc.info/github/to-do-/rspec-usecases/master)

Setup project management, requirement and SCRUM documents

- Setup readme file
- Setup user stories and tasks
- Setup a project backlog
- Setup an examples/usage document

Setup new Ruby GEM

- Build out a standard GEM structure
- Add automated semantic versioning
- Add Rspec unit testing framework
- Add RuboCop linting
- Add Guard for automatic watch and test
- Add GitFlow support
- Add GitHub Repository
