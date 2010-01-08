.PHONY: all test clean distclean dist js yui

all: js test

lib/JavaScript/V8x/TestMoreish/JS.pm: js/TestMoreishJS.pm js/*.js
	tpage $< > $@

js: lib/JavaScript/V8x/TestMoreish/JS.pm

yui:
	curl 'http://yui.yahooapis.com/combo?2.8.0r4/build/yahoo/yahoo.js&2.8.0r4/build/event/event.js&2.8.0r4/build/dom/dom.js&2.8.0r4/build/logger/logger.js&2.8.0r4/build/yuitest/yuitest.js' > js/yui.js

dist:
	rm -rf inc META.y*ml
	perl Makefile.PL
	$(MAKE) -f Makefile dist

install distclean tardist: Makefile
	$(MAKE) -f $< $@

test: Makefile
	TEST_RELEASE=1 $(MAKE) -f $< $@

Makefile: Makefile.PL
	perl $<

clean: distclean

reset: clean
	perl Makefile.PL
	$(MAKE) test
