# base these themes:
#   fino-time.zsh-theme
#   ys.zsh-theme
#   zeta.zsh-theme

# Colors
local white=$FG[255]
local gray=$FG[239]
local yellow=$FG[226]
local red=$FG[202]
local green=$FG[040]
local blue=$FG[033]
local white_bold=$terminfo[bold]$white
local gray_bold=$terminfo[bold]$gray
local yellow_bold=$terminfo[bold]$yellow
local red_bold=$terminfo[bold]$red
local green_bold=$terminfo[bold]$green
local blue_bold=$terminfo[bold]$blue


# Git info
ZSH_THEME_GIT_PROMPT_PREFIX="%{$green%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=""

# Git status
ZSH_THEME_GIT_PROMPT_ADDED="%{$green_bold%}+"
ZSH_THEME_GIT_PROMPT_DELETED="%{$red_bold%}-"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$red_bold%}*"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$blue_bold%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$yellow_bold%}="
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$yellow_bold%}?"


local current_dir='${PWD/#$HOME/~}'

local box_name='$(get_box_name)'
function get_box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || echo ${SHORT_HOST:-$HOST}
}

local time_stamp='$(get_time_stamp)'
function get_time_stamp {
    echo "%D %*"
}

local git_prompt='$(get_git_prompt)'
function get_git_prompt {
    if [[ -n $(git rev-parse --is-inside-work-tree 2>/dev/null) ]]; then
        local git_status="$(git_prompt_status)"
        if [[ -n $git_status ]]; then
            git_status="[$git_status%{$reset_color%}]"
            ZSH_THEME_GIT_PROMPT_PREFIX="%{$red%}"
        fi
        local git_prompt=" %{$gray%}<%{$reset_color%}$(git_prompt_info)$git_status%{$gray%}>%{$reset_color%}"
        echo $git_prompt
    fi
}


PROMPT="
# \
%{$green%}%n%{$reset_color%} \
%{$gray%}at%{$reset_color%} \
%{$blue%}${box_name}%{$reset_color%} \
%{$gray%}in%{$reset_color%} \
%{$yellow_bold%}${current_dir}%{$reset_color%}\
${git_prompt} \
%{$gray%}${time_stamp}%{$reset_color%}
%{$red%}$%{$reset_color%} "