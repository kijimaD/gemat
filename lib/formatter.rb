# frozen_string_literal: true

module Gemat
  class Formatter
    def initialize(gems, columns = [OutDsl.new('name'), OutDsl.new('Repo URL')], write_path: nil)
      @gems = gems
      @columns = columns
      @write_path = write_path
      @rows = []
      gen_rows
    end
  end
end
