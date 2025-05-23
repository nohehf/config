#!/bin/zsh
# A collection of custom bash functions

# git aliases (some from: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh)
alias gp='git push'
alias gsw='git switch'
alias gpmr='git push --set-upstream origin $(git branch | grep "*" | cut -d" " -f 2) -o merge_request.create -o merge_request.title="$(git branch | grep "*" | cut -b3- | sed -e "s/\//: /g" -e "s/-/ /g")" -o merge_request.assign="$(git config --get user.name)"'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --gpg-sign --message "--wip-- [skip ci]"'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
# clean branches that are already merged
alias gbclean="git branch -l | grep -v '\*' |  grep -x '.*/.*' | xargs git branch -d"

# TODO: depreate the commands above later, and use the packaged version once it exists
alias g='uv run --project /Users/nohehf/code/gitai gitai smart --model "google/gemini-2.0-flash-001"'
alias gac='uv run --project /Users/nohehf/code/gitai gitai commit --model "google/gemini-2.0-flash-001"'
alias gamr='uv run --project /Users/nohehf/code/gitai gitai mr --model "google/gemini-2.0-flash-001"'


# Git clean the current branch, and switch to the default branch
gbdone() {
    # get default branch name (remove origin/)
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD --short | sed 's/origin\///')
    current_branch=$(git branch --show-current)
    git checkout "$default_branch"
    git branch -d "$current_branch"
    git pull
}

# Rebase current branch on default branch
gbrebase() {
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD --short | sed 's/origin\///')
    current_branch=$(git branch --show-current)
    git switch "$default_branch"
    git pull
    git switch "$current_branch"
    git rebase "$default_branch"
}

# Merge current branch on default branch
gbmerge() {
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD --short | sed 's/origin\///')
    current_branch=$(git branch --show-current)
    git switch "$default_branch"
    git pull
    git switch "$current_branch"
    git merge "$default_branch"
}

# Globally disable / enable hooks, in .gitconfig
git_toggle_hooks() {
    # hooks path is /dev/null if disabled
    hooks_path=$(git config --global core.hooksPath)
    if [ "$hooks_path" = "/dev/null" ]; then
        git config --global --unset core.hooksPath
        echo "Hooks enabled globally in ~/.gitconfig"
    else
        git config --global core.hooksPath /dev/null
        echo "Hooks disabled globally in ~/.gitconfig"
    fi
}

# Source and export a given .env file
exsource () {
    set -o allexport
    source $@
    set +o allexport
}

