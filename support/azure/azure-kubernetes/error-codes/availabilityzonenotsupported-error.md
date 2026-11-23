---
title: Troubleshoot AvailabilityZoneNotSupported error code in AKS
description: Troubleshoot the AvailabilityZoneNotSupported error when you create an AKS cluster or node pool. Identify SKU and zone restrictions and choose a supported configuration.
ms.date: 11/20/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: marcha, skuchipudi, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Service (AKS) user, I want to troubleshoot cluster or node pool creation that failed with an AvailabilityZoneNotSupported error so that I can deploy a supported configuration.
ai-usage: ai-assisted
---
# Troubleshoot the "AvailabilityZoneNotSupported" error code in Azure Kubernetes Service

## Summary

This article helps you resolve the "AvailabilityZoneNotSupported" error that occurs when you create an Azure Kubernetes Service (AKS) cluster or add a node pool. Identify SKU and zone restrictions so you can deploy a supported configuration.

## Symptoms

An AKS cluster or node pool creation fails in the specified availability zones, and you receive an "AvailabilityZoneNotSupported" error with a message similar to the following example.

> Preflight validation check for resource(s) for container service \<resource-name> in resource group \<resource-group-name> failed. Message: The zone(s) '\<requested-zone>' for resource '\<node-pool-name>' is not supported. The supported zones for location '\<location>' are '\<supported-zones>'.

The error might appear without the preflight validation prefix.

## Cause

The requested zones aren't supported for the node pool's configuration. Possible causes include:

- The VM SKU doesn't support the requested zones in the selected region.
- The subscription has [SKU availability restrictions](/azure/azure-resource-manager/troubleshooting/error-sku-not-available) in the region or in specific zones.
- The selected region doesn't support availability zones for AKS.

The supported zone list in the error applies to the affected SKU and subscription.

## Verify SKU restrictions

The following steps help you verify whether the requested zones are supported for the node pool's VM SKU and your subscription.

### List the SKU and its restrictions

Use [Azure CLI](/cli/azure/get-started-with-azure-cli) to list the SKU's zones and restrictions. Replace the placeholders with the affected subscription, region, and node pool VM size.

```azurecli
az vm list-skus --subscription <subscription-id> -l <location> --size <SKU> --resource-type virtualMachines --all --output table
```

The `--all` parameter includes SKUs unavailable to the subscription. Because `--size` accepts partial names, review **Zones** and **Restrictions** for the exact SKU name.

For details, filter JSON output to the exact SKU:

```azurecli
az vm list-skus --subscription <subscription-id> -l <location> --size <SKU> --resource-type virtualMachines --all --query "[?name=='<SKU>'].{name:name,locationInfo:locationInfo,restrictions:restrictions}" --output json
```

The following example shows the relevant fields for a SKU that supports zones `1`, `2`, and `3` in `southeastasia`, but has a subscription restriction on zone `2`:

```json
[
  {
    "name": "Standard_D2s_v5",
    "locationInfo": [
      {
        "location": "southeastasia",
        "zones": [
          "1",
          "2",
          "3"
        ]
      }
    ],
    "restrictions": [
      {
        "reasonCode": "NotAvailableForSubscription",
        "restrictionInfo": {
          "locations": [
            "southeastasia"
          ],
          "zones": [
            "2"
          ]
        },
        "type": "Zone",
        "values": [
          "southeastasia"
        ]
      }
    ]
  }
]
```

### Interpret the results

Compare the requested zones with the SKU's **Zones** and **Restrictions**:

| Query result | Meaning |
|---|---|
| A `Zone` restriction includes the target region and a requested zone | The subscription can't use this SKU in that zone. |
| A `Location` restriction includes the target region | The subscription can't use this SKU in that region, regardless of zone. |
| A requested zone isn't listed in `locationInfo.zones` for the target region | The SKU doesn't advertise support for that zone. |
| No restriction applies to the target region and requested zones | No matching subscription restriction is reported; check zone support separately. |
| No exact SKU match is returned, even with `--all` | The query doesn't establish SKU availability or the cause of the error. |

In the preceding table, the SKU lists zones `1`, `2`, and `3`, but `restrictionInfo.zones` excludes zone `2` for this subscription. The `values` field contains the region name, not the zone number.

> [!NOTE]
> For `AllocationFailed` or `ZonalAllocationFailed`, see [allocation failure guidance](zonalallocation-allocationfailed-error.md). For `QuotaExceeded`, see [quota error guidance](quota-exceeded-error.md).

## Solution

Choose an option that meets your placement requirements:

- **Use supported zones.** See [Configure availability zones in AKS](/azure/aks/reliability-availability-zones-configure) for configuration steps and limitations.
- **Choose another SKU, or another region for a new cluster.** See [Resolve errors for SKU not available](/azure/azure-resource-manager/troubleshooting/error-sku-not-available#solution) and [AKS VM size and region requirements](/azure/aks/quotas-skus-regions).
- **Request access if the required SKU is restricted for your subscription.** Follow the [SKU request guidance](/azure/azure-resource-manager/troubleshooting/error-sku-not-available#solution) or, for region access, the [Azure region access request process](/troubleshoot/azure/general/region-access-request-process). A quota increase alone doesn't resolve a SKU or zone access restriction.

Retry the original deployment with the supported configuration, preserving other settings.

## Verify the deployment

Check the cluster and affected node pool:

```azurecli
az aks show --subscription <subscription-id> --resource-group <resource-group-name> --name <cluster-name> --query "{state:provisioningState,location:location}" --output table
```

```azurecli
az aks nodepool show --subscription <subscription-id> --resource-group <resource-group-name> --cluster-name <cluster-name> --name <node-pool-name> --query "{state:provisioningState,vmSize:vmSize,zones:availabilityZones,count:count}" --output json
```

Confirm that the provisioning state is `Succeeded` and that the deployed VM size, region, and availability zones match the intended configuration.
