#!/bin/bash
set -ex
B64_CLUSTER_CA=${b64_cluster_ca}
API_SERVER_URL=${api_server_url}
# Bootstrap the EKS worker node
/etc/eks/bootstrap.sh ${cluster_name} \
  --kubelet-extra-args "--node-labels=eks.amazonaws.com/nodegroup-image=${image_id},eks.amazonaws.com/capacityType=ON_DEMAND,eks.amazonaws.com/nodegroup=${node_group_name} --max-pods=${max_pods}" \
  --b64-cluster-ca $B64_CLUSTER_CA \
  --apiserver-endpoint $API_SERVER_URL \
  --use-max-pods false