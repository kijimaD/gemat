# frozen_string_literal: true

require 'logger'

module Gemat
  class MdFormatter
    def initialize(gems)
      @gems = gems
    end

    def to_md
      print "\n\n"
      puts '| gem | Repo URL |'
      puts '| ---- | ---- |'
      @gems.each do |gem|
        puts "| #{gem.name} | #{gem.repo_url} |"
      end
    end
  end
end
