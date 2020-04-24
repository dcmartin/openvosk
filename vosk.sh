#!/bin/bash
python3 vosk.py ${1:-samples/test.wav} \
  | jq -n 'reduce inputs as $d (.;.+[$d])'
