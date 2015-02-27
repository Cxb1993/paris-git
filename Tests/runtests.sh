#!/bin/bash
#set -x

command -v gnuplot >/dev/null 2>&1 || echo "Warning: gnuplot is not installed"
CGFontGetGlyphPathIsObsolete=`gnuplot -e "set term pdf; set out 'tmp.pdf'; plot 0" 2>&1 | grep -c obsolete`

export CGFONTGETGLYPH_PARIS_PROBLEM=0

if [ $CGFontGetGlyphPathIsObsolete -gt 0 ]; then 
echo "CGFontGetGlyphPathIsObsolete problem, no pdf output" 
echo "This problem occurs when running gnuplot on MacOS X Yosemite version 10.10.1 and above"
echo "the full error message may be obtained by running"
echo gnuplot -e \"set term pdf\; plot sin\(x\)\" \> \/dev\/null 
export CGFONTGETGLYPH_PARIS_PROBLEM=1
fi

for dir in `ls`; do 
    if [ -d $dir ]; then
	if ! [ -a $dir/DONOTRUN ] ; then
	    cd $dir
	    if [ -e 'run.sh' ]; then
		echo running test in $dir
		chmod +x run.sh
		./run.sh > outtest
# last line in output of test should be PASS or FAIL
		tail -n 2 outtest
	    fi
	    cd ..
	fi
    fi
done
