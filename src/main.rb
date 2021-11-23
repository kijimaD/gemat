# frozen_string_literal: true

require_relative 'dsl'
require 'nokogiri'
require 'open-uri'

dsl = GemfileExporter::Dsl.new

p dsl.dependencies.map(&:name)

base_url = "#{dsl.sources.all_sources[0].remotes[0].to_s}gems/"

dsl.dependencies.each do |gem|
  sleep 0.1
  p "start #{gem.name}..."
  url = base_url + gem.name
  web = URI.open(url)

  doc = Nokogiri::HTML.parse(web.read)
  release_url = doc.xpath('//*[@id="code"]')[0][:href]

  # "https://github.com/rails/rails/tree/v6.1.4.1"

  reg = %r{https://github.com/(\w+)/(\w+)}
  m = reg.match(release_url)
  user = m[1]
  repo = m[2]

  gh_url = "https://github.com/#{user}/#{repo}"
  p gh_url

  # p dsl.git_sources
  # p dsl.groups
  # p dsl.gemspecs

  # rubygemsのURLをどうやって生成しているのか
  # 実際どこでダウンロードしてるのかわからない
  # githubのURLを取るにはスクレイピングしかなさそう

end
