release: lit/markdown/source d-files
	@mkdir -p bin
	../bin/dub build --build=release
	@rm bin/tangle

debug: lit/markdown/source d-files
	@mkdir -p bin
	../bin/dub build

bin/tangle:
	../bin/dub --root=lit/tangle build

d-files: bin/tangle
	@mkdir -p source
	bin/tangle -odir source lit/*.lit

test: lit
	../bin/dub test

lit/markdown/source:
	@if [ ! -s lit/markdown/source ]; then \
		if [ ! -s .git ]; then \
			git clone https://github.com/zyedidia/dmarkdown lit/markdown; \
		else \
			git submodule init; \
			git submodule update; \
		fi \
	fi;

clean:
	../bin/dub clean
	../bin/dub clean --root=lit/markdown
	../bin/dub clean --root=lit/tangle

clean-all:
	../bin/dub clean
	../bin/dub clean --root=lit/markdown
	../bin/dub clean --root=lit/tangle
	rm -rf bin source
