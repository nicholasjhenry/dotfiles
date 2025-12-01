nicholasjhenry dotfiles
=======================

![prompt](http://images.thoughtbot.com/thoughtbot-dotfiles-prompt.png)

Prerequisites
-------------

The following dependencies have been installed using the [laptop](https://github.com/nicholasjhenry/laptop)
script and you SHOULD NOT have to install these manually.

Install [rcm](https://github.com/thoughtbot/rcm):

    brew tap thoughtbot/formulae
    brew install rcm

Install
-------

Clone onto your laptop:

    mkdir -p ~/Workspaces && cd ~/Workspaces
    git clone https://github.com/civilcode/dotfiles.git

Install the dotfiles:

    env RCRC=$HOME/Workspaces/dotfiles/rcrc rcup

After the initial installation, you can run `rcup` without the one-time variable
`RCRC` being set (`rcup` will symlink the repo's `rcrc` to `~/.rcrc` for future
runs of `rcup`). [See
example](https://github.com/thoughtbot/dotfiles/blob/master/rcrc).

This command will create symlinks for config files in your home directory.
Setting the `RCRC` environment variable tells `rcup` to use standard
configuration options:

* Exclude the `README.md` and `LICENSE` files, which are part of
  the `dotfiles` repository but do not need to be symlinked in.
* Give precedence to personal overrides which by default are placed in
  `~/Workspaces/dotfiles.local`

You can safely run `rcup` multiple times to update:

    rcup

You should run `rcup` after pulling a new version of the repository to symlink
any new files in the repository.

Make your own customizations
----------------------------

Create a directory for your personal customizations:

    mkdir ~/Workspaces/dotfiles.local

Put your customizations in `~/dotfiles.local` appended with `.local`:

* `~/Workspaces/dotfiles.local/aliases.local`
* `~/Workspaces/dotfiles.local/git_template.local/*`
* `~/Workspaces/dotfiles.local/gitconfig.local`
* `~/Workspaces/dotfiles.local/psqlrc.local` (we supply a blank `psqlrc.local` to prevent `psql` from
  throwing an error, but you should overwrite the file with your own copy)

For example, your `~/.aliases.local` might look like this:

    # Productivity
    alias todo='$EDITOR ~/.todo'

Your `~/.gitconfig.local` might look like this:

    [alias]
      l = log --pretty=colored
    [pretty]
      colored = format:%Cred%h%Creset %s %Cgreen(%cr) %C(bold blue)%an%Creset
    [user]
      name = Dan Croak
      email = dan@thoughtbot.com

To extend your `git` hooks, create executable scripts in
`~/.git_template.local/hooks/*` files.

Your `~/.bash.local` might look like this:

    # load pyenv if available
    if which pyenv &>/dev/null ; then
      eval "$(pyenv init -)"
    fi

Credits
-------

These dotfiles is based on and inspired by
[thoughtbot's dotfiles](https://github.com/thoughtbot/dotfiles).

thoughtbot's original work remains covered under an
[MIT License](https://github.com/thoughtbot/dotfiles/blob/a8bc74d10c62c813b625c0c8a28a996249d71c4c/LICENSE).

About the Me
------------

* Senior Software Developer
* Follow me on [Twitter](http://www.twitter.com/nicholasjhenry)
* Connect via [LinkedIn](http://ca.linkedin.com/in/nicholasjhenry)
