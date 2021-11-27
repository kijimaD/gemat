# frozen_string_literal: true

require 'bundler'

module Gemat
  class Dsl
    attr_accessor :dependencies, :sources, :git_sources, :groups

    # rubocop:disable Metrics/MethodLength
    def initialize(gemfile = nil)
      gemfile ||= Bundler.default_gemfile.to_s
      dsl = Bundler::Dsl.new
      dsl.eval_gemfile(gemfile)

      class << dsl
        attr_accessor :sources, :git_sources, :groups
      end

      @dependencies = dsl.dependencies
      @sources = dsl.sources
      @git_sources = dsl.git_sources
      @groups = dsl.groups
    end
    # rubocop:enable Metrics/MethodLength
  end
end
