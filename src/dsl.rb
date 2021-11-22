module GemfileExporter
  class Dsl
    def self.evaluate(gemfile)
      builder = new
      builder.eval_gemfile(gemfile)
    end
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

  def eval_gemfile
  end
end
