#!/bin/bash
set -e
set -x

echo "Starting Azure Auto Shutdown..."

echo "Fetching VMs with autoShutdown=true tag..."

vms=$(az vm list \
  --query "[?tags.autoShutdown=='true'].id" -o tsv)

for vm in $vms; do
  echo "Stopping VM: $vm"
  az vm deallocate --ids $vm
done

echo "Fetching Web Apps with autoShutdown=true tag..."

apps=$(az webapp list \
  --query "[?tags.autoShutdown=='true'].id" -o tsv)

for app in $apps; do
  echo "Stopping App Service: $app"
  az webapp stop --ids $app
done

echo "Shutdown completed successfully."
