#!/bin/bash

echo $1

convert $1 -negate -lat 25x25+10% -negate tmp.png
tesseract tmp.png $1

