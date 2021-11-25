# frozen_string_literal: true

require 'csv'

module Gemat
  class CsvFormatter
    DEFAULT_OUTPUT = 'gemat'

    def initialize(url, output = DEFAULT_OUTPUT)
      @url = url
      @output = output
    end

    def to_csv
      CSV.open(output_file, 'w') do |csv|
        csv << ['gem', 'Repo URL']
        @url.urls.each do |k, v|
          csv << [k, v]
        end
      end
      print "export to #{output_file}"
    end

    def output_file
      "#{@output}.csv"
    end
  end
end
