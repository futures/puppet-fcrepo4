#!/bin/sh
### BEGIN INIT INFO
# Provides:          fcrepo4
# Required-Start:    $syslog
# Required-Stop:     $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: fedora repository 4
### END INIT INFO
# /etc/init.d/fcrepo4
#

. /etc/init.d/functions

FCREPO4_USER="fcrepo4"
FCREPO4_HOME="/usr/local/fcrepo4"
MAVEN_OPTS="-Xmx512m"

# The following lines are required to run fcrepo4 as a service in Redhat.
# These lines should remain commented out.
# It is necessary to run "chkconfig fcrepo4 on" to enable matterhorn service management with Redhat.

#chkconfig: 2345 99 01
#description: fedora repository 4

WEBAPP_DIR="$FCREPO4_HOME/fcrepo-webapp"

###############################
### NO CHANGES NEEDED BELOW ###
###############################

case "$1" in
  start)
    echo -n "Starting fcrepo4 as user $FCREPO4_USER: "
    daemonize -u $FCREPO4_USER -c $WEBAPP_DIR -p /var/run/fcrepo4.pid -l /var/lock/subsys/fcrepo4 -o /var/log/fcrepo4/run.log -e /var/log/fcrepo4/error.log /usr/bin/mvn jetty:run
    echo "done."
    ;;
  stop)
    echo -n "Stopping fcrepo4: "
    killproc -p /var/run/fcrepo4.pid fcrepo4 && rm /var/lock/subsys/fcrepo4
    echo "done."
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  status)
    status -p /var/run/fcrepo4.pid fcrepo4
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status}"
    exit 1
    ;;
esac

exit 0