.PHONY: help init update status push save-context resume-context fix-md fix-md-all install-hooks apply-labels

help:
	@echo "Git & Submodule Targets:"
	@echo "  init           - init submodules & show tree"
	@echo "  update         - fetch latest submodules (recursive)"
	@echo "  status         - show git and submodule status"
	@echo "  push           - push main to origin"
	@echo ""
	@echo "LTF Utility Targets:"
	@echo "  save-context   - create context snapshot (args: TIER=micro|meso|macro)"
	@echo "  resume-context - extract preamble from snapshot (args: SNAPSHOT=path)"
	@echo "  fix-md         - fix markdown linting errors (args: FILE=path)"
	@echo "  fix-md-all     - fix all markdown files in workspace"
	@echo "  install-hooks  - install git hooks"
	@echo "  apply-labels   - apply repository labels via GitHub API"

init:
	git submodule update --init --recursive
	@echo "Submodules initialized."
	@echo "Repo tree (top level):"
	@ls -la

update:
	git submodule foreach 'git fetch --all || true'
	git submodule foreach 'git pull origin main || true'
	git submodule update --recursive --remote
	@echo "Submodules updated."

status:
	git status
	@echo ""
	@git submodule status

push:
	@if [ -z "$$(git remote get-url origin 2>/dev/null)" ]; then \
	  echo "No remote 'origin' set. Add one and retry."; exit 1; \
	fi
	git push -u origin main

# LTF Context Management
save-context:
	@pwsh tools/context/Save-LTFContext.ps1 $(if $(TIER),-Tier $(TIER),)

resume-context:
	@pwsh tools/context/Resume-LTFContext.ps1 $(if $(SNAPSHOT),-SnapshotPath $(SNAPSHOT),)

# Markdown Linting
fix-md:
	@pwsh tools/scripts/Fix-MarkdownLint.ps1 $(if $(FILE),-FilePath $(FILE) -InPlace,-FilePath README.md -InPlace)

fix-md-all:
	@pwsh tools/scripts/Fix-MarkdownLint.ps1 -FilePath "**/*.md" -InPlace

# Git Hooks & Repository Management
install-hooks:
	@pwsh tools/scripts/Install-GitHooks.ps1

apply-labels:
	@pwsh tools/scripts/Apply-RepoLabels-API.ps1
