MSX FDD+IDE Cartridge version 1.2
Copyright (c) 2015 RBSC


Jumper settings
---------------

The cartridge has a set of jumpers to configure the hardware and internal software. There are 4 jumpers consisting of 3 pins
and 3 jumpers consisting of 2 pins. The jumpers that consist of 3 pins are used to configure the DS (drive select) signal.
The 2-pin jumpers configure the on-board devices and BIOSes.

When all 3 pin jumpers are in the upper position, then a normal PC drive (with default DS1 setting) can be connected to the standard
PC  floppy cable. There can be maximum 2 drives connected to the cartridge. The drive connected to the middle cable's connector will
be B: and the drive connected to the end of the cable will be A:.

When all 3 pin jumpers are in the lower position, then a normal PC drive (with default DS2 setting) can be connected to the standard
PC floppy cable. There can be maximum 2 drives connected to the cartridge. The drive connected to the middle cable's connector will
be A: and the drive connected to the end of the cable will be B:.

When the 3 pin jumpers are set as shown for DS0 (see the markings on the cartridge), then a DS/DD 720kb drive with DS0 setting can be
connected to the controller with the straight floppy cable (PC cable with a "twist" won't work). Only one drive can be connected to
the controller in this case.

The "F+H" jumper is used to enable or disable the expanded slot. If the jumper is set, then both floppy controller and IDE controller
are enabled. If the jumper is off, then only one controller is enabled (see below).

The "F/H" jumper is used to set a priority for controllers when "F+H" jumper is installed. A set jumper will make IDE controller
to be the first device and the floppy controller will be the second device. If the "F+H" jumper is not installed, then the "F/H"
jumper enables only one controller - either floppy or IDE. The set jumper enables IDE controller in this case.

The "ROM 1/2" jumper is used to select which IDE BIOS will be used by the cartridge. The set jumper will enable the "Sunrise" BIOS,
otherwise the "Nextor" BIOS will be enabled. 


NOTES
-----

The ROMs that are provided for this controller are different only in Nextor version. One of the ROMs has the latest available
Nextor version (Alpha) that supports DSK emulation. So if you are planning to use DSK image emulation, please write the Alpha
ROM BIOS into the EEPROM chip.


IMPORTANT!
----------

The RBSC provides all the files and information for free, without any liability (see the disclaimer.txt file). The provided information,
software or hardware must not be used for commercial purposes unless permitted by the RBSC. Producing a small amount of bare boards for
personal projects and selling the rest of the batch is allowed without the permission of RBSC.

When the sources of the tools are used to create alternative projects, please always mention the original source and the copyright!


Contact information
-------------------

The members of RBSC group Wierzbowsky, Ptero and DJS3000 can be contacted via the MSX.ORG or ZX-PK.RU forums. Just send a personal
message and state your business.

The RBSC repository can be found here:

https://github.com/rbsc


-= ! MSX FOREVER ! =-
