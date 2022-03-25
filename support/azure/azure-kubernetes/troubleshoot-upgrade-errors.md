---
title: Unable to upgrade Azure Kubernetes Service cluster
description: This article helps you troubleshoot the most common errors that occur when you upgrade an Azure Kubernetes Service cluster.
ms.date: 03/15/2022
author: genlin
ms.author: genli
ms.reviewer: chiragpa
ms.service: container-service
---
# Troubleshooting Azure Kubernetes Service cluster upgrade errors

This article provides guidance for troubleshooting the most common errors that occur when you upgrade an Azure Kubernetes Service (AKS) cluster.

## Before you begin

Check the error message that you received during the upgrade process, and follow the appropriate steps in the "Resolution" section.

This article requires Azure CLI version 2.0.65 or a later version. To find the version number, run `az --version`. If you have to install or upgrade Azure CLI, see [Install Azure CLI](/cli/azure/install-azure-cli).

For a detailed upgrade process, see [What happens during AKS cluster upgrade](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Upgrade fails because of NSG rules

### Cause

An NSG rule is blocking the cluster from downloading required resources.

### Resolution

To resolve this issue, follow these steps:

1. Run `az network nsg list -o table`, and then locate the NSG that's linked to your cluster. The NSG is lopcated in a resource group that's named `MC_<RG name>_<your AKS cluster name>`.

1. View the rules of the NSG:

    ```cli
    az network nsg rule list --resource-group <Rg name> --nsg-name <nsg name> --include-default -o table
    ```
    The following screenshot shows the default rules:

    :::image type="content" source="./media/troubleshoot-upgrade-errors/default-nsg-rules.png" alt-text="Screenshot of the default NSG rules.":::

1. If you have the default rules, skip this step. Otherwise, revise and remove the rules that are blocking the internet traffic. Then, try to upgrade the AKS cluster to the same version that you previously tried to upgrade to. This process will trigger a reconciliation.

    ```cli
    az aks upgrade --resource-group <ResourceGroupName> --name <AKSClusterName> --kubernetes-version <KUBERNETES_VERSION>
    ```

## Error code: PodDrainFailure

### Cause

This error might occur if a pod is protected by the Pod Disruption Budget (PDB) policy. In this situation, the pod resists being drained.

To test this, run `kubelect get pdb -A`, and then check the **Allowed Disruption** value. The value should be **1** or greater. For more information, see [Plan for availability using pod disruption budgets](/azure/aks/operator-best-practices-scheduler#plan-for-availability-using-pod-disruption-budgets).

If the **Allowed Disruption** value is **0**, the node drain will fail during the upgrade process.

### Workaround

 To work around this issue, use one of the following methods:

- Adjust the PDB to enable pods draining. Generally, The Allowed Disruption is the result of `Min Available / Max unavailable` or `Running pods / Replicas`. You can modify the `Min Available / Max unavailable` parameter at PDB level or increase the number of `Running pods / Replicas` to push the Allowed Disruption value to **1** or greater.
- Take a backup of the PDB `kubectl get pdb <pdb-name> -n <pdb-namespace> -o yaml > pdb_backup.yaml`, and then delete the PDB `kubectl delete pdb <pdb-name> -n /<pdb-namespace>`. After the upgrade is completed, you can re-deploy the PDB `kubectl apply -f pdb_backup.yaml`.
- Delete the pods that can’t be drained. Note that if the pods were created by a deployment or StatefulSet, they'll be controlled by a ReplicaSet. So, you may have to delete the deployment or StatefulSet. Before you do that, we recommend that you make a backup `kubectl get <kubernetes-object> <name> -n <namespace> -o yaml > backup.yaml`.

After you apply one of these methods, re-initiate the upgrade operation for the AKS cluster to the same version that you tried to upgrade previously. This process will trigger a reconciliation that will try to re-upgrade the AKS nodes.

## Error code: PublicIPCountLimitReached

### Cause

The error occurs if you reached the maximum number of public IP addresses that are allowed for your subscription.

### Resolution

To raise the limit or quota for your subscription, go to the [Azure portal]( https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest), file a **Service and subscription limits (quotas)** support ticket, and set the quota type to **Networking**.

After the quota change takes effect, try to upgrade the cluster to the same version that you previously tried to upgrade to. This process will trigger a reconciliation.

```cli
az aks upgrade --resource-group <ResourceGroupName> --name <AKSClusterName> --kubernetes-version <KUBERNETES_VERSION>
```
## Error code: Quotaexceeded

### Cause

The issue occurs if the quota is reached. Your subscription doesn’t have available resources that are required for upgrading.

### Resolution

To raise the limit or quota for your subscription, go to the [Azure portal]( https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest), file a **Service and subscription limits (quotas)** support ticket.

The following is a sample of the error message:

>Operation results in exceeding quota limits of Core. Maximum allowed: X, Current in use: X, Additional requested: X

In this case, you have to submit a support ticket to increase the quote for Compute cores.

## Error code: Subnetisfull

### Error message

Failed to scale node pool \<AGENT POOL NAME>\' in Kubernetes service '\<NAME>\'. Error: VMSSAgentPoolReconciler retry failed: Code='SubnetIsFull' Message=’\<SUBNET NAME>\ with address prefix \<PREFIX>\ doesn't have enough capacity for IP addresses.' Details=[]

### Cause

This error occurs if your cluster doesn’t have enough IP addresses to create a new node.

When you plan to perform an upgrade or scaling operation, the number of the required IP addresses should be considered. If the IP address range that you configured in the cluster only supports a fixed number of nodes, the upgrade or scaling operation will fail. For more information, see [Plan IP addressing for the cluster](/azure/aks/configure-azure-cni#plan-ip-addressing-for-your-cluster).

### Workaround

To work around the issue, reduce the cluster nodes to reserve IP addresses for the upgrade.

If scaling down isn't an option, and your virtual network CIDR has enough IP addresses, try to add a node pool that has a [unique subnet](/azure/aks/use-multiple-node-pools#add-a-node-pool-with-a-unique-subnet-preview):

1. Add a new user node pool in the virtual network on a larger subnet.
1. Switch the original node pool to one of type system.
1. Scale up the user node pool.
1. Scale down the original node pool.
