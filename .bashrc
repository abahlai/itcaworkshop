# # Starship init
# eval "$(starship init bash)"

# direnv hook init
eval "$(direnv hook bash)"

# Kubectl completion and aliases
source <(kubectl completion bash)
alias k=kubectl
alias vi=vim
alias gst='git status'
alias cls='printf "\033c"'
complete -F __start_kubectl k
export EDITOR="vim"

# Terraform aliases
[ -f ~/.terraform_aliases ] && source ~/.terraform_aliases
function terraform() { echo "+ terraform $@"; command terraform $@; }

# Awesome oneliners
b64d () {
  echo "$1" | base64 -d ; echo
}

b64e () {
  echo -n "$1" | base64
}
