# kickstart.nvim

Fork of kickstart.nvim, for Ubuntu, simplified and with vim-plug instead of Lazy.

## Installation

### Install Neovim

[stable](https://github.com/neovim/neovim/releases/tag/stable)

### Install External Dependencies

Requirements:
- Install additional tools not included in Ubuntu: sudo apt-get install ripgrep fd-find
- Check that the following list of tools are installed: git make unzip gcc xclip
- A [Nerd Font](https://www.nerdfonts.com/), provides various icons
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

### Install Kickstart

> [!NOTE]
> [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located:

`~/.config/nvim`

#### Recommended

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) the original repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine.

> [!NOTE]
> Your fork's URL:
> `https://github.com/<your_github_username>/kickstart.nvim`

You should remove `lazy-lock.json` from your fork's `.gitignore` file
too [recommended to track it in version control](https://lazy.folke.io/usage/lockfile).

#### Clone kickstart.nvim

<details><summary> Linux </summary>

```sh
git clone https://github.com/<your_github_username>/kickstart.nvim "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

### Post Installation

Start Neovim

### Questions

* What should I do if I already have an existing configuration?
  * Back it up and delete all associated files.
  * This includes your init.lua and the Neovim files in `~/.local`
    delete with `rm -rf ~/.local/share/nvim/`
* Can I keep my existing configuration in parallel to kickstart?
  * Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using `nvim-kickstart` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-kickstart`.
* What if I want to "uninstall" this configuration:
  * See [lazy.nvim uninstall](https://lazy.folke.io/usage#-uninstalling) information
