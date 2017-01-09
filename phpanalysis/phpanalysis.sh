#!/usr/bin/env sh

# Store command line args
CMD_ARGS=$@

# execute the code sniffer
if [ "$EXCLUDE" != "" ]; then
    PHPCS_IGNORE="--ignore=$EXCLUDE"
    PHPCPD_EXCLUDE="--exclude=vendor"
else
    PHPCS_IGNORE=""
    PHPCPD_EXCLUDE=""
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

echo "--- Executing PHP Copy Paste Detector ---"

echo phpcpd $PHPCPD_EXCLUDE .
phpcpd $PHPCPD_EXCLUDE --ansi .

phpcpd -h

echo "--- End of analysis ---"