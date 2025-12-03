abbr -a -- ldrush 'lando drush' # imported from a universal variable, see `help abbr`
abbr -a -- ddrush 'ddev drush'
abbr -a -- joystick 'sudo xboxdrv --detach-kernel-driver' # imported from a universal variable, see `help abbr`
abbr -a -- hibernate 'systemctl hibernate' # imported from a universal variable, see `help abbr`
abbr -a -- gs 'git status' # imported from a universal variable, see `help abbr`
abbr -a -- ff grep\ --include=\\settings.\{.php,local.php\}\ -rnw\ \'.\'\ -e\ \"WordToFind\" # imported from a universal variable, see `help abbr`
abbr -a -- drupalcs 'phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md' # imported from a universal variable, see `help abbr`
abbr -a -- mynotes 'nvim ~/Dropbox/Yuri-Notes/' # imported from a universal variable, see `help abbr`
abbr -a -- drupalcbf 'phpcbf --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md' # imported from a universal variable, see `help abbr`
abbr -a -- drupalcsp 'phpcs --standard=DrupalPractice --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md' # imported from a universal variable, see `help abbr`
abbr -a -- h 'history --show-time="%h/%d - %H:%M:%S "' # imported from a universal variable, see `help abbr`
abbr -a -- terminusk 'terminus auth:login --machine-token=af9R1juBzjiZA4euOL2GdKp91Ob1y80NgRStoCjBfKgA6' # imported from a universal variable, see `help abbr`
abbr -a -- terminusy 'terminus auth:login --machine-token=g8oRNGWjwERNeXUcYzIzakPfLAcek5s9HDrAKQNxSyC2E' # imported from a universal variable, see `help abbr`
abbr -a -- upgrade 'sudo apt update && sudo apt upgrade && sudo apt autoremove' # imported from a universal variable, see `help abbr`
abbr -a -- f grep\ -rnw\ \'.\'\ -e\ \"WordToFind\" # imported from a universal variable, see `help abbr`
abbr -a -- xon 'lando xdebug-on'
abbr -a -- xoff 'lando xdebug-off'
abbr -a -- cr 'lando drush cr'
abbr -a -- lg 'lazygit'


# Aliases
function ll --wraps='ls'
    ls -alF $argv
end
function la --wraps='ls'
    ls -A $argv
end
function l --wraps='ls'
    ls -CF $argv
end
function v --wraps='nvim'
    nvim $argv
end
function vim --wraps='nvim'
    nvim $argv
end

# Set the default text editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Terminal configuration
set -g KITTY_SHELL_INTEGRATION all

# Path configuration
fish_add_path /bin
fish_add_path /home/yuri/.config/composer/vendor/bin
fish_add_path /home/yuri/.config/composer/vendor/bin
fish_add_path /home/yuri/.config/composer/vendor/bin
fish_add_path /home/yuri/.lando/bin
fish_add_path /home/yuri/.lando/bin
fish_add_path /home/yuri/.lando/bin
fish_add_path /home/yuri/.local/bin
fish_add_path /home/yuri/.nvm/versions/node/v24.11.0/bin
fish_add_path /home/yuri/bin
fish_add_path /opt/nvim/
fish_add_path /opt/nvim/
fish_add_path /opt/nvim/
fish_add_path /sbin
fish_add_path /snap/bin
fish_add_path /snap/bin
fish_add_path /usr/bin
fish_add_path /usr/games
fish_add_path /usr/local/bin
fish_add_path /usr/local/games
fish_add_path /usr/local/sbin
fish_add_path /usr/sbin
