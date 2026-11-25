---
title: Troubleshoot AvailabilityZoneNotSupported error code in AKS
description: Learn how to troubleshoot the AvailabilityZoneNotSupported error in AKS cluster creation, verify SKU restrictions, and create your cluster successfully.
ms.date: 11/24/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: marcha, skuchipudi, v-weizhu, kaushika
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Service (AKS) user, I want to troubleshoot cluster or node pool creation that failed with an AvailabilityZoneNotSupported error so that I can deploy a supported configuration.
ai-usage: ai-assisted
---
# Troubleshoot the "AvailabilityZoneNotSupported" error code in Azure Kubernetes Service

## Summary

This article helps you resolve the "AvailabilityZoneNotSupported" error that occurs when you create an Azure Kubernetes Service (AKS) cluster. Learn how to verify SKU restrictions and create your cluster successfully.

## Prerequisites

Ensure you have installed and have access to [Azure CLI](/cli/azure/get-started-with-azure-cli).

## Symptoms

An AKS cluster creation fails in specified availability zones, and you receive an "AvailabilityZoneNotSupported" error with the following message.

> Preflight validation check for resource(s) for container service \<resource-name> in resource group \<resource-group-name> failed. Message: The zone(s) '\<requested-zone>' for resource '\<node-pool-name>' is not supported. The supported zones for location '\<location>' are '\<supported-zones>'.

The error might appear without the preflight validation prefix.

## Cause

The requested zones aren't supported for the node pool's configuration. Possible causes include:

- The VM SKU doesn't support the requested zones in the selected region.
- The subscription has [SKU availability restrictions](/azure/azure-resource-manager/troubleshooting/error-sku-not-available) in the region or in specific zones.
- The selected region doesn't support availability zones for AKS.

The supported zone list in the error applies to the affected SKU and subscription.

## Verify SKU restrictions

Follow these steps to verify SKU restrictions for the requested location and SKU:

1. List the SKU details by running one of the following commands.

    ```azurecli
    az vm list-skus -l <location> --size <SKU> 
    ```
        
    ```azurecli
    az rest --method get \
        --url "https://management.azure.com/subscriptions/<subscription>/providers/Microsoft.Compute/skus?%24filter=location+eq+%27<location>%27&api-version=2022-03-01"  >> availableSkus.txt
    ```
    
    > [!NOTE]
    > Replace `<subscription>`, `<SKU>`, and `<location>` accordingly.
1. Search for the requested SKU in the command output.
1. If you see information like the following, it indicates that the requested SKU has restrictions in some or all zones of your subscription.

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
