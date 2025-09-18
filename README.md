# configure-nvim

Fork of kickstart.nvim, for Ubuntu.

## Installation

### Install Neovim

[stable](https://github.com/neovim/neovim/releases/tag/stable)

### Install External Dependencies

Requirements:
- Install additional tools not included in Ubuntu: ```sudo apt-get install ripgrep fd-find```
- Ensure following tools are installed: ```sudo apt-get install git make unzip gcc xclip```
- A [Nerd Font](https://www.nerdfonts.com/).
- Language Setup, e.g.
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`

### Install configure-nvim

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) the repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine.

#### Clone the repository to configure nvim

```sh
git clone https://github.com/markp175/configure-nvim "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

### Recommended

* An existing configuration should be backed up before beginning.
  * Delete all associated files. This includes init.lua and the Neovim files in `~/.local`
    delete with `rm -rf ~/.local/share/nvim/`
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
