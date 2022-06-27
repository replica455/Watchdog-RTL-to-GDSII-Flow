#!/bin/tcsh -f
#-------------------------------------------
# qflow exec script for project /home/vlsi/Desktop/Watchdog
#-------------------------------------------

# /usr/local/share/qflow/scripts/synthesize.sh /home/vlsi/Desktop/Watchdog Watchdog /home/vlsi/Desktop/Watchdog/source/Watchdog.v || exit 1
# /usr/local/share/qflow/scripts/placement.sh -d /home/vlsi/Desktop/Watchdog Watchdog || exit 1
# /usr/local/share/qflow/scripts/vesta.sh  /home/vlsi/Desktop/Watchdog Watchdog || exit 1
# /usr/local/share/qflow/scripts/router.sh /home/vlsi/Desktop/Watchdog Watchdog || exit 1
# /usr/local/share/qflow/scripts/vesta.sh  -d /home/vlsi/Desktop/Watchdog Watchdog || exit 1
# /usr/local/share/qflow/scripts/migrate.sh /home/vlsi/Desktop/Watchdog Watchdog || exit 1
# /usr/local/share/qflow/scripts/drc.sh /home/vlsi/Desktop/Watchdog Watchdog || exit 1
# /usr/local/share/qflow/scripts/lvs.sh /home/vlsi/Desktop/Watchdog Watchdog || exit 1
/usr/local/share/qflow/scripts/gdsii.sh /home/vlsi/Desktop/Watchdog Watchdog || exit 1
# /usr/local/share/qflow/scripts/cleanup.sh /home/vlsi/Desktop/Watchdog Watchdog || exit 1
# /usr/local/share/qflow/scripts/display.sh /home/vlsi/Desktop/Watchdog Watchdog || exit 1
