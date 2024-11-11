# setup.sh
#!/bin/bash
curl -sfL https://get.k3s.io | sh -

sudo echo /var/lib/rancher/k3s/server/node-token