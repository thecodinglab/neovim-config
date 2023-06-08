#!/usr/bin/env sh

OS=$(uname -s)

if [ "$OS" = "Darwin" ]; then
  THEME=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
  [ "$THEME" = "Dark" ] && echo "dark" || echo "light"
elif [ "$OS" = "Linux" ]; then
  THEME=$(gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null)
  echo "$THEME" | grep ":dark'$" >/dev/null && echo "dark" || echo "light"
else
  echo "unknown"
fi
