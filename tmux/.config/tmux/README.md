# Yuri's Tmux configuration

This is my custom Tmux configuration that includes the statusbar configuration,
custom keybindings which functions I use the most.

## Plugins

- tmux-plugins/tpm
- tmux-plugins/tmux-sensible
- tmux-plugins/tmux-resurrect
- tmux-plugins/tmux-continuum
- tmux-plugins/tmux-yank

## Custom keybindings

- Leader key: `\`
- **C-i** opens nvim with a scratch document.
- **C-p** opens a pop-up session with windows tagged to the main session.
  - Use **leader d** to detach the pop-up window.

## Usage

### 1. Export a session to Tmuxnator

See documentation at [tmuxinator](https://github.com/tmuxinator/tmuxinator)

```bash
sudo apt install tmuxinator
```

In order to export a session that can later be opened with Tmuxnator, we need to
use `tmuxp` python program.

```bash
pip install tmuxp
```

Export the current session:

```bash
tmuxp freeze
```

This will produce something like

```yaml
session_name: mysession
windows:
- window_name: editor
  layout: main-vertical
  panes:
  - shell_command:
    - cd ~/Projects/drupal
    - nvim .
  - shell_command:
    - cd ~/Projects/drupal
    - ddev logs -f
- window_name: db
  panes:
  - shell_command:
    - cd ~/Projects/drupal
    - psql -U user dbname
```

Update the generated YAML file to what Tmuxnator expects.

```yaml
name: mysession
root: ~/Projects/drupal

windows:
  - editor:
      layout: main-vertical
      panes:
        - nvim .
        - ddev logs -f

  - db:
      panes:
        - psql -U user dbname
```


