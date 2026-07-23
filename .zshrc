nitch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

ZSH_THEME="powerlevel10k/powerlevel10k"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

plugins=(git)

export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"

# Colores personalizados
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[command]='fg=223'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=223'
ZSH_HIGHLIGHT_STYLES[alias]='fg=223'
ZSH_HIGHLIGHT_STYLES[function]='fg=223'

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/oh-my-zsh.sh

autoload -Uz compinit
compinit

# Selection menu
zstyle ':completion:*' menu select

zmodload zsh/complist

bindkey '^I' menu-complete
bindkey '^[[Z' reverse-menu-complete

# Ignore Uppercase/Lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Show descriptions
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init zsh --cmd cd)"

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Eza finder (alternative to ls)
alias ls='eza -lh --icons'
alias la='eza -lha --icons'
alias tree='eza --tree --icons'

export PATH=$PATH:/home/jair/.spicetify
