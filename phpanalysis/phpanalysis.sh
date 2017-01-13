#!/usr/bin/env sh

# Store command line args
CMD_ARGS=$@

# Retrieve local user UID and group GID
set -- `ls -nd .` && LOCAL_UID=$3 && LOCAL_GID=$4

PROJECT_DIR=$(pwd)
REPORT_DIR=$PROJECT_DIR/reports
SUDO_CMD="sudo -g #$LOCAL_GID -u #$LOCAL_UID -E"


if [ ! -d $REPORT_DIR ]; then
    $SUDO_CMD mkdir $REPORT_DIR
fi


# execute the code sniffer
if [ "$EXCLUDE" != "" ]; then
    PHPCS_IGNORE="--ignore=$EXCLUDE"
    PHPLOC_EXCLUDE="--exclude=vendor --exclude=tests"
    PHPMD_EXCLUDE="--exclude=$EXCLUDE"
else
    PHPCS_IGNORE=""
    PHPLOC_EXCLUDE=""
    PHPMD_EXCLUDE=""
fi

if [ "$PHPCS_SNIFFS" != "" ]; then
    SNIFFS="--sniffs=$PHPCS_SNIFFS"
else
    SNIFFS=""
fi

if [ "$PHPCS_ENCODING" != "" ]; then
    ENCODING="--encoding=$PHPCS_ENCODING"
else
    ENCODING=""
fi

if [ "$PHPCS_IGNORE_WARNINGS" == "1" ]; then
    IGNORE_WARNINGS="-n"
else
    IGNORE_WARNINGS=""
fi

echo "--- Executing PHP CodeSniffer ---"

phpcs -s $IGNORE_WARNINGS --standard=$PHPCS_CODING_STANDARD -p --colors $ENCODING $PHPCS_IGNORE $SNIFFS .

echo "--- Executing PHP Loc ---"

phploc $PHPLOC_EXCLUDE --ansi .

echo "--- Executing PHP Mess Detector ---"

$SUDO_CMD phpmd $PROJECT_DIR xml codesize --reportfile $REPORT_DIR/phpmd.xml $PHPMD_EXCLUDE

echo "--- End of analysis ---"