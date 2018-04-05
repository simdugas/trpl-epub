BUILD_DATE=$(shell date +%Y-%m-%d)
ROOT_DIR=book/second-edition/
SRC_DIR=$(ROOT_DIR)/src/
NOSTARCH_DIR=$(ROOT_DIR)/nostarch/
THEME_DIR=book/first-edition/src/theme/
PANDOC_OPTS= \
		--strip-comments \
		--resource-path=$(SRC_DIR) \
		--css=rust.css \
		--highlight-style=tango \
		--from=markdown+smart+grid_tables+pipe_tables-simple_tables+raw_html+implicit_figures+footnotes+intraword_underscores+auto_identifiers-inline_code_attributes

all: dist

clean:
	rm -rf dist/ $(NOSTARCH_DIR)

$(NOSTARCH_DIR):
	chmod +x $(ROOT_DIR)/nostarch.sh
	cd $(ROOT_DIR) && ./nostarch.sh

dist/trpl-$(BUILD_DATE).epub:
	mkdir -p dist
	@pandoc -o dist/trpl-$(BUILD_DATE).epub \
		$(PANDOC_OPTS) \
		title.txt \
		$(SRC_DIR)/SUMMARY.md \
		$(SRC_DIR)/foreword.md \
		$(shell ls book/second-edition/src/ch*) \
		$(shell ls book/second-edition/src/appendix*)

dist/trpl-ns-$(BUILD_DATE).epub: $(NOSTARCH_DIR)
	mkdir -p dist
	@pandoc -o dist/trpl-ns-$(BUILD_DATE).epub \
		$(PANDOC_OPTS) \
		title.txt \
		$(shell ls $(NOSTARCH_DIR)/chapter*.md) \
		$(NOSTARCH_DIR)/appendix.md

dist: dist/trpl-$(BUILD_DATE).epub dist/trpl-ns-$(BUILD_DATE).epub
