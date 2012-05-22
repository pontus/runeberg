#!/bin/sh

sed -e 's/<td r>/<td>/g' -e 's/<td [^>]* c>/<td>/g' -e 's,^\s*$,</p><p>,' 
