# frozen_string_literal: true

require_relative 'lib/gemat/version'

Gem::Specification.new do |spec|
  spec.name          = 'gemat'
  spec.version       = Gemat::VERSION
  spec.authors       = ['kijimaD']
  spec.email         = ['norimaking777@gmail.com']

  spec.summary       = 'Export Gemfile several formats.'
  spec.description   = 'Export Gemfile several formats. CSV, Markdown etc.'
  spec.homepage      = 'https://github.com/kijimaD/gemat'
  spec.license       = 'GPL3'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/kijimaD/gemat'
  spec.metadata['changelog_uri'] = 'https://github.com/kijimaD/gemat'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.glob('{assets,config,lib}/**/*', File::FNM_DOTMATCH)
  spec.bindir        = 'exe'
  spec.executables   = 'gemat'
  spec.require_paths = ['lib']

  spec.add_dependency 'httpclient'
  spec.add_dependency 'ruby-progressbar'
  spec.add_dependency 'thor'
end
