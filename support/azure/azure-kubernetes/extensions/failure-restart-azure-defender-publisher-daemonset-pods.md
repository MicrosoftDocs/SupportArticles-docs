---
title: Pods fail and restart after you enable Defender Profile for AKS
description: Learn how to resolve a scenario in which the azure-defender-publisher DaemonSet pods fail and restart after you enable Defender Profile for AKS.
ms.date: 05/13/2024
author: mosbahmajed
ms.author: momajed
editor: v-jsitser
ms.reviewer: cssakscic, v-rekhanain, v-leedennis
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-problem-resolution
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot failed azure-defender-publisher DaemonSet pods after I enable Defender Profile for Azure Kubernetes Service (AKS) so that I can continue to use Azure Policy Add-on for AKS successfully.
---
# Pods fail and restart after you enable Defender Profile for AKS

This article discusses how to troubleshoot a scenario in which the `azure-defender-publisher` DaemonSet pods fail and then restart after you enable Defender Profile for Microsoft Azure Kubernetes Service (AKS).

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)
- [curl](https://curl.se)

## Symptoms

Consider the following scenario:

- You're using the Azure Policy Add-on for AKS.
- You enable Defender Profile for AKS per the [Azure Advisor](/azure/advisor/advisor-overview) recommendation.

In this scenario, the `azure-defender-publisher` DaemonSet pods continually restart.

## Cause

This problem might be caused by authentication issues or a misconfiguration.

## Workaround

Disable the Azure Defender profile by following these steps:

1. Obtain the access token for your account by running the following [az account get-access-token](/cli/azure/account#az-account-get-access-token) command:

   ```azurecli
   az account get-access-token --query 'accessToken' --output tsv
   ```

   > [!NOTE]
   > Save the access token from the output to use for commands in the following steps. The access token is an encoded string that can exceed 2,000 characters.

1. To determine whether the Azure Defender profile is enabled on your cluster, invoke the following REST API GET method by running the following curl command. Replace the `<access-token>` placeholder in the `Authorization` header with the access token from the previous step, and then replace the placeholders in the URI that represent the Azure subscription GUID, resource group name, and cluster name:

   ```bash
   curl -X GET \
       -H "Authorization: Bearer <access-token>" \
       -H "Content-Type: application/json" \
       https://management.azure.com/subscriptions/<subscription-guid>/resourceGroups/<resource-group-name>/providers/Microsoft.ContainerService/managedClusters/<cluster-name>?api-version=2020-04-01
   ```

   If the Azure Defender profile is enabled on your cluster, the command returns JSON output that resembles the following snippet:

   ```json
   "securityProfile": {
    "azureDefender": {
     "enabled": true,
     "logAnalyticsWorkspaceResourceId": "/subscriptions/<subscription-guid>/resourceGroups/<resource-group-name>/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-<guid>-<region>"
    }
   ```

1. Remove the Azure Defender profile by invoking the following REST API PUT method through the curl command. This command resembles the previous command, except that you specify `-X PUT` instead of `-X GET` for the method request, and you specify a `-d` parameter to pass data to the request. The required placeholder value replacements are identical to the previous command.

   ```bash
   curl -X PUT \
       -H "Authorization: Bearer <access-token>" \
       -H 'Content-Type: application/json' \
       -d '{"location": "northeurope", "properties": {"securityProfile": {"azureDefender": {"enabled": false }}}}' \
       https://management.azure.com/subscriptions/<subscription-guid>/resourceGroups/<resource-group-name>/providers/Microsoft.ContainerService/managedClusters/<cluster-name>?api-version=2020-04-01
   ```

   If the command runs as expected, the result shows your cluster in the `Updating` state, and the Azure Defender profile is disabled.

   ```json
   {
    "id": "",
    "location": "northeurope",
    "name": "<cluster-name>",
    "type: "Microsoft.ContainerService/ManagedClusters",
    "properties": {
     "provisioningState": "Updating",
     "powerState": {
      "code": "Running"
     },

   ...

    },
    "securityProfile": {
     "azureDefender": {
      "enabled": false
     }
    }
   }
   ```

After you disable the Azure Defender profile, check whether the `azure-defender-publisher` DaemonSet pods continue their previous cycle of failing and restarting.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
