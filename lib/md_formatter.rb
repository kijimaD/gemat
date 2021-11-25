# frozen_string_literal: true

require 'logger'

module Gemat
  class MdFormatter
    def initialize(url)
      @url = url
    end

    def to_md
      print "\n\n"
      puts '| gem | Repo URL |'
      puts '| ---- | ---- |'
      @url.urls.each do |k, v|
        puts "| #{k} | #{v} |"
      end
    end
  end
end
