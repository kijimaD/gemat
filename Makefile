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
re:
	make build
	gemat md --all t
check:
	make test
	make lint
	make re
