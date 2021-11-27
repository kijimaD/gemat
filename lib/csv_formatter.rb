# frozen_string_literal: true

require 'csv'

module Gemat
  class CsvFormatter
    def initialize(gems, output = nil)
      @gems = gems
      @output = output
      @rows = []
      gen_rows
    end

    def to_csv
      if @output
        CSV.open(@output, 'w') do |csv|
          @rows.each { |row| csv << row }
        end
      else
        print "\n\n"
        @rows.each { |row| print row.to_csv }
      end
    end

    private

    def gen_rows
      @rows << ['gem', 'Repo URL']
      @gems.each do |gem|
        @rows << [gem.name, gem.repo_url]
      end
    end
  end
end
