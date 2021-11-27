# frozen_string_literal: true

require 'logger'

module Gemat
  class MdFormatter
    def initialize(gems, output = nil)
      @gems = gems
      @output = output
      @rows = []
      gen_rows
    end

    def to_md
      if @output
        File.open(@output, 'w') { |file| each_write(@rows) { |string| file.<< string } }
      else
        print "\n\n"
        each_write(@rows) { |string| print string }
      end
    end

    private

    def gen_rows
      @rows << '| gem | Repo URL |'
      @rows << '| ---- | ---- |'
      @gems.each do |gem|
        @rows << "| #{gem.name} | #{gem.repo_url} |"
      end
    end

    def each_write(rows, &proc)
      rows.each do |row|
        proc.call(row)
        proc.call("\n")
      end
    end
  end
end
