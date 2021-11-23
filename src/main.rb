# frozen_string_literal: true

require 'httpclient'
require 'json'

require_relative 'dsl'
require_relative 'get_url'

def main
    dsl = GemfileExporter::Dsl.new
    GemfileExporter::GetUrl.new(dsl).run
    # rubygemsのURLをどうやって生成しているのか
    # 実際どこでダウンロードしてるのかわからない
    # githubのURLを取るにはスクレイピングしかなさそう
end

main
