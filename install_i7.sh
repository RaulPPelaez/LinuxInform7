
VERSION=6M62
INSTALL_FOLDER=$HOME/Inform7

if test -d $INSTALL_FOLDER; then
    echo "Inform7 is already installed in this system. Or at least the Inform7 folder exists"
    exit;
fi

while true; do
    read -p "This will try to install Inform7 version $VERSION to $INSTALL_FOLDER, agree?: " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

i7url=http://inform7.com/apps/$VERSION/I7_${VERSION}_Linux_all.tar.gz
wget -q --show-progress $i7url 

if ! test -e I7_${VERSION}_Linux_all.tar.gz; then
    echo "ERROR: Something went wrong, I cannot download Inform7 from $i7url" 1>&2
    exit 1;
fi

tar xf I7_${VERSION}_Linux_all.tar.gz
cd inform7-$VERSION
if ! bash install-inform7.sh --prefix $INSTALL_FOLDER ; then
    echo "ERROR: install-inform7.sh is not present or failed" 1>&2
    cd ..;
    exit 1;
fi

cd ..

if test -e ~/.i7rc; then
    echo "Backing up previously found configuration file .i7rc to .i7rc.bak" 
    mv ~/.i7rc ~/.i7rc.bak
fi

printf "$USER\nq\n" | $INSTALL_FOLDER/bin/i7 > /dev/null 2>&1

rm -rf I7_${VERSION}_Linux_all.tar.gz inform7-$VERSION

echo "Everything seems to have went as expected, you should be able to run inform7 with $INSTALL_FOLDER/bin/i7"
