
num=1
cat Articles.lst  | recode $charset..utf8 | egrep -v '(^#|^-|^\s*$)' | while read l; do
  num=$((num+1))

  oldlink=`echo $l | sed -e 's/|.*//'`.html
  newlink=chapter$num.html

  echo $oldlink '=>' $newlink
  echo "1,\$ s,href=\"$oldlink\",href=\"$newlink\",g
wq"  | ed index.html || true
done
