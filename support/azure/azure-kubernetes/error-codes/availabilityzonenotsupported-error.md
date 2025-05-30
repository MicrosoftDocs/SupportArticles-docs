---
title: Troubleshoot AvailabilityZoneNotSupported Error Code
description: Learn how to troubleshoot the AvailabilityZoneNotSupported error when you try to create an Azure Kubernetes Service cluster in a set of zones.
ms.date: 05/30/2025
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

The issue occurs because the requested SKU has restrictions in some or all zones for your subscription. To verify the restrictions, go to the [Verify SKU restrictions](#verify-sku-restrictions) section.

## Solution

To resolve this issue, request access to the specified region or zone by following the [Azure region access request process](../../general/region-access-request-process.md).

## Verify SKU restrictions

1. List SKU details by running one of the following commands:

    ```azurecli
    az vm list-skus -l <location> --size <SKU> 
    ```
        
    ```azurecli
    az rest --method get \
        --url "https://management.azure.com/subscriptions/<subscription>/providers/Microsoft.Compute/skus?%24filter=location+eq+%27<location>%27&api-version=2022-03-01"  >> availableSkus.txt
    ```
    
    > [!NOTE]
    > Replace `<subscription>`, <SKU>, and `<locaiton>` accordingly.
2. Search for the requested SKU from the command output.
3. If you see the information like the following, it indicates that the requested SKU has restrictions in some or all zones for your subscription:

    ```json
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
[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
