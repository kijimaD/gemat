test:
	bundle exec rspec --format documentation
cov:
	COVERAGE=true bundle exec rspec --format documentation
open:
	export TERM=xterm && COVERAGE=true bundle exec rspec && xdg-open coverage/index.html
lint:
	bundle exec rubocop
build:
	rake build
	gem install pkg/gemfile_exporter-0.1.0.gem
	gemfile_exporter
