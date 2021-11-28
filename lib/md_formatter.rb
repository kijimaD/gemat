# frozen_string_literal: true

module Gemat
  class MdFormatter
    def initialize(gems, dsls = [OutDsl.new('name'), OutDsl.new('Repo URL')], output: nil)
      @gems = gems
      @dsls = dsls
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
      @rows << "| #{@dsls.map(&:column_name).join(' | ')} |"
      @rows << '| ---- | ---- |'
      @gems.each do |gem|
        @rows << "| #{@dsls.map { |dsl| dsl.call(gem) }.join(' | ')} |"
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
