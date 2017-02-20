#!/usr/bin/with-contenv sh


exec ${CONFD_HOME}/bin/confd -confdir ${SCHEDULER_VOLUME}/confd/etc -sync-only -onetime -backend rancher
