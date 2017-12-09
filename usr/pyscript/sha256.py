#!/usr/bin/env python

import hashlib
import sys

# from https://gist.github.com/rji/b38c7238128edf53a181

def sha256_checksum(filename, block_size=65536):
    """Get the sha256 checksum of a file.
    """
    sha256 = hashlib.sha256()
    with open(filename, 'rb') as f:
        for block in iter(lambda: f.read(block_size), b''):
            sha256.update(block)
    return sha256.hexdigest()

def main():
    """Pass in a filename and print it's checksum.
    """
    for f in sys.argv[1:]:
        checksum = sha256_checksum(f)
        print(f + '\t' + checksum)

if __name__ == '__main__':
    main()
