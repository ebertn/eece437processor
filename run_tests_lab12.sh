#!/bin/bash

testasm -d test.coherence1.asm
testasm -d test.coherence2.asm
testasm -d dual.llsc.asm
testasm -d example.asm
testasm -d dual.mergesort.asm