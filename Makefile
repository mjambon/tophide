# Copyright 2008 Martin Jambon. All rights reserved.
# This file is distributed under the terms stated in file LICENSE.

VERSION = 1.0.0
export VERSION

.PHONY: all install clean

all: META tophide.cmo
tophide.cmo: tophide.ml
	ocamlc -c tophide.ml

install:
	ocamlfind install tophide META tophide.cmi tophide.cmo

uninstall:
	ocamlfind remove tophide

clean:
	rm -f *.cmo *.cmi

META: META.in Makefile
	cat META.in > META
	echo 'version = "$(VERSION)"' >> META

archive:
	rm -rf /tmp/tophide /tmp/tophide-$(VERSION) && \
	 	cp -r . /tmp/tophide && \
		cd /tmp/tophide && \
			$(MAKE) clean && \
			$(MAKE) META && \
			rm -f *~ tophide*.tar* && \
		cd /tmp && cp -r tophide tophide-$(VERSION) && \
		tar czf tophide.tar.gz tophide && \
		tar cjf tophide.tar.bz2 tophide && \
		tar czf tophide-$(VERSION).tar.gz tophide-$(VERSION) && \
		tar cjf tophide-$(VERSION).tar.bz2 tophide-$(VERSION)
	mv /tmp/tophide.tar.gz /tmp/tophide.tar.bz2 ..
	mv /tmp/tophide-$(VERSION).tar.gz /tmp/tophide-$(VERSION).tar.bz2 ..
	cp ../tophide.tar.gz ../tophide.tar.bz2 $$WWW/
	cp ../tophide-$(VERSION).tar.gz ../tophide-$(VERSION).tar.bz2 $$WWW/
	cp README $$WWW/tophide-readme.txt
	cp LICENSE $$WWW/tophide-license.txt
	echo 'let tophide_version = "$(VERSION)"' > $$WWW/tophide-version.ml
