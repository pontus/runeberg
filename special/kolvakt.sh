

for p in work/chapter*.html; do
  test '!' -r $p || sed -i -e 's,<body>,<body><div>,' -e 's,</body>,</div></body>,'  -e 's,\(<span style="clear: both" >\&nbsp;</span>\),\1<br />,ig'  "$p"
done

cat - > work/chapter2.html <<EOF
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta name="generator" content="HTML Tidy for Linux (vers 25 March 2009), see www.w3.org" />
<title></title>
</head>
<body><div>
<h2>av <a href="http://www.runeberg.org/authors/danander.html">Dan Andersson</a></h2>
<p>Diktsamlingen utgavs 1915.</p>
<hr />
<p><a href="chapter3.html">Visa vid kolvakten</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter4.html">Kolvaktaren</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter5.html">Gengångare</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter6.html">Pajso</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter7.html">Benkvarnen</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter8.html">I timmerkojan på Sami</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter9.html">Den gamle</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter10.html">Döden</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter11.html">En svanesång</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter12.html">Du liv...</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter13.html">Gunnar Vägman</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter14.html">Jag väntar...</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter15.html">Till kvinnan</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter16.html">Min väg...</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter17.html">Till Astrid Dolores vid skilsmässan</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter18.html">Botgöraren</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter19.html">Sizzi</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter20.html">Onda tankar</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter21.html">Gässen flytta</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter22.html">Visa, tillägnad all ömklighet</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter23.html">Sista natten i Paindalen</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter24.html">Vårkänning</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter25.html">Jöns Lekares kvinnor</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter26.html">Tal till Jonathan</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter27.html">Helgdagskväll i timmerkojan</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter28.html">När Gasken dog</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter29.html">Tjuvskytten</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter30.html">Hemlängtan</a><span style="clear: both" >&nbsp;</span><br />
<a href="chapter31.html">Den sista sången</a></p>
</div></body>
</html>
EOF
