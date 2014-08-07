#!/bin/sh

rm s{l,r}.png
convert -crop 490x685+0+35 l.png sl.png
convert -crop 640x685+0+35 r.png sr.png
convert sl.png sr.png +append demo.png
