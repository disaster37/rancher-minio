#!/usr/bin/with-contenv sh


exec ${CONFD_HOME}/bin/confd -confdir ${SERVICE_SCHEDULER}/confd/etc -sync-only -onetime -backend rancher -prefix "/2015-12-19"
