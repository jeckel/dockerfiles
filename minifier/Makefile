SRC_DIR?=/project/src
DIST_DIR?=/project/dist

CSS_FILES=$(patsubst $(SRC_DIR)/%.css, $(DIST_DIR)/%.css, $(shell find $(SRC_DIR) -name '*.css' | sort))
JS_FILES=$(patsubst $(SRC_DIR)/%.js, $(DIST_DIR)/%.js, $(shell find $(SRC_DIR) -name '*.js' | sort))
HTML_FILES=$(patsubst $(SRC_DIR)/%.html, $(DIST_DIR)/%.html, $(shell find $(SRC_DIR) -name '*.html' | sort))

default: $(CSS_FILES) $(JS_FILES) $(HTML_FILES)

$(DIST_DIR)/%.html: $(SRC_DIR)/%.html
	@echo 'Minify HTML file: $< ===> $@'
	@mkdir -p "$(@D)"
	@html-minifier --collapse-whitespace $< -o $@

$(DIST_DIR)/%.css: $(SRC_DIR)/%.css
	@echo 'Minify CSS file: $< ===> $@'
	@mkdir -p "$(@D)"
	@csso $< --output $@

$(DIST_DIR)/%.js: $(SRC_DIR)/%.js
	@echo 'Minify JS file: $< ===> $@'
	@mkdir -p "$(@D)"
	@uglifyjs --compress --mangle -o $@ -- $<