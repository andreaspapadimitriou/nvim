INSTALL_DIR := $(HOME)/.local/bin
LSP_DATA_DIR := $(HOME)/.local/share/nvim-lsp

help:
	@echo "Available targets:"
	@echo "  make check          - Check if package managers are installed"
	@echo "  make install        - Install all LSPs and debug adapters"
	@echo "  make install-<lsp>  - Install specific LSP"
	@echo ""
	@echo "LSPs:"
	@echo "  - lua-ls (lua_ls)"
	@echo "  - clangd"
	@echo "  - typos-lsp"
	@echo "  - basedpyright"
	@echo "  - jsonls"
	@echo "  - marksman"
	@echo "  - azure-pipelines-ls"
	@echo "  - cmake-ls"
	@echo "  - bashls"
	@echo ""
	@echo "Debug Adapters:"
	@echo "  - debugpy (Python debugging)"
	@echo ""
	@echo "Programs:"
	@echo "  - yazi      (Terminal file manager)"
	@echo "  - fzf       (fuzzy finder)"
	@echo "  - rg        (fuzzy finder)"
	@echo "  - ts-cli    (tree-sitter helper)"
	@echo "  - fd        (file finder)"
	@echo "  - git-delta (git differ)"
	@echo "  - ast-grep  (ast finder)"
	@echo "  - lazygit   (Git TUI)"

check:
	@echo "Checking package managers..."
	@command -v pipx >/dev/null 2>&1 || (echo "❌ pipx not found" && exit 1)
	@command -v npm >/dev/null 2>&1 || (echo "❌ npm not found" && exit 1)
	@command -v cargo >/dev/null 2>&1 || (echo "❌ cargo not found" && exit 1)
	@command -v wget >/dev/null 2>&1 || (echo "❌ wget not found" && exit 1)
	@command -v unzip >/dev/null 2>&1 || (echo "❌ unzip not found" && exit 1)
	@echo "✓ All package managers found"

install: check
	@echo ""
	@echo "🔧 This will install:"
	@echo "   LSPs:      lua-ls, clangd, typos-lsp, basedpyright, jsonls, marksman, azure-pipelines-ls, cmake-ls, bashls"
	@echo "   Adapters:  debugpy"
	@echo "   Programs:  yazi"
	@echo ""
	@printf "Continue? [y/N] "; \
	read -r REPLY; \
	if [ "$$REPLY" = "y" ] || [ "$$REPLY" = "Y" ]; then \
		$(MAKE) install-lua-ls install-clangd install-typos-lsp install-basedpyright install-jsonls install-marksman install-azure-pipelines-ls install-cmake-ls install-debugpy install-yazi install-bashls; \
		echo "✓ All LSPs, debug adapters and programs installed"; \
	else \
		echo "Installation cancelled."; \
		exit 1; \
	fi

# Lua Language Server (GitHub release)
install-lua-ls:
	@echo "Installing lua-language-server..."
	@mkdir -p $(LSP_DATA_DIR)/lua-ls
	@cd $(LSP_DATA_DIR)/lua-ls && \
		wget -q --show-progress https://github.com/LuaLS/lua-language-server/releases/download/3.15.0/lua-language-server-3.15.0-linux-x64.tar.gz -O lua-ls.tar.gz && \
		tar -xzf lua-ls.tar.gz && \
		rm lua-ls.tar.gz
	@mkdir -p $(INSTALL_DIR)
	@ln -sf $(LSP_DATA_DIR)/lua-ls/bin/lua-language-server $(INSTALL_DIR)/lua-language-server
	@echo "✓ lua-language-server installed"

# Clangd (GitHub release)
install-clangd:
	@echo "Installing clangd..."
	@mkdir -p $(LSP_DATA_DIR)/clangd
	@cd $(LSP_DATA_DIR)/clangd && \
		wget -q --show-progress https://github.com/clangd/clangd/releases/download/21.1.0/clangd-linux-21.1.0.zip -O clangd.zip && \
		unzip -q -o clangd.zip && \
		rm clangd.zip
	@mkdir -p $(INSTALL_DIR)
	@ln -sf $(LSP_DATA_DIR)/clangd/clangd_*/bin/clangd $(INSTALL_DIR)/clangd
	@echo "✓ clangd installed"

# Typos LSP (cargo)
install-typos-lsp:
	@echo "Installing typos-lsp..."
	@cargo install --git https://github.com/tekumara/typos-lsp typos-lsp
	@echo "✓ typos-lsp installed"

# BasedPyright (pipx)
install-basedpyright:
	@echo "Installing basedpyright..."
	@pipx install basedpyright
	@echo "✓ basedpyright installed"

# JSON Language Server (npm)
install-jsonls:
	@echo "Installing vscode-langservers-extracted..."
	@npm install -g vscode-langservers-extracted
	@echo "✓ vscode-langservers-extracted installed"

# Marksman (GitHub release)
install-marksman:
	@echo "Installing marksman..."
	@mkdir -p $(LSP_DATA_DIR)/marksman
	@cd $(LSP_DATA_DIR)/marksman && \
		wget -q --show-progress https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64 -O marksman && \
		chmod +x marksman
	@mkdir -p $(INSTALL_DIR)
	@ln -sf $(LSP_DATA_DIR)/marksman/marksman $(INSTALL_DIR)/marksman
	@echo "✓ marksman installed"

# CMake Language Server (pipx)
install-cmake-ls:
	@echo "Installing cmake-language-server..."
	@pipx install cmake-language-server
	@echo "✓ cmake-language-server installed"

# Bash Language Server (npm)
install-bashls:
	@echo "Installing bash-language-server..."
	@npm install -g bash-language-server
	@echo "✓ bash-language-server installed"

# Debug Adapters

# Debugpy (pipx)
install-debugpy:
	@echo "Installing debugpy..."
	@pipx install debugpy
	@echo "✓ debugpy installed"

# Programs

# yazi (cargo)
install-yazi:
	@echo "Installing yazi..."
	@cargo install --force yazi-build
	@echo "✓ yazi installed"

# fzf (GitHub release)
install-fzf:
	@echo "Installing fzf..."
	@mkdir -p $(LSP_DATA_DIR)/fzf
	@cd $(LSP_DATA_DIR)/fzf && \
		wget -q --show-progress https://github.com/junegunn/fzf/releases/download/v0.67.0/fzf-0.67.0-linux_amd64.tar.gz -O fzf.tar.gz && \
		tar -xzf fzf.tar.gz && \
		rm fzf.tar.gz
	@mkdir -p $(INSTALL_DIR)
	@ln -sf $(LSP_DATA_DIR)/fzf/fzf $(INSTALL_DIR)/fzf
	@echo "✓ fzf installed"

# Ripgrep (cargo)
install-rg:
	@echo "Installing rg..."
	@cargo install ripgrep
	@echo "✓ rg installed"

# Tree-sitter-cli (cargo)
install-tree-sitter-cli:
	@echo "Installing tree-sitter-cli..."
	@cargo install tree-sitter-cli
	@echo "✓ tree-sitter-cli installed"

# fd (cargo)
install-fd:
	@echo "Installing fd..."
	@cargo install fd-find
	@echo "✓ fd installed"

# Git-delta (cargo)
install-git-delta:
	@echo "Installing git-delta..."
	@cargo install git-delta
	@echo "✓ git-delta installed"

# AstGrep (npm)
install-ast-grep:
	@echo "Installing ast-grep/cli..."
	@npm install -g @ast-grep/cli
	@echo "✓ ast-grep/cli installed"

# Lazygit (GitHub release)
install-lazygit:
	@echo "Installing lazygit..."
	@mkdir -p $(LSP_DATA_DIR)/lazygit
	@cd $(LSP_DATA_DIR)/lazygit && \
		wget -q --show-progress https://github.com/jesseduffield/lazygit/releases/download/v0.56.0/lazygit_0.56.0_linux_x86_64.tar.gz -O lazygit.tar.gz && \
		tar -xzf lazygit.tar.gz && \
		rm lazygit.tar.gz
	@mkdir -p $(INSTALL_DIR)
	@ln -sf $(LSP_DATA_DIR)/lazygit/lazygit $(INSTALL_DIR)/lazygit
	@echo "✓ lazygit installed"

# mmdc (npm)
install-mmdc:
	@echo "Installing mmdc..."
	@npm install -g @mermaid-js/mermaid-cli
	@echo "✓ mmdc installed"
