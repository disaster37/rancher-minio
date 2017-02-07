#!/usr/bin/env bash

MINIO_DISKS=${MINIO_DISKS:-"${SERVICE_HOME}/data/disk0"}


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
MINIO_DISKS=${MINIO_DISKS}
{{ $length := len "/containers"}} {{if eq $length 1}}
MINIO_VOLUMES=${MINIO_DISKS}
{{ else }}
MINIO_VOLUMES="{{range \$i, \$containerName := ls "/containers"}}http://{{getv (printf "/containers/%s/primary_ip" \$containerName)}}${MINIO_DATA}/export {{end}}"
{{ end }}
EOF
