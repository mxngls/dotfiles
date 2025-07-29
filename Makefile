DOTFILE_PATH := $(HOME)/.dotfiles

$(HOME)/.%: .%
	ln -sf $(DOTFILE_PATH)/$^ $@

all: brew git rg fd nvim \
	shell bin \
	zsh zsh_config \
	bash bash_config \
	ghostty 

# git
git: $(HOME)/.gitconfig $(HOME)/.gitignore $(HOME)/.gitmodules

# shell(s)
zsh: $(HOME)/.zshrc $(HOME)/.zprofile $(HOME)/.zlogout
bash: $(HOME)/.bashrc $(HOME)/.bash_profile $(HOME)/.bash_logout

# misc
rg: $(HOME)/.ripgreprc
fd: $(HOME)/.fdignore

# terminal emulator
$(HOME)/.config/ghostty:
	ln -sf $(DOTFILE_PATH)/.config/ghostty $(HOME)/.config

ghostty: $(HOME)/.config/ghostty

# shared shell config
$(HOME)/.config/shell:
	ln -sf $(DOTFILE_PATH)/.config/shell $(HOME)/.config

shell: $(HOME)/.config/shell

# zsh
$(HOME)/.config/zsh:
	ln -sf $(DOTFILE_PATH)/.config/zsh $(HOME)/.config

zsh_config: $(HOME)/.config/zsh

# bash
$(HOME)/.config/bash:
	rm -r $(HOME)/.config/bash
	ln -sf $(DOTFILE_PATH)/.config/bash $(HOME)/.config

bash_config: $(HOME)/.config/bash

# editor
$(HOME)/.config/nvim:
	rm -r $(HOME)/.config/nvim
	ln -sf $(DOTFILE_PATH)/.config/nvim $(HOME)/.config

nvim: $(HOME)/.config/nvim

# custom scripts
$(HOME)/.local/bin:
	mkdir -p $(HOME)/.local/bin

bin: $(HOME)/.local/bin
	git -C $(DOTFILE_PATH)/.local/share/bin submodule update \
		--init \
		--remote \
		--recursive || true
	$(MAKE) -C $(DOTFILE_PATH)/.local/share/bin
	rm -rf $(HOME)/.local/bin
	ln -sf $(DOTFILE_PATH)/.local/bin $(HOME)/.local/bin

update:
	git -C $(DOTFILE_PATH) pull
	$(MAKE) all

brew:
	brew bundle --no-upgrade --force cleanup --file=$(DOTFILE_PATH)/Brewfile
