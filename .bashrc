safe_eval() {
    if command -v "$1" > /dev/null 2>&1; then
        eval "$("$@")"
    fi
}

export HISTSIZE=50000

# mise読み込み
export PATH="~/.local/bin:$PATH"
safe_eval mise activate bash

# PATH
if command -v go > /dev/null 2>&1; then
    export PATH="$(go env GOPATH)/bin:$PATH"
fi
export PATH="~/.self/:$PATH"

# alias
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias k9s='k9s --logoless'

alias get_kc='echo $KUBECONFIG'
alias set_kc='export KUBECONFIG=~/.kube/configs/$(ls -1 ~/.kube/configs|fzf)'

# 各種スクリプト読み込み
SOURCE_SCRIPTS=(
    "/usr/share/doc/git/contrib/completion/git-completion.bash"
    "/usr/share/doc/git/contrib/completion/git-prompt.sh"
)
for script in "${SOURCE_SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        source "$script"
    fi
done

# PS1
GIT_PART=""
if [ -n "$(type -t __git_ps1)" ]; then
    GIT_PART='$(echo "$(__git_ps1)"|sed -e "s/()//"|tr -d "\n")'
fi
export PS1="\[\e[1;31m\]\u\[\e[m\]:\[\e[1;34m\]\W\[\e[m\]${GIT_PART}\[\e[m\]$ \[\e[m\]"

# 各ツールの補完有効化
safe_eval task --completion bash
safe_eval fzf --bash
