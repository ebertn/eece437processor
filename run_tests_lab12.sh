#!/bin/bash

trap "exit" INT # Ends whole script on ctrl+C

if [ "$1" == "-s" ]
then
  testasm -d -s test.coherence1.asm
  testasm -d -s test.coherence2.asm
  testasm -d -s dual.llsc.asm
  testasm -d -s example.asm
  testasm -d -s dual.mergesort.asm

  exit
fi

# Run tests
testasm -d test.coherence1.asm
testasm -d test.coherence2.asm
testasm -d dual.llsc.asm
testasm -d example.asm
testasm -d dual.mergesort.asm