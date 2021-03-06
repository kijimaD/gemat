# frozen_string_literal: true

module Gemat
  class InDsl
    attr_accessor :dependencies, :sources, :git_sources, :groups, :gemfiles

    # rubocop:disable Metrics/MethodLength
    def initialize(gemfile = nil)
      gemfile ||= Bundler.default_gemfile.to_s
      dsl = Bundler::Dsl.new
      dsl.eval_gemfile(gemfile)

      class << dsl
        attr_accessor :sources, :git_sources, :groups, :gemfiles
      end

      @dependencies = dsl.dependencies
      @sources = dsl.sources
      @git_sources = dsl.git_sources
      @groups = dsl.groups
      @gemfiles = dsl.gemfiles
    end
    # rubocop:enable Metrics/MethodLength
  end
end
