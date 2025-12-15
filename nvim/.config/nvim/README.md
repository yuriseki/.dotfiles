# Yuri's Neovim configuration - Bases on 💤 LazyVim

Started with [LazyVim](https://github.com/LazyVim/LazyVim) template.
Refer to the [documentation](https://lazyvim.github.io/installation).

## TODO

- [ ] Configure Shift + Tab to go to the left.
- [x] Configure autocompletion with Tab
- [x] Configure Enter to select autocompletion, together with Tab
- [ ] Add the ability grep search in a single directory.
- [ ] Enable spell checking suggestion.
- [x] Add an option to format code only in selected content / git updated content.

## Debug working for

- Python
  - `source .venv/bin/activate.fish`
  - FastAPI
    - Start uvicorn with debugpy listener
      - `python -m debugpy --listen 5678 --wait-for-client -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload`
    - In nvim, use the command `VenvSelect` to select the virtual environment.
    - Attach the session.

- NextJS
  - TODO: Configure NextJS

- PHP in Drupal with Lando
  - Press F4 to define a breaking point
  - Press F5 to attach the debug into the server.

- Lua Plugins for Neovim
  - Open the Neovim (A) to debug the code
  - Open another Neovim instance (B)
  - In (B), execute the command :`lua require"osv".launch({port=8086})`
  - In (A), press F4 to set a break point in the code you want to debug
  - In (A), pres F5 to attach the debug, and select `Attach to running Neovim instance`
  - In (B), execute the action that will trigger the code with the break point

## Performing Diff operations

### Perform a diff between the current file and another branch

`:vertical Gdiffsplit main`

- Use `do` (Diff Obtain) to obtain the diff from the other buffer into the
  current buffer.
- Use `dp` (Diff Put) to put the change from the current buffer into the other buffer.

### View the current file history

`:DiffviewFileHistory %`

Where `%` means the current file.

## Reading reference

[LazyVim book by dustyphillipscodes](https://lazyvim-ambitious-devs.phillips.codes/course/chapter-1/)

## Functionalities I cannot do in Neovim and I do a lot in IntelliJ

- Autocomplete for docstring
- Partially load long values in Debug
- Partially load long values in database tables
