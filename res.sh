#!/bin/zsh

from=/Users/kevin/Downloads/from
to=/Users/kevin/work/memchip/assets/images

for f in $from/*@3x.png; do
  name1=$(/usr/bin/basename $f)
  name2=${name1/@3x/}
  path=$to/3.0x/$name2
  /bin/mv -f $f $path
done

for f in $from/*@2x.png; do
  name1=$(/usr/bin/basename $f)
  name2=${name1/@2x/}
  path=$to/2.0x/$name2
  /bin/mv -f $f $path
done

for f in $from/*.png; do
  name1=$(/usr/bin/basename $f)
  # name2=${name1/@3x/}
  path=$to/$name1
  /bin/mv -f $f $path
done
