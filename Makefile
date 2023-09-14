all :
	nvim --clean -u issue.lua

.PHONY : commit
commit :
	git commit -am "commit"
