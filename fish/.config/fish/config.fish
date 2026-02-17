if status is-interactive
    # Commands to run in interactive sessions can go here
    source ~/.config/fish/secrets.fish

    set -U fish_greeting "" # This line removes the default Fish greeting
    # echo "May the Force be with you."
    verse

    abbr -a -- ldrush 'lando drush'
    abbr -a -- ddrush 'ddev drush'
    abbr -a -- joystick 'sudo xboxdrv --detach-kernel-driver'
    abbr -a -- hibernate 'systemctl hibernate'
    abbr -a -- gs 'git status'
    abbr -a -- ff grep\ --include=\\settings.\{.php,local.php\}\ -rnw\ \'.\'\ -e\ \"WordToFind\"
    abbr -a -- mynotes 'nvim ~/Dropbox/Yuri-Notes/'
    abbr -a -- drupalcs 'phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md'
    abbr -a -- drupalcbf 'phpcbf --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md'
    abbr -a -- drupalcsp 'phpcs --standard=DrupalPractice --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md'
    abbr -a -- h 'history --show-time="%h/%d - %H:%M:%S "'
    abbr -a -- terminusk 'terminus auth:login --machine-token=$K_PANTHEON_TOKEN'
    abbr -a -- terminusy 'terminus auth:login --machine-token=$Y_PANTHEON_TOKEN'
    abbr -a -- upgrade 'sudo apt update && sudo apt upgrade && sudo apt autoremove'
    abbr -a -- f grep\ -rnw\ \'.\'\ -e\ \"WordToFind\"
    abbr -a -- xon 'lando xdebug-on'
    abbr -a -- xoff 'lando xdebug-off'
    abbr -a -- cr 'lando drush cr'
    abbr -a -- lg lazygit
    abbr -a -- y yazi
    abbr -a -- dpy "python -m debugpy --listen 5678 -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload"
    abbr -a -- dnode "NODE_OPTIONS='--inspect=9228' npm run dev"
    abbr -a -- k kubectl

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
    function fd
        fdfind
    end
    function bat
        batcat
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
    fish_add_path /usr/local/go/bin
    fish_add_path /home/yuri/go/bin

    # Set default node version.
    bass source ~/.nvm/nvm.sh
    nvm use default >/dev/null 2>&1
end
