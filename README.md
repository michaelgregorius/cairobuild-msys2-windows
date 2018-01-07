# Build script for a static Cairo library under Windows with MSYS2
![Cairo banner](https://cairographics.org/cairo-banner.png)
This build script builds a static version of the Cairo graphics library under Windows using MSYS2. It builds the following libraries:
   - ZLib
   - Libpng
   - Freetype2
   - Pixman
   - Cairo
## Steps
1. Download and install [MSYS2](http://www.msys2.org/).
2. Make sure that you have all the packages installed that are listed in the file "Installed MSYS2-Packages.txt".
3. Clone this repository to a location of your choice.
3. Download the sources of Cairo and its dependencies. Make sure to download the versions that can be decompressed with the `tar` command, i.e files ending in `tar.gz`, `tar.bz2` or `tar.xz`! Download them here:
   * [ZLib](https://zlib.net/)
   * [libpng](http://www.libpng.org/pub/png/libpng.html)
   * [Freetype2](https://www.freetype.org/) / [Download](https://download.savannah.gnu.org/releases/freetype/?C=M&O=D)
   * [Pixman](http://www.pixman.org/) / [Download](https://www.cairographics.org/releases/)
   * [Cairo](https://cairographics.org/) / [Download](https://www.cairographics.org/releases/)
4. Put the downloaded files into the `packages` folder.
5. Depending on the versions of the libraries and the type of archives that you have downloaded you might have to adjust the script `build-all.sh`. If you don't want to do this just make sure to download the versions that are defined in the script.
   * Adjust the variables `ZLIB`, `LIBPNG`, `PIXMAN`, `FREETYPE` and `CAIRO` found at the top of the script according to the versions you have downloaded.
   * Adjust the variables `ZLIB_ARCHIVE`, `LIBPNG_ARCHIVE`, `PIXMAN_ARCHIVE`, `FREETYPE_ARCHIVE` and `CAIRO_ARCHIVE` according to the type of archive that you have downloaded, i.e. `tar.gz`, `tar.xz` etc.
5. Run the script `build-all.sh`. You might have to make it executable using the command `chmod u+x build-all.sh`.
6. If the script runs successfully you should find the libraries with their headers in the folder `install`.

Michael Gregorius 2018
