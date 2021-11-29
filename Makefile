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
run:
	make build
	gemat md --all t
check:
	make test
	make lint
	make run
all_options:
	gemat csv --input ./Gemfile --output test.csv --columns index repo_uri name documentation_uri gem_uri version authors description
	gemat md --all -t
