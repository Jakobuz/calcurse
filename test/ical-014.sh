#!/bin/sh
# Import followed by export and comparison

. "${TEST_INIT:-./test-init.sh}"

if [ "$1" = 'actual' ]; then
  mkdir .calcurse || exit 1
  cp "$DATA_DIR/conf" .calcurse || exit 1
  "$CALCURSE" -q -D "$PWD/.calcurse" -i "$DATA_DIR/ical-014.ical"
  "$CALCURSE" -D "$PWD/.calcurse" -x | 
  sed -n '
	/DESCRIPTION/p
	/LOCATION/p
	/COMMENT/p
  ' |
  sort
  rm -rf .calcurse || exit 1
elif [ "$1" = 'expected' ]; then
  cat "$DATA_DIR/ical-014.ical" |
  sed -n '
	/DESCRIPTION/p
	/LOCATION/p
	/COMMENT/p
  ' |
  sort
else
  ./run-test "$0"
fi
