out/app.js: src/Main.elm
	elm make --debug src/Main.elm --output=out/app.js

all: out/app.js
