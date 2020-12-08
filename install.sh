#!/bin/bash
# Bash Script for install Fsociety tools
# Must run to install tool

clear
echo "
   ___      _____           _
  / __\__   \_   \_ __  ___| |_
 / _\/ __|   / /\/ '_ \/ __| __|
/ /  \__ \/\/ /_ | | | \__ \ |_
\/   |___/\____/ |_| |_|___/\__|
";

sudo chmod +x uninstall

if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    INSTALL_DIR="$PREFIX/usr/share/doc/fsocietyIPhone"
    BIN_DIR="$PREFIX/bin"
    BASH_PATH="$PREFIX/bin/bash"
    TERMUX=true

    pkg install -y git python2
elif [ "$(uname)" = "Darwin" ]; then
    INSTALL_DIR="/usr/local/fsocietyIPhone"
    BIN_DIR="/usr/local/bin"
    BASH_PATH="/bin/bash"
    TERMUX=false
else
    INSTALL_DIR="$HOME/.fsocietyIPhone"
    BIN_DIR="/usr/local/bin"
    BASH_PATH="/bin/bash"
    TERMUX=false

    #sudo apk add git python2.7
fi

echo "[✔] Checking directories...";
if [ -d "$INSTALL_DIR" ]; then
    echo "[◉] A directory fsocietyIPhone was found! Do you want to replace it? [Y/n]:" ;
    read -r mama
    if [ "$mama" = "y" ]; then
        if [ "$TERMUX" = true ]; then
            rm -rf "$INSTALL_DIR"
            rm "$BIN_DIR/fsocietyIPhone*"
        else
            sudo rm -rf "$INSTALL_DIR"
            sudo rm "$BIN_DIR/fsocietyIPhone*"
        fi
    else
        echo "[✘] If you want to install you must remove previous installations [✘] ";
        echo "[✘] Installation failed! [✘] ";
        exit
    fi
fi
echo "[✔] Cleaning up old directories...";
if [ -d "$ETC_DIR/DarkTroi" ]; then
    echo "$DIR_FOUND_TEXT"
    if [ "$TERMUX" = true ]; then
        rm -rf "$ETC_DIR/DarkTroi"
    else
        sudo rm -rf "$ETC_DIR/DarkTroi"
    fi
fi

echo "[✔] Installing ...";
echo "";
git clone --depth=1 https://github.com/DarkTroi/fsocietyIPhone.git "$INSTALL_DIR";
echo "#!$BASH_PATH
python $INSTALL_DIR/fsociety.py" "${1+"$@"}" > "$INSTALL_DIR/fsocietyIPhone";
chmod +x "$INSTALL_DIR/fsocietyIPhone";
if [ "$TERMUX" = true ]; then
    cp "$INSTALL_DIR/fsocietyIPhone" "$BIN_DIR"
    cp "$INSTALL_DIR/fsociety.cfg" "$BIN_DIR"
else
    sudo cp "$INSTALL_DIR/fsocietyIPhone" "$BIN_DIR"
    sudo cp "$INSTALL_DIR/fsociety.cfg" "$BIN_DIR"
fi
rm "$INSTALL_DIR/fsocietyIPhone";


if [ -d "$INSTALL_DIR" ] ;
then
    echo "";
    echo "[✔] Tool installed successfully! [✔]";
    echo "";
    echo "[✔]====================================================================[✔]";
    echo "[✔]      All is done!! You can execute tool by typing fsociety !       [✔]";
    echo "[✔]====================================================================[✔]";
    echo "";
else
    echo "[✘] Installation failed! [✘] ";
    exit
fi
