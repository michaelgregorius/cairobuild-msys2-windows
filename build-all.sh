#!/bin/sh

# Written by Michael Gregorius in 2018.

# Configure versions here! These are also the directories that are expected to
# be created by the decompressed archives.
ZLIB="zlib-1.2.11"
LIBPNG="libpng-1.6.34"
PIXMAN="pixman-0.34.0"
FREETYPE="freetype-2.8.1"
CAIRO="cairo-1.14.12"

# Folder where the packages have been put
PACKAGE_FOLDER="packages"

# Archive names are expected to correspond to the directories / versions
# defined above
ZLIB_ARCHIVE="${PACKAGE_FOLDER}/${ZLIB}.tar.gz"
LIBPNG_ARCHIVE="${PACKAGE_FOLDER}/${LIBPNG}.tar.gz"
PIXMAN_ARCHIVE="${PACKAGE_FOLDER}/${PIXMAN}.tar.gz"
FREETYPE_ARCHIVE="${PACKAGE_FOLDER}/${FREETYPE}.tar.gz"
CAIRO_ARCHIVE="${PACKAGE_FOLDER}/${CAIRO}.tar.xz"

# This is the directory where the headers and libs will be installed to
INSTDIR="$PWD/install"

# Add this directory to pkg-config's search path so that everything is built
# against the libraries that we build.
export PKG_CONFIG_PATH="$INSTDIR/lib/pkgconfig"

# Checks that a given archive exists:
# $1: Name of the archive
function check_archive_exists {
  if [ ! -f "$1" ]; then
    echo "Archive $1 does not exist!"
    exit 1
  fi
}

# Decompresses the archive to an expected directory. Deletes the expected
# directory if it already exists.
#
# $1: File name of the archive
# $2: Expected directory
function decompress_archive {
  if [ -d "$2" ]; then
    echo "Deleting existing directory $2..."
    rm -rf "$2"
  fi

  echo "Decompressing $1..."
  tar xf $1
  
  if [ ! -d "$2" ]; then
    echo "Expected directory $2 was not created! Exiting..."
    exit 1
  else
    echo -e "Done!\n"
  fi
}

# Create the installation directory if it does not exist
if [ ! -d "$INSTDIR" ]; then
  echo "Creating install directory $INSTDIR..."
  mkdir $INSTDIR
  echo -e "Done!\n"
fi


# Check that all archives exist
check_archive_exists ${ZLIB_ARCHIVE}
check_archive_exists ${LIBPNG_ARCHIVE}
check_archive_exists ${PIXMAN_ARCHIVE}
check_archive_exists ${FREETYPE_ARCHIVE}
check_archive_exists ${CAIRO_ARCHIVE}


# Decompress archives
decompress_archive ${ZLIB_ARCHIVE} ${ZLIB}
decompress_archive ${LIBPNG_ARCHIVE} ${LIBPNG}
decompress_archive ${PIXMAN_ARCHIVE} ${PIXMAN}
decompress_archive ${FREETYPE_ARCHIVE} ${FREETYPE}
decompress_archive ${CAIRO_ARCHIVE} ${CAIRO}


# Build...
cd  ${ZLIB}
make -f win32/Makefile.gcc BINARY_PATH=$INSTDIR/bin INCLUDE_PATH=$INSTDIR/include LIBRARY_PATH=$INSTDIR/lib install
cd ..

cd ${LIBPNG}
./configure --prefix=$INSTDIR --disable-shared --with-zlib-prefix=$INSTDIR
make -j4 install
cd ..

cd ${PIXMAN}
./configure --prefix=$INSTDIR --disable-shared
make -j4 install
cd ..

cd ${FREETYPE}
./configure --prefix=$INSTDIR --disable-shared --with-bzip2=no
make -j4 install
cd ..

cd ${CAIRO}
# Does not seem to be needed for some reason
# export png_REQUIRES="libpng"
./configure --prefix=$INSTDIR --disable-shared
make -j4 install
cd ..

echo "Done!"
