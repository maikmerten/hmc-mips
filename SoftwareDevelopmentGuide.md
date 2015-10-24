# Introduction #

This document is designed to take you through the steps of setting up Cygwin, yoda\_warrior, and downloading source for the HMC MIPS such that you can develop your own C files and write them to coefficient files.

You will need:
  * The yoda\_warrior.tar.gz tar file
  * An internet connection

# Setup procedures #

There are three steps to the setup:
  1. Get a working copy of Cygwin
  1. Get yoda\_warrior running
  1. Download the hmc-mips systems source files (You need the /systems/src folder specifically just for compiling.)

## Cygwin Setup ##

  1. Download cygwin from this site:  http://www.cygwin.com/
  1. Run setup.exe
  1. click next twice
  1. Set to install to a directory on your main drive (e.g. `C:\cygwin`), and click next
  1. Set where download files will be placed, and click next twice
  1. Select an ftp mirror near you geographically.  I usually use [ftp://mirrors.xmission.com](ftp://mirrors.xmission.com)
  1. Select the packages you want to install.  Please include the following packages (by clicking where it says "skip" next to each entry):
    * Everything in Base
    * Devel: automake, binutils, bison, gcc-core, make, subversion
    * Editors: Choose your favorite editor (e.g. vim or emacs)
    * Interpreters: python
    * Shells: make sure bash (or your favorite shell) will install
  1. Click next to start installation.
  1. Click finish


## Yoda\_warrior Setup ##

After Cygwin has been installed, run the command prompt for Cygwin (bash shell).  Copy the tar file for yoda\_warrior into your home directory.  Make a directory called `yoda_warrior` and enter it, then untar yoda\_warrior from your home directory into the newly created directory using the command

```
tar xvf ../yoda_warrior.tar.gz
```

Wait a long time for it to finish.


## MIPS Processor toolchain setup ##

Now from your home directory run

```
svn checkout http://hmc-mips.googlecode.com/svn/trunk/ hmc-mips
```

to get all of the source from the mips project.  Then go to the 'hmc-mips/systems/src' folder.  From here, you can write your programs.  If your program is called "`myfile.c`", then you should be able to execute

```
make myfile.v
```

which will compile your program, check it for invalid instructions, and dump a verilog file (along with the bootloader) for synthesis in Xilinx into the folder.