PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/mysql/bin:/Volumes/Data/Users/nicholas/Documents/Development/bin:/Users/nicholas/Documents/Development/bin"

#*****************************************************************************
# SVN
#*****************************************************************************
alias sup='svn up' # trust me 3 chars makes a different
alias sst='svn st' # local file changes
alias sstu='svn st -u' # remote repository changes
alias scom='svn commit' # commit
alias svnclear='find . -name .svn -print0 | xargs -0 rm -rf' # removes all .svn folders from directory recursively
alias svnaddall='svn status | grep "^\?" | awk "{print \$2}" | xargs svn add' # adds all unadded files
alias svndeleteall='find ./ -name ".svn" | xargs rm -Rf' # deletes all missing files

#*****************************************************************************
# Git
#*****************************************************************************

alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff | mate'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'

alias git-remove='git ls-files --deleted | xargs git rm'

function parse_git_branch {
  ref=$(/usr/local/libexec/git-core/git-symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")" 
}

PS1="\h: \w \$(parse_git_branch)\$ "

#*****************************************************************************
# Servers
#*****************************************************************************
RM=deploy@bsaouaf.railsmachina.com

#*****************************************************************************
# Configs
#*****************************************************************************

alias edit-http='mate /etc/apache2/extra/http'

#*****************************************************************************
# Tar/Compress
#*****************************************************************************

alias ctar='tar -zcvf' # archive_name.tar.gz directory_to_compress
alias etar='tar -zxvf' # archive_name.tar.gz (-C /tmp/extract_here/)

#*****************************************************************************
# Other
#*****************************************************************************

alias flushcache='sudo dscacheutil -flushcache'

export EDITOR='/usr/bin/mate -w'
