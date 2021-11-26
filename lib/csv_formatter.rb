# frozen_string_literal: true

require 'csv'

module Gemat
  class CsvFormatter
    def initialize(url, output = nil)
      @url = url
      @output = output
      @rows = []
      gen_array
    end

    def to_csv
      if @output then
        CSV.open(@output, 'w') do |csv|
          @rows.each { |row| csv << row }
        end
      else
        print "\n\n"
        @rows.each { |row| print row.to_csv }
      end
    end

    private

    def gen_array
      @rows << ['gem', 'Repo URL']
      @url.urls.each do |k, v|
        @rows << [k, v]
      end
    end
  end
end
