
PATH_VSCODE_SETTING="$HOME/Library/Application Support/Code/User/settings.json"
if [[ -f $PATH_VSCODE_SETTING ]]
then
  #ln -s $HOME/.vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
  echo \"$PATH_VSCODE_SETTING\" already exists
  echo backing it up to \"$HOME/.gdotbackup\"
  mv "$PATH_VSCODE_SETTING" "$HOME/.gdotbackup"
  ln -snf "$HOME/.vscode/settings.json" "$PATH_VSCODE_SETTING"
fi

