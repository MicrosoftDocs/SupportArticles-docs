---
title: Unable to get log analytics workspace info
description: Provides solutions to an error that occurs when you upgrade or scale a Microsoft Azure Kubernetes Service cluster.
ms.date: 02/20/2023
ms.reviewer: chiragpa, cssakscic, v-weizhu
ms.service: azure-kubernetes-service
---
# Failed to upgrade or scale Azure Kubernetes Service cluster due to missing Log Analytics workspace

This article provides solutions to the "Unable to get log analytics workspace info" error that occurs when you upgrade or scale a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you start, upgrade, or scale an AKS cluster, you may see the following error:

> Failed to save container service '\<container service name>'.  
> Error: Unable to get log analytics workspace info.  
> Resource ID: /subscriptions/\<WorkspaceSubscription>/resourcegroups/defaultresourcegroup-weu/providers/microsoft.operationalinsights/workspaces/defaultworkspace-\<WorkspaceID>-weu.  
> Detail: operationalinsights.WorkspacesClient#GetSharedKeys: Failure responding to request: StatusCode=404 -- Original Error: autorest/azure: Service returned an error. Status=404 Code='ResourceGroupNotFound' Message='Resource group 'defaultresourcegroup-weu' could not be found.'

This issue occurs if you delete the Log Analytics workspace or the resource group where the workspace is located without disabling monitoring on the AKS cluster.

To resolve this issue, use one of the following solutions.

## Solution 1: Recover the Log Analytics workspace

If it has been less than 14 days (the default soft-delete period) since the workspace was deleted, recover the workspace.

> [!NOTE]
>
> - If it hasn't been 14 days, the workspace can't be recreated with the same name. Therefore, the recovery must be done because the AKS control plane finds the workspace based on the resource URI.
> - If your workspace was deleted as part of a resource group delete operation, you must first re-create the resource group with the same name.
> - To perform the workspace recovery, you must have the Contributor permissions to the subscription and resource group where the workspace is located, and the following information is also required:
>     - Subscription ID
>     - Resource Group name
>     - Workspace name
>     - Region

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

2. Re-create the workspace with the workspace resource ID by running the PowerShell cmdlet [New-AzOperationalInsightsWorkspace](/powershell/module/az.operationalinsights/New-AzOperationalInsightsWorkspace).

3. Run the upgrade or scale operation again.

## Solution 2: Disable monitoring on the AKS cluster

If it has been more than 14 days since the workspace was deleted, disable monitoring on the AKS cluster and then run the upgrade or scale operation again.

To disable monitoring on the AKS cluster, run the following command:

```azurecli
az aks disable-addons -a monitoring -g <clusterRG> -n <clusterName>
```

If the same error occurs while disabling the monitoring add-on, recreate the missing Log Analytics workspace and then run the upgrade or scale operation again.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
