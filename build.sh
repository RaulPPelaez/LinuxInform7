
if test $# -eq 0; then
    inputfile=story.ni
else
    inputfile=$1
fi

storyname=$(basename $inputfile .ni)
i7exe=i7

if ! test $(which $i7exe); then
    if test -d $HOME/Inform7 ; then
	i7exe=$HOME/Inform7/bin/i7
    else
	echo "ERROR: i7 not found, please ensure i7 is in path or run install_i7.sh" 1>&2	
	exit 1;
    fi
fi

if ! test -e $inputfile; then
    echo "ERROR: $inputfile not found" 1>&2
    exit 1;
fi

tmpdir=$(mktemp)
logfile=compilation.log
rm -f $logfile
if ! $((printf "s\n$tmpdir\ns\nb\nr\nq\n") | $i7exe > $logfile 2>&1); then
    echo "ERROR: i7exe project creation failed, see $logfile" 2>&1;
    rm -rf $tmpdir.*
    exit 1
fi

cp $inputfile $tmpdir.inform/Source/story.ni

if ! $($i7exe -r $tmpdir.inform >> $logfile 2>&1) ; then
    echo "Compilation Errors:" 1>&2
    cat $logfile | awk '/>--/{p=1}/^++ /{p=0}p' 1>&2
else
    echo "Compilation and releasing successful"
    cp -rf $tmpdir.materials/Release/ $storyname.release
fi

rm -rf $tmpdir*
