#!/bin/sh

VERSION_FILE=VERSION-FILE
DEFAULT_VERSION=0.0.$(date +%Y%m%d%H%M%S)
SEARCH_FOR="%%VERSION%%"

LF='
'

if test -f version
then
	VERSION=$(cat version) || VERSION="$DEFAULT_VERSION"
elif test -d ${GIT_DIR:-.git} -o -f .git &&
	VERSION=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
	case "$VERSION" in
	*$LF*) (exit 1) ;;
	v[0-9]*)
		git update-index -q --refresh
		test -z "$(git diff-index --name-only HEAD --)" ||
		VERSION="$VERSION-dirty" ;;
	esac
then
	VERSION=$(echo "$VERSION" | sed -e 's/-/./g');
else
	VERSION="$DEFAULT_VERSION"
fi

VERSION=$(expr "$VERSION" : v*'\(.*\)')

sed -i "s/${SEARCH_FOR}/${VERSION}/g" $VERSIONED_FILE

eval $BUILD_CMD

sed -i "s/${VERSION}/${SEARCH_FOR}/g" $VERSIONED_FILE
