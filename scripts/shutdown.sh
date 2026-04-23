#!/bin/bash

echo "Stopping all VMs..."

# Stop all running VMs
for vm in $(az vm list --query "[?powerState=='VM running'].id" -o tsv); do
  az vm deallocate --ids $vm
done

echo "Stopping App Services..."

# Stop all Web Apps
for app in $(az webapp list --query "[].id" -o tsv); do
  az webapp stop --ids $app
done

echo "Scaling AKS node pools to 0..."

# Optional: AKS
# az aks nodepool scale \
#   --resource-group <RG> \
#   --cluster-name <CLUSTER> \
#   --name <NODEPOOL> \
#   --node-count 0

echo "Shutdown completed."
