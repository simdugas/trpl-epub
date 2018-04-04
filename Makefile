INPUT_DIR=book/second-edition/src/
CHAPTERS=$(shell ls book/second-edition/src/ch*)
APPENDIX=$(shell ls book/second-edition/src/appendix*)
SRC_DIR="book/second-edition/src"

all: dist

clean:
	rm -rf dist/

dist/trpl.epub:
	mkdir -p dist
	@pandoc -o dist/trpl.epub \
		--resource-path=$(SRC_DIR) \
		title.txt \
		$(INPUT_DIR)/SUMMARY.md \
		$(INPUT_DIR)/foreword.md \
		$(CHAPTERS) \
		$(APPENDIX)

dist: dist/trpl.epub
