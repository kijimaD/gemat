# frozen_string_literal: true

module Gemat
  class Formatter
    def initialize(gems, columns, write_path: nil)
      @gems = gems
      @columns = columns
      @write_path = write_path
      @rows = []
      gen_rows
    end

    def run
      if @write_path
        File.open(@write_path, 'w') do |file|
          each_write(@rows) { |string| file << string }
        end
      else
        print "\n\n"
        each_write(@rows) { |string| print string }
        print "\n"
      end
    end

    private

    def each_write(rows, &proc)
      rows.each do |row|
        proc.call(row)
        proc.call("\n")
      end
    end
  end
end
