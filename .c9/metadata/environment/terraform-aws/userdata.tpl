{"filter":false,"title":"userdata.tpl","tooltip":"/terraform-aws/userdata.tpl","undoManager":{"mark":0,"position":0,"stack":[[{"start":{"row":0,"column":0},"end":{"row":6,"column":23},"action":"insert","lines":["#!/bin/bash","sudo hostnamectl set-hostname ${nodename} &&","curl -sfL https://get.k3s.io | sh -s - server \\","--datastore-endpoint=\"mysql://${dbuser}:${dbpass}@tcp(${db_endpoint})/${dbname}\" \\","--write-kubeconfig-mode 644 \\","--tls-san=$(curl http://169.254.169.254/latest/meta-data/public-ipv4) \\","--token=\"th1s1sat0k3n!\""],"id":1}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":2,"column":42},"end":{"row":2,"column":42},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1673768647848,"hash":"ea6c806ab5e7ce96e74815e0c9f9121295e12483"}