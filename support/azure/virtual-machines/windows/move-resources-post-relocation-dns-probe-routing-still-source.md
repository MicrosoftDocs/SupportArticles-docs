---
title: Azure region relocation succeeds but DNS, health probes, or front-end routing still point to the source environment
description: Troubleshoot DNS, health probe, and front-end routing failures after Azure region relocation. Follow these steps to route traffic to the destination environment.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/14/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure region relocation succeeds but DNS, health probes, or front-end routing still point to the source environment

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

Use this article to troubleshoot post-relocation traffic failures if Domain Name System (DNS), health probes, or front-end routing still reference the source environment after an Azure region relocation. Follow these steps to restore correct traffic routing to your destination environment.

## Symptoms

An Azure region relocation process finishes, but traffic still goes to the original source footprint or fails because probes and DNS weren't updated.

## Cause

The cutover wasn't fully completed at the front-end layer. Therefore, DNS, load balancer probes, application gateway references, and external traffic managers still reference the source topology.

## Resolution

Use this post-relocation checklist to make sure that all traffic is correctly routed to the destination environment:

### Step 1: Verify DNS resolution

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to verify DNS resolution for your services.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the DNS zone for your domain.
1. Verify that A records, canonical name (CNAME) records, and other entries point to the destination IP addresses.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Resolve-DnsName -Name "<your-service-fqdn>" -Type A
```

To check Azure DNS zone records, run the following command.

```azurepowershell
Get-AzDnsRecordSet -ResourceGroupName "<resource-group-name>" -ZoneName "<zone-name>" |
  Format-Table Name, RecordType, @{N='Records';E={$_.Records -join ', '}}
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az network dns record-set list \
  --resource-group <resource-group-name> \
  --zone-name <zone-name> \
  --output table
```

---

### Step 2: Verify load balancer, gateway, and probe targets

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the load balancer or application gateway in the destination.
1. Verify that front-end IP configurations and health probes reference the correct destination resources.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzLoadBalancer -ResourceGroupName "<resource-group-name>" |
  Select-Object Name, @{N='FrontendIPs';E={$_.FrontendIpConfigurations.Name -join ', '}} |
  Format-List
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az network lb show \
  --resource-group <resource-group-name> \
  --name <lb-name> \
  --query "{frontendIps:frontendIpConfigurations[].name, probes:probes[].name}" \
  --output json
```

---

### Step 3: Update cutover references to the destination environment

Update any remaining references to source resources, including Azure Traffic Manager profiles, content delivery network (CDN) endpoints, and external monitoring systems.

### Step 4: Re-test end-to-end user traffic

Ensure that end-to-end user traffic is correctly routed to the destination environment.

## References

- [Azure virtual machine region relocation changes public IP behavior and the original public IP isn't retained](move-resources-region-relocation-public-ip-not-retained.md)
- [Azure virtual machine move succeeded but the VM is up and the workload is still broken](move-resources-post-move-vm-up-workload-broken.md)
- [Move Azure resources across resource groups, subscriptions, or regions](/azure/azure-resource-manager/management/move-resources-overview)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
