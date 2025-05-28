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

An AKS cluster creation fails in specified availability zones and you receive an "AvailabilityZoneNotSupported" error with the following message:

> Preflight validation check for resource(s) for container service \<resource-name> in resource group \<resource-group-name> failed. Message: The zone(s) '1' for resource 'agentpoolName' is not supported.The supported zones for location '\<location>' are 'A', 'B'

## Cause

The issue occurs because the requested SKU is unavailable in the specified zones or is restricted by the Azure subscription.

To determine the root cause, follow these steps:

1. Verify if the requested SKU isn't available in the specified zones:

        ```azurecli
        az vm list-skus -l <location> --size <SKU> 
        ```

    > [!NOTE]
    > Replace `<SKU>` and `<locaiton>` accordingly.

2. Verify if the requested SKU is restricted by your subscription:

        ```azurecli
        az rest --method get \
            --url "https://management.azure.com/subscriptions/<subscription>/providers/Microsoft.Compute/skus?%24filter=location+eq+%27<location>%27&api-version=2022-03-01"  >> availableSkus.txt
        ```

    > [!NOTE]
    > Replace `<subscription>` and `<locaiton>` accordingly.

3. Search for the requested SKU in the *availableSkus.txt* file. If you see the lines like the following, it indicates that your subscription doesn't have access to zones in the specified location:

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

## Solution: Request access to the specified zone

To resolve this issue, request access to the specified region or zone by following the [Azure region access request process](../../general/region-access-request-process.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]