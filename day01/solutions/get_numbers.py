#!/usr/bin/python3

import sys
from PIL import Image
import pytesseract as pt

def read_numbers(filepath):
    text = pt.image_to_string(Image.open(filepath), lang="eng")
    with open("result.txt", "w") as result:
        result.write(text)
    return

def main(argv):
    if len(argv) == 2:
        read_numbers(argv[1])
    else:
        print("Usage: python {} <path>".format(argv[0]))
    return


if __name__ == "__main__":
    main(sys.argv)
