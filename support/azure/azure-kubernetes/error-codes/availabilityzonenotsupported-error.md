---
title: Troubleshoot AvailabilityZoneNotSupported Error Code
description: Learn how to troubleshoot the AvailabilityZoneNotSupported error when you try to create an Azure Kubernetes Service cluster in a set of zones.
ms.date: 05/28/2025
ms.reviewer: marcha, skuchipudi, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot an Azure Kubernetes Service cluster create that failed because of a AvailabilityZoneNotSupported error code so that I can create the cluster successfully.
---
# Troubleshoot the AvailabilityZoneNotSupported error code

This article discusses how to identify and resolve the "AvailabilityZoneNotSupported" error that occurs when you try to create an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

Access to [Azure CLI](/cli/azure/get-started-with-azure-cli).

## Symptoms

An AKS cluster creation fails in requested availability zones and you receive an "AvailabilityZoneNotSupported" error with the following message:

> Preflight validation check for resource(s) for container service \<resource-name> in resource group \<resource-group-name> failed. Message: The zone(s) '1' for resource 'agentpoolName' is not supported.The supported zones for location '\<location>' are 'A', 'B'

## Cause

The issue occurs because the requested SKU isn't available in the requested zones or there's a restriction on the Azure subscription.

## Solution 1: Ensure SKU availability in the requested zones

1. Get SKU details by running one of the following commands:

    - List SKU details for the specific location and size:

        ```azurecli
        az vm list-skus -l <location> --size <SKU> 
        ```

    - Retrieve all SKU details for a subscription and location:

        ```azurecli
        az rest --method get \
            --url "https://management.azure.com/subscriptions/<subscription>/providers/Microsoft.Compute/skus?%24filter=location+eq+%27<location>%27&api-version=2022-03-01"  >> availableSkus.txt
        ```

    > [!NOTE]
    > Replace `<subscription>`, `<SKU>` and `<locaiton>` in the commands accordingly.

2. Check the requested SKU information and available zones from the command output.

3. If the requested SKU isn't available in the requested zones, \<what operations should users do?>

If you see the following information in the *availableSkus.txt* file, it indicates that your subscription doesn't have access to zones in the requested region.

```output
"restrictions": [
                {
                    "type": "Zone",
                    "values": [
                        "<zone>"
                    ],
                    "restrictionInfo": {
                        "locations": [
                            "<location>"
                        ],
                        "zones": [
                            "1",
                            "2",
                            "3"
                        ]
                    },
                    "reasonCode": "NotAvailableForSubscription"
                }
            ]
```

In this case, [request access to the restricted region or zone](#solution-2-request-access-to-the-restricted-region-or-zone).

## Solution 2: Request access to the restricted region or zone

If your subscription doesn't have access to zones in the requested region, request access to the region or zone from the [Azure portal](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest) by following the [Azure region access request process](../../general/region-access-request-process.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]