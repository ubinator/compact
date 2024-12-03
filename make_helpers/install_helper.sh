#!/bin/false

install_target_path='/opt/bin/compact'

if [ -e "$install_target_path" ]
then
	echo "'$install_target_path' already exists, overwrite? [y/N]"
	read -r should_overwrite
	if [ "$should_overwrite" != 'y' ] && [ "$should_overwrite" != 'Y' ]
	then
		echo 'ok, NOTHING CHANGED, exiting...'
		exit
	fi
fi

source_sha_hash="$(cat compact | sha256sum)" &&

cp compact "$install_target_path" &&

install_sha_hash="$(cat "$install_target_path" | sha256sum)" || {
	echo "ERROR ERROR ERROR: something went wrong while hashing source or copying or hashing install!!!" 1>&2
	exit 1
}

echo
echo "source hash: $source_sha_hash"
echo "install hash: $install_sha_hash"
echo

if [ "$install_sha_hash" != "$source_sha_hash" ]
then
	echo "ERROR ERROR ERROR: source hash and install hash don't match!!! GO FIND OUT WHY!!!" 1>&2
	exit 1
fi

echo 'succesfully installed, listing install directory:'
ls "$(dirname "$install_target_path")"
