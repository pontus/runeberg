#!/bin/sh

cd /tmp
mkdir runebergepub$$
cd runebergepub$$

wget -nd -m -np "$1"

mkdir work
mkdir work/META-INF
parts=""


tidy -n -asxhtml index.html >mod1_index.html


title="`xmlstarlet el -v  mod1_index.html | grep DC.Title  | sed -e "s/.*content='\(.*\)'].*/\1/" `"
author="`xmlstarlet el -v  mod1_index.html | grep DC.Creator.PersonalName  | sed -e "s/.*content='\(.*\)'].*/\1/" `"

for p in [0-9]*.html; do
    sed -e '\_<form_,\_</form_ d' \
	-e 's/<body.*>/<body>/' \
	-e 's/bgcolor="[^"]*"//g' \
	-e 's/text="[^"]*"//g' \
	-e 's/alink="[^"]*"//g' \
	-e 's/vlink="[^"]*"//g' \
	-e 's/link="[^"]*"//g' \
    -e '/<script/,/<.script>/ d' \
        -e '/copyright_string/,/clear/ d' \
	-e '/<br clear=all><hr noshade><tt>Project Runeberg/,/wwwinst.lpc/ d' $p > mod1_$p;
    tidy -n -asxhtml -output mod2_$p mod1_$p
    fgrep -v '<link' mod2_$p  >mod3_$p
    cp mod3_$p work/$p
    parts="$parts ${p%.html}"
done

    cp *jpg *png *JPG *PNG *gif *GIF work/

    uid="$1";




    echo 'application/epub+zip' > work/mimetype
    cat - >work/META-INF/container.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<container xmlns="urn:oasis:names:tc:opendocument:xmlns:container" version="1.0">
   <rootfiles>
      <rootfile full-path="book.opf" media-type="application/oebps-package+xml"/>
   </rootfiles>
</container>
EOF

    cat ->work/book.ncx <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE ncx PUBLIC "-//NISO//DTD ncx 2005-1//EN" 
   "http://www.daisy.org/z3986/2005/ncx-2005-1.dtd">
 
<ncx version="2005-1" xml:lang="en"
     xmlns="http://www.daisy.org/z3986/2005/ncx/">
 
<head>
    <!-- The following four metadata items are required for all NCX documents,
         including those conforming to the relaxed constraints of OPS 2.0 -->
 
   <meta name="dtb:uid" content="$uid"/> <!-- same as in .opf -->
   <meta name="dtb:depth" content="1"/> <!-- 1 or higher -->
   <meta name="dtb:totalPageCount" content="0"/> <!-- must be 0 -->
   <meta name="dtb:maxPageNumber" content="0"/> <!-- must be 0 -->
</head>
 
<docTitle>
   <text>$title</text>
</docTitle>
 
<docAuthor>   
   <text>$author</text>
</docAuthor>
 
<navMap>
EOF

num=0;

for p in $parts; do
    num=$((num+1))
    cat ->>work/book.ncx <<EOF
   <navPoint class="chapter" id="part$p" playOrder="$num">
      <navLabel><text>Kapitel $p</text></navLabel>
      <content src="$p.html"/>
    </navPoint>
EOF
done


    cat ->>work/book.ncx <<EOF
</navMap>
</ncx>
EOF

cat ->work/book.opf <<EOF
<?xml version="1.0"?>
<package version="2.0" xmlns="http://www.idpf.org/2007/opf" unique-identifier="BookId">
 
<metadata xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:opf="http://www.idpf.org/2007/opf">
   <dc:title>$title</dc:title>
   <dc:language>$language</dc:language>
   <dc:identifier id="BookId">$uid</dc:identifier>
   <dc:creator opf:role="aut">$author</dc:creator>
</metadata>

<manifest>
EOF

for p in $parts; do 
    cat - >>work/book.opf <<EOF
   <item id="part$p"
         href="$p.html"
         media-type="application/xhtml+xml"/>
EOF

done

cat ->>work/book.opf <<EOF

   <item id="ncx"
         href="book.ncx"
         media-type="application/x-dtbncx+xml"/>
</manifest>
 
<spine toc="ncx">
EOF

for p in $parts; do 
    cat - >>work/book.opf <<EOF
   <itemref idref="part$p" />
EOF
done

cat ->>work/book.opf <<EOF

</spine>
</package>
EOF

cd work
rm -f "../${author} - ${title}.epub"
zip -9 "../${author} - ${title}.epub" mimetype
zip -9 -u -r "../${author} - ${title}.epub" * 
cd ..
ebook-convert "${author} - ${title}.epub"   "${author} - ${title}.mobi"
ls "${author} - ${title}.epub"  "${author} - ${title}.mobi"
calibre "${author} - ${title}.epub"
