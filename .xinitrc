# default variables for all environments
export EDITOR=nvim
export MANPAGER="nvim -c ASMANPAGER -"
export PATH=$PATH:/home/chris/Documents/Ricing/scripts/
export PATH=$PATH:/home/chris/.dotnet/tools/
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#ebdbb2,fg+:#fabd2f,bg:#282828,bg+:#282828
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#b8bb26
  --color=prompt:#83a598,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --preview-window="border-rounded" --prompt="> " --marker=">" --pointer="*"
  --separator="─" --scrollbar="X" --layout="reverse" --info="right"'
setxkbmap -layout de -option compose:rctrl -option caps:escape &

# mouse
xinput --set-prop 10 "Synaptics Move Speed" 1.0, 1.0, 0.03459, 0.0
xinput --set-prop 10 "Device Accel Velocity Scaling" 4.5

# wm
~/.fehbg &
xsetroot -cursor_name left_ptr &
xset b off
xset r rate 200 35
sxhkd &
bspc config top_padding 35
dunst &
xrdb ~/.Xresources
polybar main &
batsignal &
exec bspwm


