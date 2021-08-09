.PHONY: all

all: target/public/fr.html

cynefin-eu-field-guide.pot: en.adoc
	po4a-gettextize -f asciidoc -m $< --master-charset "UTF-8" --po $@

target/fr.adoc: fr_FR.po cynefin-eu-field-guide.pot en.adoc
	po4a-translate --format asciidoc \
		--master en.adoc --master-charset "UTF-8" \
		--po fr_FR.po \
		--localized $@ --localized-charset "UTF-8" \
		--keep 0

target/public/fr.html: target/fr.adoc
	asciidoctor -D . --backend html5 -o $@ $<
