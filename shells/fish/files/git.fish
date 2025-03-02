# Helper functions
function git_current_branch
    git branch --show-current
end

function git_main_branch
    command git rev-parse --git-dir &>/dev/null || return
    for ref in refs/heads/main refs/heads/trunk refs/heads/mainline refs/heads/default refs/heads/master
        if command git show-ref -q --verify $ref
            echo (string split -r -m1 / $ref)[2]
            return
        end
    end
    echo master
end

function git_develop_branch
    command git rev-parse --git-dir &>/dev/null || return
    for branch in dev devel development
        if command git show-ref -q --verify refs/heads/$branch
            echo $branch
            return
        end
    end
    echo develop
end

function current_branch
    git branch --show-current
end

# Git aliases for Fish shell
function grt --description 'cd to git root directory'
    cd (git rev-parse --show-toplevel || echo .)
end

function ggpnp --description 'git pull and push'
    ggl && ggp
end

function ggpur --description 'git pull upstream rebase'
    ggu
end

function g --description 'git'
    git $argv
end

function ga --description 'git add'
    git add $argv
end

function gaa --description 'git add all'
    git add --all $argv
end

function gapa --description 'git add patch'
    git add --patch $argv
end

function gau --description 'git add update'
    git add --update $argv
end

function gav --description 'git add verbose'
    git add --verbose $argv
end

function gwip --description 'git commit WIP'
    git add -A
    git rm (git ls-files --deleted) 2>/dev/null
    git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"
end

function gam --description 'git am'
    git am $argv
end

function gama --description 'git am abort'
    git am --abort $argv
end

function gamc --description 'git am continue'
    git am --continue $argv
end

function gamscp --description 'git am show current patch'
    git am --show-current-patch $argv
end

function gams --description 'git am skip'
    git am --skip $argv
end

function gap --description 'git apply'
    git apply $argv
end

function gapt --description 'git apply 3way'
    git apply --3way $argv
end

function gbs --description 'git bisect'
    git bisect $argv
end

function gbsb --description 'git bisect bad'
    git bisect bad $argv
end

function gbsg --description 'git bisect good'
    git bisect good $argv
end

function gbsn --description 'git bisect new'
    git bisect new $argv
end

function gbso --description 'git bisect old'
    git bisect old $argv
end

function gbsr --description 'git bisect reset'
    git bisect reset $argv
end

function gbss --description 'git bisect start'
    git bisect start $argv
end

function gbl --description 'git blame'
    git blame -w $argv
end

function gb --description 'git branch'
    git branch $argv
end

function gba --description 'git branch all'
    git branch --all $argv
end

function gbd --description 'git branch delete'
    git branch --delete $argv
end

function gbD --description 'git branch force delete'
    git branch --delete --force $argv
end

function gbgd --description 'git delete gone branches'
    env LANG=C git branch --no-color -vv | grep ": gone]" | cut -c 3- | awk '{print $1}' | xargs git branch -d
end

function gbgD --description 'git force delete gone branches'
    env LANG=C git branch --no-color -vv | grep ": gone]" | cut -c 3- | awk '{print $1}' | xargs git branch -D
end

function gbm --description 'git branch move'
    git branch --move $argv
end

function gbnm --description 'git branch no merged'
    git branch --no-merged $argv
end

function gbr --description 'git branch remote'
    git branch --remote $argv
end

function ggsup --description 'git set upstream to origin'
    git branch --set-upstream-to=origin/(git_current_branch)
end

function gbg --description 'git branch gone'
    env LANG=C git branch -vv | grep ": gone]"
end

function gco --description 'git checkout'
    git checkout $argv
end

function gcor --description 'git checkout recurse'
    git checkout --recurse-submodules $argv
end

function gcb --description 'git checkout branch'
    git checkout -b $argv
end

function gcB --description 'git checkout branch force'
    git checkout -B $argv
end

function gcd --description 'git checkout develop'
    git checkout (git_develop_branch)
end

function gcm --description 'git checkout main'
    git checkout (git_main_branch)
end

function gcp --description 'git cherry-pick'
    git cherry-pick $argv
end

function gcpa --description 'git cherry-pick abort'
    git cherry-pick --abort $argv
end

function gcpc --description 'git cherry-pick continue'
    git cherry-pick --continue $argv
end

function gclean --description 'git clean interactive'
    git clean --interactive -d $argv
end

function gcl --description 'git clone'
    git clone --recurse-submodules $argv
end

function gclf --description 'git clone filter'
    git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules $argv
end

function gccd --description 'git clone and cd'
    set repo $argv[1]
    git clone --recurse-submodules $repo && cd (basename $repo .git)
end

function gcam --description 'git commit all with message'
    git commit --all --message $argv
end

function gcas --description 'git commit all signoff'
    git commit --all --signoff $argv
end

function gcasm --description 'git commit all signoff message'
    git commit --all --signoff --message $argv
end

function gcmsg --description 'git commit message'
    git commit --message $argv
end

function gcsm --description 'git commit signoff message'
    git commit --signoff --message $argv
end

function gc --description 'git commit verbose'
    git commit --verbose $argv
end

function gca --description 'git commit all verbose'
    git commit --verbose --all $argv
end

function 'gca!' --description 'git commit all amend'
    git commit --verbose --all --amend $argv
end

function 'gcan!' --description 'git commit all no edit amend'
    git commit --verbose --all --no-edit --amend $argv
end

function 'gcans!' --description 'git commit all signoff no edit amend'
    git commit --verbose --all --signoff --no-edit --amend $argv
end

function 'gcann!' --description 'git commit all date now no edit amend'
    git commit --verbose --all --date=now --no-edit --amend $argv
end

function 'gc!' --description 'git commit amend'
    git commit --verbose --amend $argv
end

function gcn --description 'git commit no edit'
    git commit --verbose --no-edit $argv
end

function 'gcn!' --description 'git commit no edit amend'
    git commit --verbose --no-edit --amend $argv
end

function gcs --description 'git commit signed'
    git commit -S $argv
end

function gcss --description 'git commit signed signoff'
    git commit -S -s $argv
end

function gcssm --description 'git commit signed signoff message'
    git commit -S -s -m $argv
end

function gcf --description 'git config list'
    git config --list $argv
end

function gdct --description 'git describe tags'
    git describe --tags (git rev-list --tags --max-count=1)
end

function gd --description 'git diff'
    git diff $argv
end

function gdca --description 'git diff cached'
    git diff --cached $argv
end

function gdcw --description 'git diff cached word'
    git diff --cached --word-diff $argv
end

function gds --description 'git diff staged'
    git diff --staged $argv
end

function gdw --description 'git diff word'
    git diff --word-diff $argv
end

function gdv --description 'git diff view'
    git diff -w $argv | view -
end

function gdup --description 'git diff upstream'
    git diff @{upstream} $argv
end

function gdnolock --description 'git diff no lockfiles'
    git diff $argv ":(exclude)package-lock.json" ":(exclude)*.lock"
end

function gdt --description 'git diff tree'
    git diff-tree --no-commit-id --name-only -r $argv
end

function gf --description 'git fetch'
    git fetch $argv
end

function gfa --description 'git fetch all'
    git fetch --all --tags --prune $argv
end

function gfo --description 'git fetch origin'
    git fetch origin $argv
end

function gg --description 'git gui citool'
    git gui citool $argv
end

function gga --description 'git gui amend'
    git gui citool --amend $argv
end

function ghh --description 'git help'
    git help $argv
end

function glgg --description 'git log graph'
    git log --graph $argv
end

function glgga --description 'git log graph all'
    git log --graph --decorate --all $argv
end

function glgm --description 'git log graph max-count'
    git log --graph --max-count=10 $argv
end

function glod --description 'git log graph date'
    git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' $argv
end

function glods --description 'git log graph date short'
    git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short $argv
end

function glol --description 'git log graph pretty'
    git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' $argv
end

function glola --description 'git log graph pretty all'
    git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all $argv
end

function glols --description 'git log graph pretty stat'
    git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat $argv
end

function glo --description 'git log oneline'
    git log --oneline --decorate $argv
end

function glog --description 'git log oneline graph'
    git log --oneline --decorate --graph $argv
end

function gloga --description 'git log oneline graph all'
    git log --oneline --decorate --graph --all $argv
end

function glp --description 'git log pretty'
    git log --pretty=$argv
end

function glg --description 'git log stat'
    git log --stat $argv
end

function glgp --description 'git log stat patch'
    git log --stat --patch $argv
end

function gignored --description 'git ls-files ignored'
    git ls-files -v | grep "^[[:lower:]]" $argv
end

function gfg --description 'git ls-files grep'
    git ls-files | grep $argv
end

function gm --description 'git merge'
    git merge $argv
end

function gma --description 'git merge abort'
    git merge --abort $argv
end

function gmc --description 'git merge continue'
    git merge --continue $argv
end

function gms --description 'git merge squash'
    git merge --squash $argv
end

function gmff --description 'git merge ff-only'
    git merge --ff-only $argv
end

function gmom --description 'git merge origin main'
    git merge origin/(git_main_branch) $argv
end

function gmum --description 'git merge upstream main'
    git merge upstream/(git_main_branch) $argv
end

function gmtl --description 'git mergetool'
    git mergetool --no-prompt $argv
end

function gmtlvim --description 'git mergetool vimdiff'
    git mergetool --no-prompt --tool=vimdiff $argv
end

function gl --description 'git pull'
    git pull $argv
end

function gpr --description 'git pull rebase'
    git pull --rebase $argv
end

function gprv --description 'git pull rebase verbose'
    git pull --rebase -v $argv
end

function gpra --description 'git pull rebase autostash'
    git pull --rebase --autostash $argv
end

function gprav --description 'git pull rebase autostash verbose'
    git pull --rebase --autostash -v $argv
end

function gprom --description 'git pull rebase origin main'
    git pull --rebase origin (git_main_branch) $argv
end

function gpromi --description 'git pull rebase origin main interactive'
    git pull --rebase=interactive origin (git_main_branch) $argv
end

function gprum --description 'git pull rebase upstream main'
    git pull --rebase upstream (git_main_branch) $argv
end

function gprumi --description 'git pull rebase upstream main interactive'
    git pull --rebase=interactive upstream (git_main_branch) $argv
end

function ggpull --description 'git pull origin current'
    git pull origin (git_current_branch) $argv
end

function ggl --description 'git pull origin current'
    git pull origin (current_branch) $argv
end

function gluc --description 'git pull upstream current'
    git pull upstream (git_current_branch) $argv
end

function glum --description 'git pull upstream main'
    git pull upstream (git_main_branch) $argv
end

function gp --description 'git push'
    git push $argv
end

function gpd --description 'git push dry-run'
    git push --dry-run $argv
end

function 'gpf!' --description 'git push force'
    git push --force $argv
end

function ggf --description 'git push force origin current'
    git push --force origin (current_branch) $argv
end

function gpf --description 'git push force-with-lease'
    if git --version | string match -rq "git version (2\.[3-9]|[3-9])"
        git push --force-with-lease --force-if-includes $argv
    else
        git push --force-with-lease $argv
    end
end

function ggfl --description 'git push force-with-lease origin current'
    git push --force-with-lease origin (current_branch) $argv
end

function gpsup --description 'git push set-upstream'
    git push --set-upstream origin (git_current_branch) $argv
end

function gpsupf --description 'git push set-upstream force'
    if git --version | string match -rq "git version (2\.[3-9]|[3-9])"
        git push --set-upstream origin (git_current_branch) --force-with-lease --force-if-includes $argv
    else
        git push --set-upstream origin (git_current_branch) --force-with-lease $argv
    end
end

function gpv --description 'git push verbose'
    git push --verbose $argv
end

function gpoat --description 'git push origin all and tags'
    git push origin --all && git push origin --tags $argv
end

function gpod --description 'git push origin delete'
    git push origin --delete $argv
end

function ggpush --description 'git push origin current'
    git push origin (git_current_branch) $argv
end

function ggp --description 'git push origin current'
    git push origin (current_branch) $argv
end

function gpu --description 'git push upstream'
    git push upstream $argv
end

function grb --description 'git rebase'
    git rebase $argv
end

function grba --description 'git rebase abort'
    git rebase --abort $argv
end

function grbc --description 'git rebase continue'
    git rebase --continue $argv
end

function grbi --description 'git rebase interactive'
    git rebase --interactive $argv
end

function grbo --description 'git rebase onto'
    git rebase --onto $argv
end

function grbs --description 'git rebase skip'
    git rebase --skip $argv
end

function grbd --description 'git rebase develop'
    git rebase (git_develop_branch) $argv
end

function grbm --description 'git rebase main'
    git rebase (git_main_branch) $argv
end

function grbom --description 'git rebase origin main'
    git rebase origin/(git_main_branch) $argv
end

function grbum --description 'git rebase upstream main'
    git rebase upstream/(git_main_branch) $argv
end

function grf --description 'git reflog'
    git reflog $argv
end

function gr --description 'git remote'
    git remote $argv
end

function grv --description 'git remote verbose'
    git remote --verbose $argv
end

function gra --description 'git remote add'
    git remote add $argv
end

function grrm --description 'git remote remove'
    git remote remove $argv
end

function grmv --description 'git remote rename'
    git remote rename $argv
end

function grset --description 'git remote set-url'
    git remote set-url $argv
end

function grup --description 'git remote update'
    git remote update $argv
end

function grh --description 'git reset'
    git reset $argv
end

function gru --description 'git reset --'
    git reset -- $argv
end

function grhh --description 'git reset hard'
    git reset --hard $argv
end

function grhk --description 'git reset keep'
    git reset --keep $argv
end

function grhs --description 'git reset soft'
    git reset --soft $argv
end

function gpristine --description 'git reset and clean'
    git reset --hard && git clean --force -dfx $argv
end

function gwipe --description 'git reset and clean'
    git reset --hard && git clean --force -df $argv
end

function groh --description 'git reset origin hard'
    git reset origin/(git_current_branch) --hard $argv
end

function grs --description 'git restore'
    git restore $argv
end

function grss --description 'git restore source'
    git restore --source $argv
end

function grst --description 'git restore staged'
    git restore --staged $argv
end

function gunwip --description 'git unwip'
    git rev-list --max-count=1 --format="%s" HEAD | grep -q "--wip--" && git reset HEAD~1 $argv
end

function grev --description 'git revert'
    git revert $argv
end

function grm --description 'git rm'
    git rm $argv
end

function grmc --description 'git rm cached'
    git rm --cached $argv
end

function gcount --description 'git shortlog'
    git shortlog --summary -n $argv
end

function gsh --description 'git show'
    git show $argv
end

function gsps --description 'git show pretty short'
    git show --pretty=short --show-signature $argv
end

function gstall --description 'git stash all'
    git stash --all $argv
end

function gstu --description 'git stash untracked'
    git stash --include-untracked $argv
end

function gstaa --description 'git stash apply'
    git stash apply $argv
end

function gstc --description 'git stash clear'
    git stash clear $argv
end

function gstd --description 'git stash drop'
    git stash drop $argv
end

function gstl --description 'git stash list'
    git stash list $argv
end

function gstp --description 'git stash pop'
    git stash pop $argv
end

function gsta --description 'git stash push/save'
    if git --version | string match -rq "git version (2\.1[3-9]|2\.[2-9]|[3-9])"
        git stash push $argv
    else
        git stash save $argv
    end
end

function gsts --description 'git stash show patch'
    git stash show --patch $argv
end

function gst --description 'git status'
    git status $argv
end

function gss --description 'git status short'
    git status --short $argv
end

function gsb --description 'git status short branch'
    git status --short -b $argv
end

function gsi --description 'git submodule init'
    git submodule init $argv
end

function gsu --description 'git submodule update'
    git submodule update $argv
end

function gsd --description 'git svn dcommit'
    git svn dcommit $argv
end

function git-svn-dcommit-push --description 'git svn dcommit and push'
    git svn dcommit && git push github (git_main_branch):svntrunk $argv
end

function gsr --description 'git svn rebase'
    git svn rebase $argv
end

function gsw --description 'git switch'
    git switch $argv
end

function gswc --description 'git switch create'
    git switch -c $argv
end

function gswd --description 'git switch develop'
    git switch (git_develop_branch) $argv
end

function gswm --description 'git switch main'
    git switch (git_main_branch) $argv
end

function gta --description 'git tag annotate'
    git tag --annotate $argv
end

function gts --description 'git tag sign'
    git tag -s $argv
end

function gtv --description 'git tag sort'
    git tag | sort -V $argv
end

function gignore --description 'git update-index assume-unchanged'
    git update-index --assume-unchanged $argv
end

function gunignore --description 'git update-index no-assume-unchanged'
    git update-index --no-assume-unchanged $argv
end

function gwch --description 'git whatchanged'
    git whatchanged -p --abbrev-commit --pretty=medium $argv
end

function gwt --description 'git worktree'
    git worktree $argv
end

function gwtls --description 'git worktree list'
    git worktree list $argv
end

function gwtmv --description 'git worktree move'
    git worktree move $argv
end

function gwtrm --description 'git worktree remove'
    git worktree remove $argv
end

function gk --description 'gitk all'
    gitk --all --branches &
end

function gke --description 'gitk all reflogs'
    gitk --all (git log --walk-reflogs --pretty=%h) &
end

function gtl --description 'git tag list'
    function _gtl
        git tag --sort=-v:refname -n --list $argv[1]*
    end
    _gtl $argv
end

