

for p in work/chapter*.html; do
  test '!' -r $p || sed -i -e 's,<body>,<body><div>,' -e 's,</body>,</div></body>,' "$p"
done

