#!/bin/bash

# figure out the absolute path to the script being run a bit
# non-obvious, the ${0%/*} pulls the path out of $0, cd's into the
# specified directory, then uses $PWD to figure out where that
# directory lives - and all this in a subshell, so we don't affect
# $PWD

GAMEROOT=$(cd "${0%/*}" && echo $PWD)

#determine platform
UNAME=`uname`
if [ "$UNAME" == "Darwin" ]; then
	# prepend our lib path to LD_LIBRARY_PATH
	export DYLD_LIBRARY_PATH=${GAMEROOT}:$DYLD_LIBRARY_PATH
elif [ "$UNAME" == "Linux" ]; then
	# prepend our lib path to LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=${GAMEROOT}:$LD_LIBRARY_PATH:~/.steam/bin32/steam-runtime/i386/lib/i386-linux-gnu:~/.steam/bin32/steam-runtime/i386/usr/lib/i386-linux-gnu
fi

if [ -z $GAMEEXE ]; then
	if [ "$UNAME" == "Darwin" ]; then
		GAMEEXE=svencoop_osx
	elif [ "$UNAME" == "Linux" ]; then
		GAMEEXE=svencoop_linux
	fi
fi

ulimit -n 2048

# and launch the game
cd "$GAMEROOT"

export LD_PRELOAD=./libiconv.so.2

STATUS=42
while [ $STATUS -eq 42 ]; do
	${DEBUGGER} "${GAMEROOT}"/${GAMEEXE} $@
	STATUS=$?
done
exit $STATUS
