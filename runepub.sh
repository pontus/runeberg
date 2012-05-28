#!/bin/bash

set -e

# Some sensible defaults
headskip=3
footskip=2
filenamelen=4

work="$1"

if [ "x$work" = x ]; then
    echo Please specify work
    exit 1
fi

if fgrep -q "$work:" isbn.txt; then
  isbn=`fgrep "$work:" isbn.txt | sed -e 's/.*://' -e 's/-//g'`
fi

runebergid="http://runeberg.org/$work/"
workdir="runepub-ws-$work-$$"


rm -rf "$workdir"
mkdir -p "$workdir"/work/META-INF




pushd runepub-ws$$
wget -O "$work.zip" "http://runeberg.org/download.pl?mode=txtzip&work=$work"
unzip "$work".zip

chmod -R "u+w" *

grep ^LICENSE: Metadata && echo License found in Metadata file, is this really free? && exit 1

charset=l1
language=sv
#TODO: check for other languages

if grep ^CHARSET: Metadata; then
    charset=`grep ^CHARSET: Metadata | sed -e 's/.*: *//'`
fi

authors=`grep ^AUTHORKEY: Metadata | sed -e 's/.*: *//'`
year=`grep ^PUBLISHING_YEAR: Metadata | sed -e 's/.*: *//'`
titlename=`grep ^TITLE: Metadata | sed -e 's/.*: *//'  | recode l1..utf8`

for p in $authors; do
  authorname="$authorname "`curl  http://runeberg.org/authors/$p.html | grep '<title>' | sed -e 's/<[^>]*>//g' | recode l1..utf8`
done

echo $authorname $titlename

# Source any special configuration
if [ -r "../special/$work.sh" ]; then
  . "../special/$work.sh"
fi

# Fix up standard pages
cp ../edition.html work/

sed -e "s/%AUTHOR%/$authorname/g" -e "s/%TITLE%/$titlename/g" ../titletemplate.html > work/title.html



# Set up some general stuff for the epub


    echo -n 'application/epub+zip' > work/mimetype

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
   <text>$titlename</text>
</docTitle>
 
<docAuthor>   
   <text>$authorname</text>
</docAuthor>
 
<navMap>
   <navPoint  id="title" playOrder="0">
      <navLabel><text>Titelsida</text></navLabel>
      <content src="title.html"/>
    </navPoint>

   <navPoint  id="edition" playOrder="1">
      <navLabel><text>Om den här utgåvan</text></navLabel>
      <content src="edition.html"/>
    </navPoint>
EOF


if [ "x$isbn" != x ]; then
  isbncode='<dc:identifier id="BookIdISBN" opf:scheme="ISBN">'"$isbn"'</dc:identifier>'
fi

cat ->work/book.opf <<EOF
<?xml version="1.0"?>
<package version="2.0" xmlns="http://www.idpf.org/2007/opf" unique-identifier="BookId">
 
<metadata xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:opf="http://www.idpf.org/2007/opf">
   <dc:title>$titlename</dc:title>
   <dc:language>$language</dc:language>
   <dc:identifier id="BookId">$runebergid</dc:identifier>
   <dc:creator opf:role="aut">$authorname</dc:creator>
   $isbncode
</metadata>

<manifest>
   <item id="title"
         href="title.html"
         media-type="application/xhtml+xml"/>

   <item id="edition"
         href="edition.html"
         media-type="application/xhtml+xml"/>
EOF






    echo '<itemref idref="title" /> <itemref idref="edition" />' > work/itemrefs


num=1;

# TODO: Handle things that aren't collections

egrep -v '(^#|^-)' Articles.lst | while read l; do
  htmlfile=`echo $l | sed -e 's/|.*//'`.html
  chaptername=`echo $l | sed -e 's/.*|\([^|]*\)|.*/\1/' | recode $charset..utf8`
  pages=`echo $l | sed -e 's/.*|//'`
  echo $htmlfile $chaptername $pages
  

  if [ ! -f "$htmlfile" ]; then
      # We need to build a htmlfile

      htmlfile="$chaptername.html"

      rm -f "$htmlfile"
      echo "<h2>$chaptername</h2><p>" >>"$htmlfile"
      for p in $pages; do
	  # Expand ranges, if needed. Assumes increasing ranges. Assume fixed number of digits in filenames for now.
          curpages=`seq -f %0${filenamelen}g "${p%-*}" "${p#*-}"`

	  for q in $curpages; do
	      # TODO: Actually detect if we have headers/footers to remove instead of assuming so.
	      cat Pages/$q.txt | tail -n +"$headskip" | head -n -"$footskip" | recode $charset..utf8 | ../textwash.sh >>"$htmlfile"
	  done
      done
      echo '</p>' >> "$htmlfile"
    else
      mv "$htmlfile" "$htmlfile.orig"
      ../htmlwash.sh < "$htmlfile.orig" > "$htmlfile"
    fi      

    num=$((num+1))
      tidy -n -asxhtml -utf8 "$htmlfile"  >"$htmlfile.tmp" || true
      mv "$htmlfile.tmp" "work/chapter$num.html"

  

      # Add to index


    cat ->>work/book.ncx <<EOF
   <navPoint class="chapter" id="chapter$num" playOrder="$num">
      <navLabel><text>$chaptername</text></navLabel>
      <content src="chapter$num.html"/>
    </navPoint>
EOF


    cat - >>work/book.opf <<EOF
   <item id="chapter$num"
         href="chapter$num.html"
         media-type="application/xhtml+xml"/>
EOF


    echo "<itemref idref=\"chapter$num\" /> " >> work/itemrefs


done

# Close index

    cat ->>work/book.ncx <<EOF
</navMap>
</ncx>
EOF


itemrefs=`cat work/itemrefs`
rm -f work/itemrefs

cat ->>work/book.opf <<EOF

   <item id="ncx"
         href="book.ncx"
         media-type="application/x-dtbncx+xml"/>
</manifest>
 
<spine toc="ncx">
$itemrefs
</spine>
</package>
EOF


# Source any special configuration
if [ -r "../special/$work.sh" ]; then
  . "../special/$work.sh"
fi


# Now, build the actual epub
cd work


rm -f "../../$work.epub"
zip -X -9 "../../$work.epub" mimetype
zip -X -9 -u -r "../../$work.epub" *

popd
#rm -rf "$workdir"

if [ "x$isbn" != x ]; then
  ln -s "$work.epub" "$isbn.epub" || true
fi

if [ -r epubcheck.jar ]; then
  java -jar epubcheck.jar "$work.epub"
fi
