.PHONY: help init update status push

help:
	@echo "Targets:"
	@echo "  init     - init submodules & show tree"
	@echo "  update   - fetch latest submodules (recursive)"
	@echo "  status   - show git and submodule status"
	@echo "  push     - push main to origin"

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
