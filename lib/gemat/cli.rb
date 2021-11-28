# frozen_string_literal: true

module Gemat
  class Cli < Thor
    desc 'csv', 'export Gemfile to CSV file'
    method_options input: :string, output: :string, columns: :array
    def csv
      command(options, __method__)
    end

    desc 'md', 'export Gemfile to markdown'
    method_options input: :string, output: :string, columns: :array
    def md
      command(options, __method__)
    end

    no_tasks do
      def command(options, method_name)
        klass = "Gemat::#{method_name.capitalize}Formatter"
        Gemat.run(options) do |gems, columns|
          Object.const_get(klass).new(gems, columns, write_path: options[:output]).run
        end
      end
    end
  end
end
