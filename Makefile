# Fresh-machine setup order:
#   1. git clone <this-repo>
#   2. cd <repo> && make install   (lays symlinks; targets need not exist yet)
#   3. brew install neovim zellij ghostty stylua taplo prettier lazygit
#   4. launch the apps — they read through the symlinks
# Doing `make install` before installing the apps avoids Ghostty's
# first-launch auto-config from racing against the symlink.

SHELL := /bin/bash
REPO  := $(shell pwd)
UNAME := $(shell uname)

NVIM_DIR   := $(HOME)/.config/nvim
ZELLIJ_DIR := $(HOME)/.config/zellij

ifeq ($(UNAME),Darwin)
GHOSTTY_DIR := $(HOME)/Library/Application Support/com.mitchellh.ghostty
else
GHOSTTY_DIR := $(HOME)/.config/ghostty
endif

.DEFAULT_GOAL := help
.PHONY: help install uninstall status nvim zellij ghostty

help:
	@echo "Targets:"
	@echo "  install     symlink all configs into place"
	@echo "  uninstall   remove symlinks created from this repo (leaves foreign links alone)"
	@echo "  status      show current link state for each managed path"
	@echo "  nvim        install nvim config only"
	@echo "  zellij      install zellij config only"
	@echo "  ghostty     install ghostty config only"

install: nvim zellij ghostty
	@echo "Done."

nvim:
	@$(call link,$(REPO)/nvim,$(NVIM_DIR))

zellij:
	@mkdir -p "$(ZELLIJ_DIR)"
	@$(call link,$(REPO)/zellij/config.kdl,$(ZELLIJ_DIR)/config.kdl)

ghostty:
	@mkdir -p "$(GHOSTTY_DIR)"
	@$(call link,$(REPO)/ghostty/config,$(GHOSTTY_DIR)/config)

# link <src> <dst>
# - if dst already points at src, do nothing
# - if dst is some other symlink, replace it
# - if dst is a real file or directory, refuse and tell the user
define link
	src="$(1)"; dst="$(2)"; \
	mkdir -p "$$(dirname "$$dst")"; \
	if [ -L "$$dst" ]; then \
	  current=$$(readlink "$$dst"); \
	  if [ "$$current" = "$$src" ]; then \
	    echo "[ok]    $$dst"; \
	  else \
	    ln -sfn "$$src" "$$dst" && \
	    echo "[relink] $$dst (was $$current)"; \
	  fi; \
	elif [ -e "$$dst" ]; then \
	  echo "[error] $$dst exists and is not a symlink."; \
	  echo "        Move it aside (e.g. mv \"$$dst\" \"$$dst.bak\") and re-run."; \
	  exit 1; \
	else \
	  ln -sfn "$$src" "$$dst" && \
	  echo "[link]  $$dst"; \
	fi
endef

uninstall:
	@for path in "$(NVIM_DIR)" "$(ZELLIJ_DIR)/config.kdl" "$(GHOSTTY_DIR)/config"; do \
	  if [ -L "$$path" ]; then \
	    target=$$(readlink "$$path"); \
	    case "$$target" in \
	      "$(REPO)"/*) rm -- "$$path"; echo "[rm]    $$path";; \
	      *)           echo "[keep]  $$path -> $$target (not from this repo)";; \
	    esac; \
	  elif [ -e "$$path" ]; then \
	    echo "[skip]  $$path is not a symlink"; \
	  else \
	    echo "[none]  $$path"; \
	  fi; \
	done

status:
	@for path in "$(NVIM_DIR)" "$(ZELLIJ_DIR)/config.kdl" "$(GHOSTTY_DIR)/config"; do \
	  if [ -L "$$path" ]; then \
	    target=$$(readlink "$$path"); \
	    case "$$target" in \
	      "$(REPO)"/*) echo "[ours]  $$path -> $$target";; \
	      *)           echo "[other] $$path -> $$target";; \
	    esac; \
	  elif [ -e "$$path" ]; then \
	    echo "[file]  $$path (real file/dir, not a symlink)"; \
	  else \
	    echo "[none]  $$path"; \
	  fi; \
	done
