# frozen_string_literal: true

module Gemat
  class Cli < Thor
    class_option input: :string, write_path: :string, columns: :array

    desc 'csv', 'export Gemfile to CSV file'
    def csv
      command(options, __method__)
    end

    desc 'md', 'export Gemfile to markdown'
    def md
      command(options, __method__)
    end

    no_tasks do
      def command(options, method_name)
        klass = "Gemat::#{method_name.capitalize}Formatter"
        Gemat.run(options) do |gems, columns|
          Object.const_get(klass).new(gems, columns, write_path: options[:write_path]).run
        end
      end
    end
  end
end
