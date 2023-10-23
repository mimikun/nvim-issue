.DEFAULT_GOAL := help

all :
	nvim --clean -u issue.lua

## Run git commit
.PHONY : commit
commit :
	git commit -am "commit"

## Run rm ./nvim-issue/
.PHONY : clean
clean :
	rm -rf ./nvim-issue

## Show help
.PHONY : help
help :
	@make2help $(MAKEFILE_LIST)
