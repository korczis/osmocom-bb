# osmocom-bb

OsmocomBB is an Free Software / Open Source GSM Baseband software implementation.

It intends to completely replace the need for a proprietary GSM baseband software, such as drivers for the GSM analog and digital baseband (integrated and external) peripherals the GSM phone-side protocol stack, from layer 1 up to layer 3

In short: By using [OsmocomBB](http://bb.osmocom.org/trac/wiki/OsmocomBB) on a compatible phone, you are able to make and receive phone calls, send and receive SMS, etc. based on Free Software only.

Over the past 12 months, we've been making very good progress. Most of the hardware drivers have been written, and a relatively complete layer1, layer2 and layer3 exist.

No work has yet been done on any sort of UI on the phone. The only user interface is a telnet-based command line.

To get started, checkout the [PreliminaryRequirements](http://bb.osmocom.org/trac/wiki/PreliminaryRequirements) and then [GettingStarted](http://bb.osmocom.org/trac/wiki/GettingStarted).

## Software

Documentation about software developed by this project.

OsmocomBB source code is kept in the git repository at  git://git.osmocom.org/osmocom-bb.git, which you can browse best from  http://cgit.osmocom.org/

* [GettingStarted](http://bb.osmocom.org/trac/wiki/GettingStarted) -- Getting Started with the Software for the target and host.
* [SoftwareOverview](http://bb.osmocom.org/trac/wiki/SoftwareOverview) -- Overview how all the parts below fit together

### Host programs (running on the PC)

#### General Purpose

* [osmocon](http://bb.osmocom.org/trac/wiki/osmocon) -- A tool for Compal phones; to load code into RAM and execute it
* [mobile](http://bb.osmocom.org/trac/wiki/mobile) -- An application implementing a regular GSM mobile phone (and more)
* [WiresharkIntegration](http://bb.osmocom.org/trac/wiki/WiresharkIntegration) -- How to use OsmocomBB with wireshark protocol analyzer
* [libosmocore](http://bb.osmocom.org/trac/wiki/libosmocore) -- A library with utility functions

#### Advanced / special purpose tools

* [osmoload](http://bb.osmocom.org/trac/wiki/osmoload) -- A tool for flashing and examining phones
* [calypso_pll](http://bb.osmocom.org/trac/wiki/calypso_pll) -- A tool to calculate Calypso DPLL multiplier+divider
* [rita_pll](http://bb.osmocom.org/trac/wiki/rita_pll) -- A tool to calculate the Rita PLL multiplier/divider
* [layer23](http://bb.osmocom.org/trac/wiki/layer23) -- An implementation of GSM Layer2 and upwards.

### Target programs (running on the phone baseband chip)

* [firmware](http://bb.osmocom.org/trac/wiki/firmware) -- The current staging/testing code base for our own software on the Calypso. From it we build a number of apps:
  * hello_world.bin -- An actual 'hello world' application for LCD and serial port
  * [layer1.bin](http://bb.osmocom.org/trac/wiki/layer1.bin) -- The actual Layer1 software as it is to be used with layer23
  * [loader.bin](http://bb.osmocom.org/trac/wiki/loader.bin) -- Our flash loader, dumper and second stage bootloader
  * [compal\_dsp\_dump.bin](http://bb.osmocom.org/trac/wiki/compal_dsp_dump.bin) -- A program to dump the ROM of the DSP inside the Calypso
  * [rssi.bin](http://bb.osmocom.org/trac/wiki/rssi.bin) -- Receive signal strength monitor with spectrum display

## Supported Phone hardware

Information specific to certain Calypso based phones that we support

Designed + Manufactured by Compal, OEM by Motorola

 * [MotorolaC115/C117 (E87)](http://bb.osmocom.org/trac/wiki/MotorolaC115)
 * [MotorolaC123/C121/C118 (E88)](http://bb.osmocom.org/trac/wiki/MotorolaC123) -- our primary target
 * [MotorolaC140/C139 (E86)](http://bb.osmocom.org/trac/wiki/MotorolaC140)
 * [MotorolaC155 (E99)](http://bb.osmocom.org/trac/wiki/MotorolaC155) -- our secondary target
 * [MotorolaV171 (E68/E69)](http://bb.osmocom.org/trac/wiki/MotorolaV171)
 * [SonyEricssonJ100i](http://bb.osmocom.org/trac/wiki/SonyEricssonJ100i)

Designed by Pirelli/Foxconn, manufactured by Foxconn

* [Pirelli DP-L10](http://bb.osmocom.org/trac/wiki/PirelliDPL10)

Designed by Openmoko, manufactured by FIC

* Neo 1973 (GTA01)
* [OpenMoko - Neo Freerunner (GTA02)](http://bb.osmocom.org/trac/wiki/OpenMoko)

### Accessories

You will need a [SerialCable](http://bb.osmocom.org/trac/wiki/Hardware/SerialCable) to connect the phone to a PC

## Random bits and pieces

* SIM related
  * [RebelSIM](http://bb.osmocom.org/trac/wiki/RebelSIM) -- How the Rebel SIM card cand be used as SIM proxy
  * [RebelSIM_Scanner](http://bb.osmocom.org/trac/wiki/RebelSIM_Scanner) -- to scan/trace communication between SIM and phone (rubbish)
  * [SIMtrace](http://bb.osmocom.org/trac/wiki/SIMtrace) -- our custom hardware / firmware / software to get SIM-ME traces into wireshark
  * [SIMReader](http://bb.osmocom.org/trac/wiki/SIMReader) -- How to connect to network using provider SIM
  * [softSIM](http://bb.osmocom.org/trac/wiki/softSIM) -- How to do software SIM
* a collection of phone [Terminal Profiles](http://bb.osmocom.org/trac/wiki/TerminalProfile)
* [Notes on sniffing](http://bb.osmocom.org/trac/wiki/Sniffing)
* [dct3-gsmtap](http://bb.osmocom.org/trac/wiki/dct3-gsmtap) -- A tool to obtain GSMTAP messages for SIM and GSM from Nokia DCT3 (eg, 3310) phones
* [Hardware/FilterReplacement](http://bb.osmocom.org/trac/wiki/Hardware/FilterReplacement) -- How to replace filters on Motorola phones
* [PotentialCalypsoTargets](http://bb.osmocom.org/trac/wiki/PotentialCalypsoTargets) -- Potential phone hardware to use with osmocom-bb

## References

### Related projects ¶

* [nuttx-bb](http://bb.osmocom.org/trac/wiki/nuttx-bb) -- Port of nuttx on the osmocom-bb comaptible phones.
* [airprobe](https://svn.berlin.ccc.de/projects/airprobe/) -- Free Software GSM protocol analyzer
* [OpenBSC](http://openbsc.osmocom.org/) -- Free Software BSC/MSC/HLR/SMSC
* [OpenBTS](http://openbts.sourceforge.net/) -- Free Software Um-to-SIP gateway
* [OsmocomTETRA](http://tetra.osmocom.org/) -- Free Software TETRA related code

### Recommended reading

* [http://laforge.gnumonks.org/papers/gsm_phone-anatomy-latest.pdf](http://laforge.gnumonks.org/papers/gsm_phone-anatomy-latest.pdf) -- Introduction to contemporary GSM cellphone hardware
* [http://www2.informatik.hu-berlin.de/~goeller/](http://www2.informatik.hu-berlin.de/~goeller/) -- Homepage of Dr.-Ing. Joachim Goeller, lots of GSM tutorials
* [http://sourceforge.net/projects/plabs/](http://sourceforge.net/projects/plabs/) -- Source code of the firmware of the Vitelcom TSM30 phone (dead link)
* [OsmocomBB presentation at SSTIC 2010](http://svn.gnumonks.org/trunk/presentation/2010/osmocombb-sstic2010/osmocombb-security.pdf)
* [Article covering OsmocomBB at h-online, from July 2012](http://www.h-online.com/open/features/How-free-is-my-phone-1634071.html)