# frozen_string_literal: true

require_relative 'dsl'

dsl = GemfileExporter::Dsl.new
p dsl

p dsl.dependencies
p dsl.sources
p dsl.git_sources
p dsl.groups
