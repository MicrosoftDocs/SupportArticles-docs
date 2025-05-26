---
title: Troubleshoot AvailabilityZoneNotSupported Error Code
description: Learn how to troubleshoot the AvailabilityZoneNotSupported error when you try to create an Azure Kubernetes Service cluster in a set of zones.
ms.date: 05/26/2025
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

An AKS cluster creation fails in the requested availability zone and you receive an "AvailabilityZoneNotSupported" error.

Here's an example of the error message:

> Preflight validation check for resource(s) for container service \<resource-name> in resource group \<resource-group-name> failed. Message: The zone(s) '1' for resource 'agentpoolName' is not supported.The supported zones for location '\<location>' are 'A', 'B'

## Cause

The issue occurs if the requested SKU isn't available in the requested zone or there's restriction on the Azure subscription.

## Solution

To resolve this issue, verify if the requested SKU isn't available in the requested zone by running the following commands:

```azurecli
az vm list-skus -l <location> --size <SKU> 
```

```azurecli
az rest --method get \
    --url "https://management.azure.com/subscriptions/<subscription>/providers/Microsoft.Compute/skus?%24filter=location+eq+%27<location>%27&api-version=2022-03-01"  >> availableSkus.txt
```

> [!NOTE]
> Replace `<subscription>` and `<locaiton>` in the URL accordingly.

Then, search for the requested SKU information in the command output. If you see the following information, it indicates that your subscription doesn't have access to zones in the requested region.

```output
"restrictions": [
                {
                    "type": "Zone",
                    "values": [
                        "xxxxx"
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

In this case, request access to the region or zone from the [Azure portal](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest) by following instructions in [Azure region access request process](../general/region-access-request-process.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]