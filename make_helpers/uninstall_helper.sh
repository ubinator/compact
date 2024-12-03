#!/bin/false

uninstall_target_path='/opt/bin/compact'

if [ ! -e "$uninstall_target_path" ]
then
	echo "program wasn't installed, nothing to do"
	exit
fi

source_sha_hash="$(cat compact | sha256sum)" &&

install_sha_hash="$(cat "$uninstall_target_path" | sha256sum)" || {
	echo "ERROR ERROR ERROR: something went wrong while hashing source or hashing install!!!" 1>&2
	exit 1
}

if [ "$source_sha_hash" != "$install_sha_hash" ]
then
	echo "current source hash differs from current install hash, are you sure you want to delete whatever currently resides at '$uninstall_target_path'? [y/N]"
        read -r should_uninstall
        if [ "$should_uninstall" != 'y' ] && [ "$should_uninstall" != 'Y' ]
        then
                echo 'ok, NOTHING CHANGED, exiting...'
                exit
        fi
fi

rm "$uninstall_target_path" || {
	echo "ERROR ERROR ERROR: couldn't rm target!!!!! GO FIND OUT WHY!!!!!" 1>&2
	exit 1
}

if [ -e "$uninstall_target_path" ]
then
	echo "ERROR ERROR ERROR: program still exists in install location after running rm!!!! GO FIND OUT WHY!!!!!!!" 1>&2
	exit 1
fi

echo 'successfully uninstalled, listing install directory:'
ls "$(dirname "$uninstall_target_path")"
