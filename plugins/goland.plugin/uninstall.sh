#!/bin/bash

xdg-icon-resource uninstall --novendor --size 128 "goland"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/goland"
rm -f "/usr/share/applications/goland.desktop"
rm -rf "/opt/GoLand"
