#!/bin/bash
ca65 test.asm -o test.o && ld65 test.o -C nesfile.ini -o test.nes

