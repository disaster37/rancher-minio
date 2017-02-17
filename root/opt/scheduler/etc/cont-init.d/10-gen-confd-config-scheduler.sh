#!/usr/bin/with-contenv sh

exec cat << EOF > ${CONFD_HOME}/etc/conf.d/minio-run.toml
[template]
prefix = "/self/service"
src = "scheduler.cfg.tmpl"
dest = "${SERVICE_SCHEDULER}/conf/scheduler.cfg"
mode = "0644"
keys = [
  "/containers",
]
reload_cmd = "s6-svscanctl -t /var/run/s6/services"
EOF
