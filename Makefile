out/app.js: src/*.elm
	elm make --debug src/Main.elm --output=out/app.js

all: out/app.js

test:
	elm-test

.PHONY: test
