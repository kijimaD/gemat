# frozen_string_literal: true

module Gemat
  class MdFormatter
    def initialize(gems, columns = [OutDsl.new('name'), OutDsl.new('Repo URL')], output: nil)
      @gems = gems
      @columns = columns
      @output = output
      @rows = []
      gen_rows
    end

    def to_md
      if @output
        File.open(@output, 'w') { |file| each_write(@rows) { |string| file << string } }
      else
        print "\n\n"
        each_write(@rows) { |string| print string }
      end
    end

    private

    def gen_rows
      @rows << "| #{@columns.map(&:column_name).join(' | ')} |"
      @rows << "| #{Array.new(@columns.length, '----').join(' | ')} |"
      @gems.each do |gem|
        @rows << "| #{@columns.map { |dsl| dsl.call(gem) }.join(' | ')} |"
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
