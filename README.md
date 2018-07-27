# Personal Dotfiles

* Co-founder and Business Application Developer at [CivilCode Inc.](http://www.civilcode.io)
* Follow me on [Twitter](http://www.twitter.com/nicholasjhenry)
* Connect via [LinkedIn](http://ca.linkedin.com/in/nicholasjhenry)

## Installation

1. Setup CivilCode dotfiles: https://github.com/civilcode/dotfiles
2. Clone this repo to ~/Development/dotfiles.local
3. Execute `rcup`

## Post-installation

Add the following code to the top of .zshrc

    # required for "sheet"
    autoload -U compinit && compinit
    fpath=($HOME/.zsh-completions $fpath)
