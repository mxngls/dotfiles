DOTFILE_PATH := $(HOME)/dotfiles

$(HOME)/.%: .%
	ln -sf $(DOTFILE_PATH)/$^ $@

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
	rm -r $(HOME)/.config/ghostty
	ln -sf $(DOTFILE_PATH)/.config/ghostty $(HOME)/.config/ghostty

ghostty: $(HOME)/.config/ghostty

# editor
$(HOME)/.config/nvim:
	rm -r $(HOME)/.config/nvim
	ln -sf $(DOTFILE_PATH)/.config/nvim $(HOME)/.config/nvim

nvim: $(HOME)/.config/nvim

# custom scripts
$(HOME)/.local/bin:
	mkdir -p $(HOME)/.local
	ln -sf $(DOTFILE_PATH)/.local/bin $(HOME)/.local

bin: $(HOME)/.local/bin

update:
	git -C $(DOTFILE_PATH) pull
	$(MAKE) all

brew:
	brew bundle --no-upgrade --force cleanup --file=$(DOTFILE_PATH)/Brewfile

all: git zsh bash ghostty rg fd nvim bin brew
