test:
	bundle exec rspec --format documentation
cov:
	COVERAGE=true bundle exec rspec --format documentation
open:
	export TERM=xterm && COVERAGE=true bundle exec rspec && xdg-open coverage/index.html
lint:
	bundle exec rubocop
build:
	rake install
publish:
	rake release
