#!/bin/zsh

echo "Enter desired folder name. (A name beginning with a dot (.) will be more secure as any people looking in your library folder will not be able to find it without pressing ⌘ + shift + .)."
read -r FOLDER_NAME

start=`date +%s`

chmod a+x openttd.sh || exit 1
INSTALL_PATH=$(pwd)

cd

if [[ -z "$FOLDER_NAME" ]]; then
    echo "Folder name cannot be empty. Exiting."
    exit 1
fi

LIBRARY_PATH="/Users/$USER/Library/$FOLDER_NAME"
HOMEBREW_PATH="$LIBRARY_PATH/homebrew"

echo "export PATH=\"$HOMEBREW_PATH/bin:\$PATH\"" >> "/Users/$USER/.zshrc"
echo "alias openttd=\"$INSTALL_PATH/openttd.sh $FOLDER_NAME\"" >> "/Users/$USER/.zshrc"

source ~/.zshrc

mkdir -p "$LIBRARY_PATH"
cd "$LIBRARY_PATH" || exit 1

mkdir -p "$HOMEBREW_PATH"
cd "$HOMEBREW_PATH" || exit 1

curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C "$HOMEBREW_PATH" || exit 1

cd "$LIBRARY_PATH" || exit 1

rm -rf OpenTTD || exit 1

brew install cmake ninja || exit 1

git clone https://github.com/jharlan-hash/OpenTTD || exit 1
cd OpenTTD || exit 1
mkdir build || exit 1
cd build || exit 1

cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo -G "Ninja" || exit 1
ninja || exit 1

end=`date +%s`
echo "Success! OpenTTD was installed in `expr $end - $start` seconds. Run "openttd" in the terminal below to start playing."
