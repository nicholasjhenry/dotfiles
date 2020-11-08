# ctags

Links:

* https://thoughtbot.com/upcase/videos/intelligent-navigation-with-ctags
* https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html

Install:

    brew tap universal-ctags/universal-ctags
    brew install --HEAD universal-ctags
    gem ctags

Setup:

    git init # to reinitialize with hooks
    # updated after based on git hooks (e.g. commit)
    git ctags

Tips:

    C-]
    gC-]
