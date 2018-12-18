#!/bin/bash

dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel compat-libstdc++-296.i686 compat-libstdc++-33.i686 compat-libstdc++-33.x86_64 glibc.i686 ncurses-libs.i686

CACHEDIR="/var/cache/fedy/goland";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget "https://data.services.jetbrains.com/products/releases?code=GO&latest=true" -O - | grep -o "https://download.jetbrains.com/go/goland-[0-9a-z.]*.tar.gz" | head -n 1)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

tar -xzf "$FILE" -C "/opt/"

mv /opt/GoLand* "/opt/GoLand"
ln -sf "/opt/GoLand/bin/goland.sh" "/usr/bin/goland"

xdg-icon-resource install --novendor --size 128 "/opt/GoLand/bin/goland.png" "goland"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/goland.desktop
[Desktop Entry]
Name=GoLand
Icon=goland
Comment=A Clever IDE to Go
Exec=goland
Terminal=false
Type=Application
StartupNotify=true
Categories=IDE;Development;
Keywords=Jetbrains;Go;GoLang;IDE;
EOF
