require 'bundler'

module GemfileExporter
  class Dsl
    def self.evaluate(gemfile)
      builder = new
      builder.eval_gemfile(gemfile)
    end

    def initialize
      @dependencies = []
      @env = nil
      @gemfile = nil
      @gemfiles = []
      @git_sources = {}
      @groups = []
      @source = nil
    end

    def eval_gemfile(gemfile, contents = nil)
      contents ||= Bundler.read_file(gemfile.to_s)
      instance_eval(contents)
    end

    def gem(name, *args)
      p name
    end

    def source(source)
    end

    def git_source(name)
    end

    def path(path)
    end

    def git(uri)
    end

    def github(repo)
    end

    def to_definition(lockfile, unlock)
    end

    def group(*args, &block)
      yield
    end

    def install_if(*args)
    end

    def platforms(*platforms)
    end

    def env(name)
    end

    def plugin(*args)
    end

    def method_missing(name, *args)
      raise GemfileError, "Undefined local variable or method `#{name}' for Gemfile"
    end

    def ruby(version)
    end
  end
end

gemfile = "#{Bundler.default_gemfile.to_s}" + '_test'
GemfileExporter::Dsl.evaluate(gemfile)
