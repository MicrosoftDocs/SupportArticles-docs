---
title: Azure Kubernetes Service cluster/node is in a failed state
description: Troubleshoot an issue where an Azure Kubernetes Service (AKS) cluster/node is in a failed state.
ms.date: 03/19/2024
ms.reviewer: chiragpa, nickoman, v-weizhu, v-six, aritraghosh
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why attach my node virtual machine is in a failed state so that I can successfully use my Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot Azure Kubernetes Service cluster/node in a failed state

This article discusses how to troubleshoot a Microsoft Azure Kubernetes Service (AKS) cluster/node that's entered a failed state.

## Basic troubleshooting for common errors that cause a failed cluster/node

The following table outlines some common errors that can cause a cluster or node to enter a failed state, and the basic troubleshooting methods to resolve them.

|Errors|Basic troubleshooting methods|
|---|---|
|OutboundConnFailVMExtensionError|This error indicates that the VM extension fails to install or update due to a lack of outbound connectivity. To troubleshoot this error, check the network security group (NSG) rules and the firewall settings of the VM or the VM scale set. Make sure that the VM or the VM scale set can access these endpoints: `https://aka.ms/aks/outbound`, `https://aka.ms/aks/ssh`, `https://aka.ms/aks/agent`, and `https://aka.ms/aks/containerinsights`.|
|Drain error|This error indicates that the node fails to drain before the upgrade operation. To troubleshoot this error, check the pod status and events on the node by using the kubectl commands: `kubectl get pods --all-namespaces -o wide` and `kubectl describe pod <pod-name> -n <namespace>`. Look for any pods that are stuck in terminating or unknown state, or have any errors or warnings in the events. You may need to force to delete the pods or restart the kubelet service on the node.|
|SubscriptionNotRegistered error|This error indicates that the subscription isn't registered to use the AKS resource provider. To troubleshoot this error, register the subscription by using the `az provider register --namespace Microsoft.ContainerService` command.|
|RequestDisallowedByPolicy error|This error indicates that the operation is blocked by a policy that's applied to the subscription or resource group. To troubleshoot this error, review the policy details and policy assignment scope. To allow the operation, you may need to modify or exclude the policy.|
|QuotaExceeded error|This error indicates that the operation exceeds the quota limit for a resource type or a region. To troubleshoot this error, check the current quota usage and quota limit for the resource type or the region by using the Azure portal, Azure CLI, or Azure PowerShell. You may need to delete some unused resources or request a quota increase.|
|PublicIPCountLimitReached error| This error indicates that the operation reaches the maximum number of public IP addresses that can be created in the subscription or region. To troubleshoot this error, check the current public IP address usage and the public IP address limit for the subscription or region by using the Azure portal, Azure CLI, or Azure PowerShell. YOu may need to delete some unused public IP addresses or request a public IP address limit increase.|
|OverconstrainedAllocationRequest error|This error indicates that the operation fails to allocate the requested VM size in the region. To troubleshoot this error, check the availability of the VM size in the region by using the Azure portal, Azure CLI, or Azure PowerShell. You may need to choose a different VM size or a different region.|
|ReadOnlyDisabledSubscription error|This error indicates that the subscription is currently disabled and set to read-only. To troubleshoot this error, review and adjust the subscription permissions, as the subscription may have been suspended due to billing issues, expired credit, or policy violations.|


## Basic troubleshooting for other possible issues that cause a failed cluster/node

|Issues|Basic troubleshooting methods|
|---|---|
|The subnet size is too small|Because the subnet doesn't have enough space for the needed number of nodes, the operation could not create or update the cluster. To fix this issue, delete the node pool and make a new one with a greater subnet size by using the Azure portal, Azure CLI, or Azure PowerShell.|
|The virtual network is blocked|Because the firewall or a custom DNS setting blocks the outbound connections from the nodes, the operation couldn't communitcate with the cluster API server or the Kubernetes control plane. To fix this issue, allow the node's traffic on the firewall and set up the DNS resolution to Azure by using the Azure portal, Azure CLI, or Azure PowerShell.|
|PDB problems|Because a pod disruption budget (PDB) stopped the removal of one or more pods, the operation couldn't update the cluster. A PDB is a resource that limits how many pods can be voluntarily terminated in a certain time period. To fix this issue, remove the PDB temporarily, reconcile the cluster, and add the PDB again by using the kubectl command-line tool.|
|Infrastructure issues|Because of an internal issue with the Azure Resource Manager (ARM) service that manages resources in Azure, the operation could not update the cluster. To fix this issue, do an agent pool reconcile for each node pool and a reconcile for the managed cluster by using the Azure CLI or Azure PowerShell.|
|API server errors|The operation could not reach the cluster API server or the Kubernetes control plane because of an outage or a bug. To fix this issue, report it to the AKS support team and provide the relevant logs and diagnostics information. You can use the Azure portal, Azure CLI, or Azure PowerShell to get the logs and diagnostics information.|

## Scenario 1: Cluster is in a failed state

To resolve this issue, get the operation that causes the failure and figure out the error. Here are two common operation failures that can result in a failed cluster:

- Cluster creation failed
- Cluster upgrade failed

If a recently created or upgraded cluster is in a failed state, use the following methods to troubleshoot the failure:

- Examine the [activity logs](troubleshoot-aks-cluster-creation-issues#view-error-details-in-the-azure-portal.md) to identify the root cause of the failure.

    You can view the activity logs by using [the Azure portal](#view-the-activity-logs-for-a-failed-cluster-using-the-azure-portal), [Azure CLI](#view-the-activity-logs-for-a-failed-cluster-using-the-azure-cli), or Azure PowerShell.
 
    The activity logs can show you the error code and message associated with the failure. For more information about specific errors, see the [Basic troubleshooting for common errors that cause a failed cluster](#basic-troubleshooting-for-common-errors) section.

- [Use the AKS Diagnose and Solve Problems feature](#use-aks-diagnose-and-solve-problems-feature-for-a-failed-cluster) to troubleshoot and resolve common issues.

    > [!NOTE]
    > This feature is only available in the Azure portal and the Azure CLI.

### View the activity logs for a failed cluster using the Azure portal

To view the activity logs for a failed cluster from the Azure portal, follow these steps:

1. In the Azure portal, go to the **Resource groups** page and select the resource group that contains your cluster.
2. On the **Overview** page, select the cluster name from the list of resources.
3. On the cluster page, select **Activity log** from the left menu.
4. On the **Activity log** page, you can filter the events by **Status**, **Timespan**, **Event initiated by**, and **Event category**. For example, you can select **Failed** from the **Status** drop-down list to see only the failed events.

    :::image type="content" source="media/cluster-node-virtual-machine-failed-state/filter-events.png" alt-text="Screenshot that shows how to filter the events on the 'Activity log' page." border="false":::

5. To check the details of an event, select the event name from the list. A new pane will open with the event summary, properties, and JSON data. You can also download the JSON data as a file.
6. To check the error code and message associated with the event, scroll down to the **Status** section in the event summary. You can also find the error information in the properties and JSON data sections.

### View the activity logs for a failed cluster using the Azure CLI

If you prefer to use Azure CLI to view the activity logs for a failed cluster, follow these steps:

1. Install Azure CLI on your machine and log in with your Azure account.
2. Use the `az group list` command to list the resource groups in your subscription and find the name of the resource group that contains your cluster.
3. Use the `az resource list` command with the `--resource-group` parameter to list the resources in the resource group and find the name of the cluster.
4. Use the `az monitor activity-log list` command with the `--resource-group` and `--resource` parameters to list the activity logs for the cluster. You can also use the `--status`, `--start-time`, `--end-time`, `--caller`, and `--filter` parameters to filter the events by different criterias. For example, you can use `--status Failed` to see only the failed events.
5. Use the `az monitor activity-log show` command with the `--resource-group`, `--resource`, and `--event-id` parameters to show the details of a specific event. You can find the event ID from the output of the previous command. The output will include the event summary, properties, and JSON data. You can also use the `--output` parameter to change the format of the output.
6. To see the error code and message associated with the event, look for the `statusMessage` field in the command output. You can also find the error information in the properties and JSON data sections.

  :::image type="content" source="media/cluster-node-virtual-machine-failed-state/json-data.png" alt-text="Screenshot that shows JSON data." border="false":::

### Use AKS Diagnose and Solve Problems feature for a failed cluster 

In the Azure portal, navigate to your AKS cluster resource and select **Diagnose and solve problems** from the left menu. You will see a list of categories and scenarios that you can select to run diagnostic checks and get recommended solutions.

In the Azure CLI, use the `az aks collect` command with the `--name` and `--resource-group` parameters to collect diagnostic data from your cluster nodes. You can also use the `--storage-account` and `--sas-token` parameters to specify an Azure Storage account where the data will be uploaded. The output will include a link to the **Diagnose and Solve Problems** portal where you can view the results and suggested actions.

In the **Diagnose and Solve Problems** portal, you can select **Cluster Issues** as the category. If any issues are detected, you will see a list of possible solutions that you can follow to fix them.

 :::image type="content" source="media/cluster-node-virtual-machine-failed-state/diagnose-and-solve-problems-solutions.png" alt-text="Screenshot that shows possible solutions in the 'Diagnose and Solve Problems' portal." border="false":::

## Scenario 2: Node is in a failed state

In some rare cases, an Azure Disk detach operation may partially fail, which leaves the node virtual machine (VM) in a failed state.

To resolve this issue, manually update the VM status by using one of the following methods:

- For a cluster that's based on an availability set, run the following [az vm update](/cli/azure/vm#az-vm-update) command:

    ```azurecli
    az vm update --resource-group <resource-group-name> --name <vm-name>
    ```

- For a cluster that's based on a virtual machine scale set, run the following [az vmss update-instances](/cli/azure/vmss#az-vmss-update-instances) command:

    ```azurecli
    az vmss update-instances --resource-group <resource-group-name> --name <scale-set-name> --instance-id <vm-or-scale-set-id>
    ``` 

## Scenario 3: Nodepool is in failed state

When the VM scale set or availability set that backs the nodepool encounters an error during provisioning, scaling, or updating, this issue can happen. This issue can be due to insufficient capacity, quota limits, network issues, policy violations, resource locks, or other factors that prevent the VMs from being allocated or configured properly.

To troubleshoot this issue, follow these steps:

1. Check the status of the nodepool using the `az aks nodepool show` command. If the provisioning state is `Failed`, you can see the error message and code in the output.
2. Check the status of the VM scale set or availability set using the `az vmss show` or `az vm availability-set show` command. If the provisioning state is `Failed`, you can see the error message and code in the output.
3. Check the status of the individual VMs in the nodepool using the `az vmss list-instances` or `az vm list `command. If any of the VMs are in an `Failed` or `Unhealthy` state, you can see the error message and code in the output.
4. Check the activity logs and diagnostic settings of the VM scale set or availability set to see if there are any events or alerts that indicate the cause of the failure. You can use the Azure portal, the Azure CLI, or the Azure Monitor API to access the activity logs and diagnostic settings.
5. Check the quota and capacity of the region and subscription where the nodepool is deployed. You can use the `az vm list-usage` command or the Azure portal to check the quota and capacity. If you are reaching the limit of your quota or capacity, you can request an increase or delete some unused resources.
6. Check the policy and role assignments of the nodepool. You can use the `az policy` and `az role` commands or the Azure portal to check the policy definitions, assignments, compliance, and exemptions. You can also check the role assignments and permissions of the nodepool using the `az role assignment` command or the Azure portal.
7. Check the resource locks of the nodepool. You can use the `az lock` command or the Azure portal to check the lock level, scope, and notes. You can also delete or update the lock if needed.

### Check Provisioning State

Show the provisioning state for the cluster and agent pool:

## Additional logs and diagnostics tools

If the previous troubleshooting methods don't resolve your issue, you can use the following logs and diagnostics tools to collect more information and identify the root cause:

- Azure Monitor for containers:

    This service collects and analyzes the metrics and logs from the AKS cluster and the nodes. You can use Azure Monitor for containers to monitor the cluster and node health, performance, and availability. You can also use Azure Monitor for containers to view the container logs, the kubelet logs, and the node boot diagnostics logs.

- [AKS Periscope](https://github.com/Azure/aks-periscope)

    This tool collects node and pod logs, network information, and cluster configuration from the AKS cluster and uploads them to an Azure storage account. You can use AKS Periscope to troubleshoot common cluster issues, such as DNS resolution, network connectivity, and node status. You can also use AKS Periscope to generate a support request with the collected logs. 

- AKS Diagnostics

    This tool runs a series of checks on the AKS cluster and the nodes and provides recommendations and remediation steps for common issues. You can use AKS Diagnostics to troubleshoot issues related to cluster creation, upgrade, scaling, networking, storage, and security. You can also use AKS Diagnostics to generate a support request with the diagnostic results. 

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]