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
  - Initialize the server with `NODE_OPTIONS='--inspect=9229' npm run dev`
  - Press F5 to start the debug adapter with the option `NextJS: Attach to dev server`,
    and enter the correct port.

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

## Code Format

- Drupal
  - None-ls is configured to read the phpcs.xml from the project root.
    - Include a phpcs.xml file, such as: `https://github.com/Lullabot/drainpipe/blob/main/drainpipe-dev/scaffold/phpcs.xml.dist`
  - Phpactor: I'm using it as the main PHP language server.
    By default, Phpactor will not index `.inc` nor `.module` files.

    Run the following on your project to enable the indexing of `.inc` and `.module` files.

    `phpactor config:set indexer.supported_extensions '["php", "inc", "module"]'`

    `phpactor config:set indexer.include_patterns '["/**/*.php", "/**/*.inc", "/**/*.module"]'`

    Add the modules into the Composer autoloader

    ```json
    {
      "require": {
        "fenetikm/autoload-drupal": "0.1"
      },
      "extra": {
        "autoload-drupal": {
          "modules": [
            "web/modules/contrib/",
            "web/modules/custom/",
            "web/core/modules/"
          ]
        }
      }
    }
    ```

    Execute the following commands in the project root:

    ```bash
    phpactor config:trust
    phpactor config:json-schema phpactor.schema.json
    phpactor config:initialize
    phpactor config:set indexer.supported_extensions '["php", "inc", "module"]'
    phpactor config:set indexer.include_patterns '["/**/*.php", "/**/*.inc", "/**/*.module"]'
    phpactor config:set symfony.enabled true
    phpactor index:build --reset
    phpactor index:build --verbose
    ```

    Here is an example of the `.phpactor.json` file:

    ```json
    {
      "$schema": "phpactor.schema.json",
      "symfony.enabled": true,
      "indexer.supported_extensions": ["php", "inc", "module"],
      "indexer.include_patterns": [
        "/**/*.php",
        "/**/*.inc",
        "/**/*.module",
        "web/core/includes/*.inc"
      ],
      "indexer.stub_paths": ["~/.composer/vendor/jetbrains/phpstorm-stubs"],
      "language_server_phpstan.enabled": true,
      "php_code_sniffer.enabled": true,
      "prophecy.enabled": true,
      "worse_reflection.stub_dir": "~/.composer/vendor/jetbrains/phpstorm-stubs"
    }
    ```

## Performing Diff operations

### Perform a diff between the current file and another branch

`:vertical Gdiffsplit main`

- Use `do` (Diff Obtain) to obtain the diff from the other buffer into the
  current buffer.
- Use `dp` (Diff Put) to put the change from the current buffer into the other buffer.

### View the current file history

`:DiffviewFileHistory %`

Where `%` means the current file.

## Plugins to analyze

- [vimfony](https://github.com/shinyvision/vimfony) - A plugin to jump between Symfony definitions

## Reading reference

[LazyVim book by dustyphillipscodes](https://lazyvim-ambitious-devs.phillips.codes/course/chapter-1/)

## Functionalities I cannot do in Neovim and I do a lot in IntelliJ

- Autocomplete for docstring
- Partially load long values in Debug
- Partially load long values in database tables
