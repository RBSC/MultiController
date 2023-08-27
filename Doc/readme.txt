--------------------------------------------
MSX FDD-IDE Cartridge version 1.2
Copyright (c) 2015-2023 RBSC
Updated: 27.08.2023
--------------------------------------------

The FDD-IDE is a combo controller that allows to connect up to 2 floppy drives (PC 1.44Mb or older 720kb) and one Compact Flash
card-based disk drive to any MSX computer. The device has the selection to use either Sunrise or Nextor BIOS to operate the
disk drive. For Sunrise the partitions must be not larger than 32Mb, for Nextor the partitions could be maximum 4Gb in size.


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

Starting from firmware version 1.10 it's possible to use the AIC37C65CL or similar FDD controller chip with the board. The previous
version of the firmware is incompatible with these chips.

Previously, we provided 3 different ROMs, but now there's only one. The older ROMs are still located in the "old" and "old1"
subfolders.

The current ROM file "FDD-IDE_V21.ROM" contains a slightly patched version of the Sunrise IDE ROM and the Release version of the
Nextor 2.1.1 IDE ROM that natively supports Carnivore2 and FDD-IDE controllers. This ROM is faster and has the slave device detection
disabled. It is 262kb in size.

The "FDD-IDE_V21_29F040.ROM" is the file that you can burn directly into the 29F040 FlashROM chip. It is 512kb in size and contains
the same data as the "FDD-IDE_V21.ROM" file.



IMPORTANT!
----------

The RBSC provides all the files and information for free, without any liability (see the disclaimer.txt file). The provided information,
software or hardware must not be used for commercial purposes unless permitted by the RBSC. Producing a small amount of bare boards for
personal projects and selling the rest of the batch is allowed without the permission of RBSC.

When the sources of the tools are used to create alternative projects, please always mention the original source and the copyright!


Contact information
-------------------

The members of RBSC group TNT23, Wierzbowsky, Ptero, GreyWolf, SuperMax, Pyhesty, VWarlock and DJS3000 can be contacted via the group's
e-mail address:

info@rbsc.su

The group's coordinator could be reached via this e-mail address:

admin@rbsc.su

The group's website can be found here:

https://rbsc.su/
https://rbsc.su/ru

The RBSC's hardware repository can be found here:

https://github.com/rbsc

The RBSC's 3D model repository can be found here:

https://www.thingiverse.com/groups/rbsc/things

-= ! MSX FOREVER ! =-
