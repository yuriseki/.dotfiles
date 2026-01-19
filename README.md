# Yuri Seki's Dotfiles

## Managing dotfiles with `stow`

1. Create the application folder
2. Create the same structure inside the application folder as it is in `~`
3. Move the configuration files to the new folder
4. Stow the application

Ex:

```bash
mkdir -p nvim/.config
mv ~/.config/nvim nvim/.config
stow nvim
```

To remove the symlink created by stow, use the following command:
`stow -D nvim`

It will remove the symlink, and then move back the configuration files to the
original place.
