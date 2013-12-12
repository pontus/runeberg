#!/bin/sh

sed -e 's/align="center"/style="text-align: center"/g' \
    -e 's/align=center/style="text-align: center"/g'  \
    -e 's,a href="/,a href="http://www.runeberg.org/,ig' \
    -e "s,a href='/,a href='http://www.runeberg.org/,ig" \
    -e 's,<sp>,<em>,ig' \
    -e 's,</sp>,</em>,ig'  \
    -e 's,<font[^>]*>\([^<]*\)</font>,<span style="text-size: 200%">\1</span>,ig' \
    -e 's,<br />,<span style="clear: both" >\&nbsp;</span>,ig' \
    -e 's,<blockquote>,<blockquote><div>,ig' \
    -e 's,</blockquote>,</div></blockquote>,ig' \
    -e 's, align="*right"*, style="float: right",ig' \
    -e 's, hspace="*\([0-9]*\)"*, style="margin-right: \1",ig' \
    -e 's,<blockquote>,<blockquote><div>,ig' \
    -e 's,</blockquote>,</div></blockquote>,ig' \
    -e 's,\(<img [^>]*/>\),<div>\1</div>,ig' \
    -e '/alt=/ ! s,<img ,<img alt="" ,ig' \
    -e 's,\(<img[^>]*src="\)/,\1,ig' \
    -e 's,<comment>,<!-- ,ig' \
    -e 's,</comment>, -->,ig' \
    -e 's,<center>,<div style="text-align: center">,ig' \
    -e 's,</center>,</div>,ig' \
    -e 's,^<p<,<p>,ig'


