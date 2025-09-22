# configure-nvim

Fork of kickstart.nvim, for Ubuntu.

## Installation

### Install Neovim

[stable](https://github.com/neovim/neovim/releases/tag/stable)

### Install Dependencies

Requirements:
- Install additional tools not included in Ubuntu: ```sudo apt-get install ripgrep fd-find```
- Ensure following tools are installed: ```sudo apt-get install git make unzip gcc xclip```
- A [Nerd Font](https://www.nerdfonts.com/).
- Language Setup for LSPs, e.g.
  - For Typescript and LaTeX, `npm` is required, ```sudo apt install npm```
  - For tree-sitter and LaTeX `tree-sitter-cli` is required, ```sudo npm install -g tree-sitter-cli```
  - For Golang, `go` is required, ```sudo apt-get install golang-go git```
  - For TeXpresso, [TeXpresso](https://github.com/let-def/texpresso)

### Install configure-nvim

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine.

```sh
git clone https://github.com/markp175/configure-nvim "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

### Recommended

* An existing configuration should be backed up before starting.
* Delete all associated files with `rm -rf ~/.local/share/nvim/` and `rm -rf ~/.config/nvim/`
* Retaining the existing configuration in parallel, as follows
  * Use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using the `nvim-kickstart` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-kickstart`.
