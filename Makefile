.PHONY: rel stagedevrel test

REBAR ?= ./rebar3

all: compile

compile:
	$(REBAR) compile

clean:
	$(REBAR) clean

distclean:
	$(REBAR) clean -a

check:
	$(REBAR) eunit
	$(REBAR) dialyzer
	$(REBAR) xref

escriptize:
	$(REBAR) escriptize

##
## Doc targets
##
docs:
	$(REBAR) edoc

pages: docs
	cp priv/index.html doc/_index.html
	cp priv/ForkMe_Blk.png doc/
	cp priv/*.jpg doc/
	git checkout gh-pages
	mv doc/_index.html ./index.html
	mv doc/ForkMe_Blk.png .
	mv doc/*.jpg .
	rm -rf edoc/*
	cp -R doc/* edoc/
	git add .
	git add -u
	git commit
	git push origin gh-pages
	git checkout master
