

for p in work/chapter*.html; do
  test '!' -r $p || sed -i -e 's,<body>,<body><div>,' -e 's,</body>,</div></body>,'  -e 's,\(<span style="clear: both" >\&nbsp;</span>\),\1<br />,ig'  "$p"
done

