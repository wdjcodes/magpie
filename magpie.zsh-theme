
# Prints the current path for the prompt, making it relative to the supplied
# repo path if provided and not empty. Otherwise will use the zsh ~ shortening
function __pwd_abridged {
    repo_path=$(__git_prompt_git rev-parse --show-toplevel 2>/dev/null)
    if [ -z "$repo_path" ]; then
        echo "%{$fg[white]%}%0~"
        return
    fi
    relative_path=$(realpath --relative-to=$repo_path $PWD)
    if [ ${#relative_path} -le 2 ]; then relative_path=''; fi

    if __is_head_detached; then
        branch_color="%{$reset_color%}%{$fg[cyan]%}"
    else
        branch_color="%{$reset_color%}%{$fg[red]%}"
    fi

    prompt="%{$fg_bold[magenta]%}git:[%{$reset_color%}${repo_path:t}:"
    prompt+=$branch_color
    prompt+=$(git_prompt_info)$(git_prompt_status)
    prompt+="%{$reset_color%}%{$fg_bold[magenta]%}]%{$reset_color%}/$relative_path"
    echo $prompt
}

function __is_head_detached {
    ignored=$(__git_prompt_git symbolic-ref -q HEAD)
    return $?
}

PROMPT=$'%{$fg_bold[magenta]%}[%T]%b %{$fg[cyan]%}%n@${HOST} '
PROMPT+='$(__pwd_abridged $repo_path)'
PROMPT+=$'\n'
PROMPT+="%(?:%{$fg_bold[cyan]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}%{$fg_bold[red]%} *"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$reset_color%}%{$fg_bold[red]%}↑"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$reset_color%}%{$fg_bold[red]%}↓"