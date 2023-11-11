#!/bin/sh

tmp=$(mktemp)
out=$(mktemp)
printf '#include <unistd.h>\nint main (void) { return pledge(); }\n' >$tmp

${CC:-cc} $tmp -o $out >/dev/null 2>&1
r=$?
rm $out $tmp >/dev/null 2>&1 ||:

[ $r -eq 0 ] && printf -- '-DHAVE_PLEDGE'
exit 0
