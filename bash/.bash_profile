if [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi

. "$HOME/.cargo/env"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
