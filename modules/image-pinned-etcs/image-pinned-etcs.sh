#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

get_yaml_array ADD_FILES '.add[]' "$1"

mkdir -p /usr/share/ublue-os/image-pinned-etcs/

if [[ ${#ADD_FILES[@]} -gt 0 ]]; then
	cd "$CONFIG_DIRECTORY/image-pinned-etcs"

	echo "$CONFIG_DIRECTORY/image-pinned-etcs"
	tree . -f

	echo "Adding files to image-pinned-etcs"
	for entry in "${ADD_FILES[@]}"; do
		echo "$CONFIG_DIRECTORY/image-pinned-etcs/$entry"
		tree $CONFIG_DIRECTORY/image-pinned-etcs/$entry -f
		if [ ! -e "$CONFIG_DIRECTORY/image-pinned-etcs/$entry" ]; then
			echo "Entry $entry Does Not Exist in $CONFIG_DIRECTORY/image-pinned-etcs"
			exit 1
		fi

		echo "Copying $entry to /usr/share/ublue-os/image-pinned-etcs"
		echo "config-directory: $CONFIG_DIRECTORY"
		cp -rf $CONFIG_DIRECTORY/image-pinned-etcs/$entry/* /usr/share/ublue-os/image-pinned-etcs/
		DIRS_TO_CREATE=($(fd --type directory --base-directory $CONFIG_DIRECTORY/image-pinned-etcs/$entry | xargs))
		FILES_TO_LINK=($(fd --type file --base-directory $CONFIG_DIRECTORY/image-pinned-etcs/$entry | xargs))

		echo "files to link: $FILES_TO_LINK"

		for dir in "${DIRS_TO_CREATE[@]}"; do
			mkdir -p /usr/etc/$dir
			ls -ahl /usr/etc/$dir
		done

		for file in "${FILES_TO_LINK[@]}"; do
			ln -s /usr/share/ublue-os/image-pinned-etcs/$file /usr/etc/$file
			# TODO: for some reason there is already aurora-fastfetch.sh and its trying to make it again
			# https://github.com/noahdotpy/myublue/actions/runs/9842677770/job/27172121481#step:2:1856
		done
	done
fi
