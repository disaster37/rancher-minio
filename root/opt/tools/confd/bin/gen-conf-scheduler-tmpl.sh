#!/usr/bin/env bash

cat << EOF > ${SERVICE_VOLUME}/confd/etc/conf.d/scheduler.cfg.toml
[template]
prefix = "/self/service"
src = "scheduler.cfg.tmpl"
dest = "${SERVICE_VOLUME}/confd/bin/scheduler.cfg"
owner = "${SERVICE_USER}"
mode = "0644"
keys = [
  "/containers",
]

reload_cmd = "${SERVICE_HOME}/bin/service-confd-app.sh restart"
EOF

cat << EOF > ${SERVICE_VOLUME}/confd/etc/templates/scheduler.cfg.tmpl
{{range \$i, \$containerName := ls "/containers"}}
SCHEDULER_INSTANCES_{{\$1}}={{getv (printf "/containers/%s/primary_ip" \$containerName)}}
{{ end }}
EOF
