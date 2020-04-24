#!/bin/bash
a=$(mktemp)
b=$(mktemp)
c=$(mktemp)
d=$(mktemp)
e=$(mktemp)
/usr/bin/time -p python3 vosk.py ${1:-samples/test.wav} 1> ${a} 2> ${b}
cat ${a} | jq -n 'reduce inputs as $d (.;.+[$d])' 1> ${c} 2> /dev/stderr
cat ${b} \
  | awk 'BEGIN { print("{\"time\":{"); x=0; } { if (x++>0) { print(",")}; printf("\"%s\": \"%s\"", $1, $2) } END { print("}}") }' \
  > ${d}
cat ${c} | jq '{"results":.}' > ${e}
jq -c -s add ${d} ${e}
rm -f ${a} ${b} ${c} ${d} ${e}
