#!/usr/bin/python -i

import sys
import os
import shutil

if(len(sys.argv)!=2):
    print "Need one argument"
    exit(1)

pth=sys.argv[1]

if(not os.path.exists(pth)):
    print "'%s' doesn't exist"%pth
    exit(1)

root_src_dir = os.path.abspath(os.path.dirname(sys.argv[0]))
root_dst_dir = os.path.abspath(sys.argv[1])

for src_dir, dirs, files in os.walk(root_src_dir):
    dst_dir = src_dir.replace(root_src_dir, root_dst_dir)
    if not os.path.exists(dst_dir):
        os.mkdir(dst_dir)
    for file_ in files:
        src_file = os.path.join(src_dir, file_)
        dst_file = os.path.join(dst_dir, file_)
        if os.path.exists(dst_file):
            os.remove(dst_file)
        shutil.move(src_file, dst_dir)
