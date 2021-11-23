# frozen_string_literal: true

require_relative 'lib/gemfile_exporter/version'

Gem::Specification.new do |spec|
  spec.name          = 'gemfile_exporter'
  spec.version       = GemfileExporter::VERSION
  spec.authors       = ['kijimaD']
  spec.email         = ['norimaking777@gmail.com']

  spec.summary       = 'Export Gemfile several formats.'
  spec.description   = 'Export Gemfile several formats. CSV, Markdown etc.'
  spec.homepage      = 'https://github.com/kijimaD/gemfile_exporter'
  spec.license       = 'GPL3'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/kijimaD/gemfile_exporter'
  spec.metadata['changelog_uri'] = 'https://github.com/kijimaD/gemfile_exporter'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
