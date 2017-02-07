#!/usr/bin/env bash

MINIO_DATA=${MINIO_DATA:-"${SERVICE_HOME}/data"}


cat << EOF > ${SERVICE_VOLUME}/confd/etc/conf.d/minio-server.cfg.toml
[template]
prefix = "/self/service"
src = "minio-server.cfg.tmpl"
dest = "${SERVICE_HOME}/conf/minio-server.cfg"
owner = "${SERVICE_USER}"
mode = "0644"
keys = [
  "/containers",
]

reload_cmd = "${SERVICE_HOME}/bin/minio-service.sh restart"
EOF

cat << EOF > ${SERVICE_VOLUME}/confd/etc/templates/minio-server.cfg.tmpl
MINIO_DATA=${MINIO_DATA}
MINIO_NUMBER_SERVERS= "{{range \$i := ls "/containers"}}{{(printf "%s" \$i)}}{{end}}"
MINIO_VOLUMES="{{range \$i, \$containerName := ls "/containers"}}http://{{getv (printf "/containers/%s/primary_ip" \$containerName)}}${MINIO_DATA}/export {{end}}"
EOF
