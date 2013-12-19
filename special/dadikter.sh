

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
<hr />
<h2>Förord till den elektroniska utgåvan</h2>
<p>Projekt Runebergs elektroniska utgåva utgår från en billig pocketutgåva av Dan Anderssons samlade dikter, vilket är dokumenterat i <a href="http://www.runeberg.org/authors/danander.html">presentationen av författaren</a>. Förhoppningsvis är texten korrekt, men eventuella felaktigheter kan bero dels på misstag i digitaliseringen, dels på fel som finns i den tryckta förlagan. Denna osäkerhet är resultatet av att Dan Anderssons dikter var bland det första som Projekt Runeberg lade ut på nätet i mitten av 1990-talet. Senare har mer tillförlitliga arbetsmetoder införts, men den här äldre versionen ligger kvar.</p>
<p>Projekt Runebergs avsikt är för närvarande att så noga som möjligt återge innehållet i den tryckta pocketutgåvan (inklusive fel) samt att dokumentera alla kända avvikelser från andra tryckta förlagor. Någon gång i framtiden kanske vi får tid att göra en helt ny digitalisering utifrån någon lämpligare förlaga.</p>
<p>I boken <i>Nattvandraren</i> lär det finnas en kommentar av Gösta Ågren angående ordet "barockfoten" i dikten <a href="chapter37.html">Till dem som tänkte tanken om borgargardet</a>, som bör vara "bockfoten". Detta "fel" finns i en eller flera tryckta upplagor.</p>
</div>
<hr/>
<div>
<p>

<br/><a href="chapter3.html"
 >Hos den äldste förläggaren</a>
<br/><a href="chapter4.html"
 >Om aftonen</a>
<br/><a href="chapter5.html"
 >Stjärna</a>
<br/><a href="chapter6.html"
 >Kung Brännvin</a>
<br/><a href="chapter7.html"
 >Jan från Tuna</a>
<br/><a href="chapter8.html"
 >Per Ols Per Erik</a>
<br/><a href="chapter9.html"
 >Per Ols Per Erik: II</a>
<br/><a href="chapter10.html"
 >En svart ballad</a>
<br/><a href="chapter11.html"
 >Den röda rosen</a>
<br/><a href="chapter12.html"
 >Krigssång</a>
<br/><a href="chapter13.html"
 >Torpedsången</a>
<br/><a href="chapter14.html"
 >Som liten...</a>
<br/><a href="chapter15.html"
 >Milrök I</a>
<br/><a href="chapter16.html"
 >Milrök II</a>
<br/><a href="chapter17.html"
 >Buddha</a>
<br/><a href="chapter18.html"
 >Åska</a>
<br/><a href="chapter19.html"
 >Hades</a>
<br/><a href="chapter20.html"
 >Å, broder nu...</a>
<br/><a href="chapter21.html"
 >Pessimism</a>
<br/><a href="chapter22.html"
 >Frestaren</a>
<br/><a href="chapter23.html"
 >Nyår</a>
<br/><a href="chapter24.html"
 >Den dömde</a>
<br/><a href="chapter25.html"
 >Margit</a>
<br/><a href="chapter26.html"
 >En visa i ensamhet</a>
<br/><a href="chapter27.html"
 >Jag har mött min huldra...</a>
<br/><a href="chapter28.html"
 >Strid och vår</a>
<br/><a href="chapter29.html"
 >Krig</a>
<br/><a href="chapter30.html"
 >Postvagnen</a>
<br/><a href="chapter31.html"
 >Natt</a>
<br/><a href="chapter32.html"
 >Spelmans mor</a>
<br/><a href="chapter33.html"
 >En gammal kolare</a>
<br/><a href="chapter34.html"
 >Branden</a>
<br/><a href="chapter35.html"
 >En ungdomlig visa</a>
<br/><a href="chapter36.html"
 >Handling</a>
<br/><a href="chapter37.html"
 >Till dem som tänkte tanken om borgargardet</a>
<br/><a href="chapter38.html"
 >Visa om förr och nu</a>
<br/><a href="chapter39.html"
 >En dåres syn</a>
<br/><a href="chapter40.html"
 >Nyår</a>
<br/><a href="chapter41.html"
 >Maskinrummets män</a>
<br/><a href="chapter42.html"
 >Briggen San Antonius</a>
<br/><a href="chapter43.html"
 >Dryckesvisa med kristidsrefräng</a>
<br/><a href="chapter44.html"
 >En skön sång om potatis</a>
<br/><a href="chapter45.html"
 >Andens skara</a>
<br/><a href="chapter46.html"
 >Kväde (till hela Sveriges hjälte nr 2)</a>
<br/><a href="chapter47.html"
 >Kålrotens förmaningstal</a>
<br/><a href="chapter48.html"
 >Kväde (till livsmedelsnämnden)</a>
<br/><a href="chapter49.html"
 >Kväde (tillägnat all den bränslekommissionens ved)</a>
<br/><a href="chapter50.html"
 >Kväde (till högtärade herr läroverksadjunkten)</a>
<br/><a href="chapter51.html"
 >Kväde (till redaktören och poeten)</a>
<br/><a href="chapter52.html"
 >Kväde (till den svenska diversehandlaren)</a>
<br/><a href="chapter53.html"
 >Kväde (till historiefilosofen)</a>
<br/><a href="chapter54.html"
 >Kväde (diktat och sjunget på farstubron)</a>
<br/><a href="chapter55.html"
 >En morgondröm</a>
<br/><a href="chapter56.html"
 >Likpredikan</a>
<br/><a href="chapter57.html"
 >En vårvisa</a>
<br/><a href="chapter58.html"
 >En sommarpsalm i skördetid</a>
<br/><a href="chapter59.html"
 >Jag är...</a>
<br/><a href="chapter60.html"
 >Sång till våren</a>
<br/><a href="chapter61.html"
 >Vårvisa Till min broder Joachim i Göteborg</a>
<br/><a href="chapter62.html" >Canadaminnen</a>


</p>
</div>
</body>
</html>


EOF
