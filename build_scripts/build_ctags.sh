

echo "Going to download and build universal ctags"

CTAGS_REPO="https://github.com/universal-ctags/ctags.git"
TEMP_DIR="$(mktemp -d)"

read -p "Press Enter to continue"

sudo apt-get purge exuberant-ctags
sudo apt-get install checkinstall

echo "Now going to download ctags"

read -p "Press Enter to continue"

if [[ ! "$TEMP_DIR" || ! -d "$TEMP_DIR" ]]; then
	echo "Could not create temp dir"
	exit 1
fi

cd ${TEMP_DIR}
git clone ${CTAGS_REPO} .

echo "Now going to install ctags"
read -p "Press Enter to continue"

./autogen.sh
./configure
make -j4
sudo checkinstall make install

