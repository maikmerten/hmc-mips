_Note:_ If you want to develop C code software for the HMC MIPS chip, then you are looking for the SoftwareDevelopmentGuide.

# Prerequisites #

  1. Provide the project administer with your gmail address so you may be added as a project member.
  1. [ToirtoiseSVN](http://tortoisesvn.net/downloads) (Requires restart)
  1. Xilinx ISE (8.2i is tried and tested)
  1. ModelSim (6.2c is tried and tested)
  1. Synplify Pro (8.5.1 is tried and tested)



# Checking Out the Source Code #

  * Find your google-generated password from the link in the Source tab of the project website.
  * Using Windows Explorer, browse to the directory to place the source tree in.
  * Right-click the folder background and select "SVN Checkout..."
  * Fill out the form as in the image:

![http://hmc-mips.googlecode.com/svn/trunk/images/checkout1.jpg](http://hmc-mips.googlecode.com/svn/trunk/images/checkout1.jpg)

# Creating the Xilinx Project #

The Xilinx project file format is not friendly to version control.  To avoid irritating conflicts, the project must be created and modified manually.

  * Open the Xilinx Project Navigator
  * Go File -> New Project
  * Set Project Name to "hmc-mips"
  * Change the Project Location to the exact path to the root of the SVN tree (where you checked out the code, **NOT** the "src" subdirectory and **NOT** a new subdirectory called hmc-mips)

![http://hmc-mips.googlecode.com/svn/trunk/images/newproject1.jpg](http://hmc-mips.googlecode.com/svn/trunk/images/newproject1.jpg)

  * Click next, make the details the same as this:

![http://hmc-mips.googlecode.com/svn/trunk/images/newproject2.jpg](http://hmc-mips.googlecode.com/svn/trunk/images/newproject2.jpg)

  * Click next, next.
  * In the Add Existing Sources dialog, select "Add Source."  Add all the source files that are in the svn tree.  (At the time of this writing, this is all the .v files in the src and testing subdirectories)
  * **Uncheck** "Copy to project" -- we want to be working on the same version that Subversion manages. Note that there will likely be several more files than shown in the screenshot below.

![http://hmc-mips.googlecode.com/svn/trunk/images/newproject3.jpg](http://hmc-mips.googlecode.com/svn/trunk/images/newproject3.jpg)

  * Click next, finish.
  * Click OK when the "Adding Source Files..." dialog comes up


# Run a Trial Simulation #

  * With the project open, in the Source window, change "Sources for:" to "Behavioral Simulation."
  * Select "testbench" in the hierachy.
  * In the Processes window, expand "Modelsim Simulator" and double click "Simulate model behavior.

![http://hmc-mips.googlecode.com/svn/trunk/images/behavior1.jpg](http://hmc-mips.googlecode.com/svn/trunk/images/behavior1.jpg)

  * When Modelsim loads, type "run" a few times.  If everything works, "Simulation Succeeded" or some similar positive message will come up. **Note: Testing is likely to change significantly from this description, see the [testing documentation](TestingGuide.md) for more details.**
```
VSIM 2> run
VSIM 3> run
VSIM 4> run
# Simulation succeeded
# Break at testing/mipstest.v line 36
VSIM 5> 
```


# Editing Environment #

You may use ISE if you are more comfortable with it than other text editors.  Keep in mind you can work directly in Modelsim so you don't have to continually load and reload it.

## 2 Space Tabs ##

For the sake of consistent style, use two spaces for tabbing.

### Editing in ISE ###
Change your settings as following in ISE:

![http://hmc-mips.googlecode.com/svn/trunk/images/editor_options.jpg](http://hmc-mips.googlecode.com/svn/trunk/images/editor_options.jpg)

### Editing in vim ###

Add this to your vimrc file:

```
set tabstop=2
set expandtab
set shiftwidth=2
set autoindent
set textwidth=80
```

# Source Code Updates #

Use SVN's update feature to load changes from the server.  Watch for new files being added to the source tree.  These will have to be added as non-copies to your project.  (If you don't notice the files being added, you'll probably get an error.)  Also, any conflicts will have to be resolved in the usual manner.  For more details on code management, [find a Subversion tutorial](http://www.google.com/search?q=subversion+tutorial&ie=utf-8&oe=utf-8&rls=org.mozilla:en-US:official).


