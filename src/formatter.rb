# frozen_string_literal: true

require 'csv'

module GemfileExporter
  class Formatter
    def initialize(url)
      @url = url
    end

    def to_csv
      CSV.open('test.csv', 'w') do |csv|
        @url.urls.each do |k, v|
          csv << [k, v]
        end
      end
    end
  end
end
