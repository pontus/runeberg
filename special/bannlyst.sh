#!/bin/sh



echo '3 s/^Den dag/<p>Den dag/
wq'  | ed 15.html || true

echo '3 s/^Allteftersom/<p>Allteftersom/
wq'  | ed 03.html || true

