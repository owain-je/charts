#!/bin/bash
helm install piui --name t3 \
 --set piapp.mysql.user=layer4user \
 --set piapp.mysql.password=layer4password \
 --set piapp.mysql.database=layer4db \
 --set piapp.mysql.server=localhost \
 --set piapp.piapp-schema.mysql.mysqlUser=layer4user  \
 --set piapp.piapp-schema.mysql.mysqlPassword=layer4password  \
 --set piapp.piapp-schema.mysql.mysqlDatabase=layer4db \
 --set piapp.service.name=dave \
 --set service.type=NodePort
# --dry-run \
# --debug \
