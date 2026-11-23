---
title: Troubleshoot Unable to get log analytics workspace info error in AKS
description: Learn how to resolve the "Unable to get log analytics workspace info" error when you start, upgrade, or scale an Azure Kubernetes Service (AKS) cluster.
ms.date: 11/10/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, cssakscic, v-weizhu, kaushika
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot the "Unable to get log analytics workspace info" error in AKS

## Summary

This article helps you resolve the "Unable to get log analytics workspace info" error that occurs when you start, upgrade, or scale an Azure Kubernetes Service (AKS) cluster. It explains how to recover the deleted Log Analytics workspace or disable monitoring so that your cluster operations succeed.

## Symptoms

When you start, upgrade, or scale an AKS cluster, you might see one of the following errors.

> Failed to save container service '\<container service name>'.  
> Error: Unable to get log analytics workspace info.  
> Resource ID: /subscriptions/\<WorkspaceSubscription>/resourcegroups/defaultresourcegroup-weu/providers/microsoft.operationalinsights/workspaces/defaultworkspace-\<WorkspaceID>-weu.  
> Detail: operationalinsights.WorkspacesClient#GetSharedKeys: Failure responding to request: StatusCode=404 -- Original Error: autorest/azure: Service returned an error. Status=404 Code='ResourceGroupNotFound' Message='Resource group 'defaultresourcegroup-weu' could not be found.'

or

> Error: Unable to retrieve log analytics workspace. If resource is intentionally deleted to stop monitoring, please also disable monitoring addon by following doc: https://aka.ms/aks-disable-monitoring-addon. If resource is deleted by mistake, please re-create it by following doc: https://aka.ms/new-log-analytics, and enable new workspace resource id by following doc: https://aka.ms/aks-enable-addons.
> Resource ID: /subscriptions/\<WorkspaceSubscription>/resourcegroups/defaultresourcegroup-weu/providers/microsoft.operationalinsights/workspaces/defaultworkspace-\<WorkspaceID>-weu.  
> Detail: operationalinsights.WorkspacesClient#GetSharedKeys: Failure responding to request: StatusCode=404 -- Original Error: autorest/azure: Service returned an error. Status=404 Code='ResourceGroupNotFound' Message='Resource group 'defaultresourcegroup-weu' could not be found.'

This issue occurs if you delete the Log Analytics workspace or the resource group where the workspace is located without disabling monitoring on the AKS cluster.

To resolve this issue, use one of the following solutions.

## Solution 1: Recover the deleted Log Analytics workspace

If it's been less than 14 days (the default soft-delete period) since you deleted the workspace, recover the workspace.

> [!NOTE]
>
> - If it's been 14 days, you can't recreate the workspace with the same name. Therefore, you must recover the workspace because the AKS control plane finds the workspace based on the resource URI.
> - If you deleted your workspace as part of a resource group delete operation, you must first re-create the resource group with the same name.
> - To perform the workspace recovery, you must have the Contributor permissions to the subscription and resource group where the workspace is located. You also need the following information:
>     - Subscription ID
>     - Resource Group name
>     - Workspace name
>     - Region

Follow these steps:

1. Get the workspace resource ID by running the Azure CLI command `az aks show -g <clusterRG> -n <clusterName>`.

    Here's an example output of the command:

    ```output
    root@AKS# az aks show -g aksrg -n testcluster1
    { "aadProfile": null,
    "addonProfiles": { 
        "httpapplicationrouting": {
            "config": {}, "enabled": false },
            "omsagent": {
               "config": {
                  "logAnalyticsWorkspaceResourceID": "/subscriptions/<WorkspaceSubscription>/resourceGroups/defaultresourcegroup-eus/providers/Microsoft.OperationalInsights/workspaces/defaultworkspace-<WorkspaceID>-eus"
                }, 
                "enabled": true
    ```

1. Re-create the workspace with the workspace resource ID by running the PowerShell cmdlet [New-AzOperationalInsightsWorkspace](/powershell/module/az.operationalinsights/New-AzOperationalInsightsWorkspace).
1. Run the upgrade or scale operation again.

## Solution 2: Disable the monitoring add-on on the AKS cluster

If it's been more than 14 days since you deleted the workspace, disable monitoring on the AKS cluster and then run the upgrade or scale operation again.

To disable monitoring on the AKS cluster, run the following command.

```azurecli
az aks disable-addons -a monitoring -g <clusterRG> -n <clusterName>
```

If the same error occurs while disabling the monitoring add-on, recreate the missing Log Analytics workspace and then run the upgrade or scale operation again.