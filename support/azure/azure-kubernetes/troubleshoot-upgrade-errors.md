---
title: Troubleshoot errors when you upgrade Azure Kubernetes Service cluster
description: This article helps you troubleshoot the most common errors when you upgrade an Azure Kubernetes Service cluster.
ms.date: 03/15/2022
author: genlin
ms.author: genli
ms.reviewer: chiragpa
ms.service: container-service
---
# Troubleshooting Azure Kubernetes Service cluster upgrade errors

This article provides guidance for troubleshooting the most common errors that occur when you upgrade an Azure Kubernetes Service (AKS) cluster. 

## Before you begin

Check the error message that you received during the upgrade process and follow the appropriate steps below.

This article requires Azure CLI version 2.0.65 or later. Run `az --version` to find the version. If you need to install or upgrade Azure CLI, see [Install Azure CLI](/cli/azure/install-azure-cli).

For detail upgrade process, see [What happens during AKS cluster upgrade](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Error code: PodDrainFailure

### Cause

The error might occur if a pod is protected by the Pod Disruption Budget (PDB) policy and refuse to be drained.

Run `kubelect get pda -A`, check if **Allowed Disruption** is 1 or a greater number.  For more information, see [Plan for availability using pod disruption budgets](azure/aks/operator-best-practices-scheduler#plan-for-availability-using-pod-disruption-budgets).

If **Allowed Disruption** is 0, the node drain will fail during the upgrade process.

### Workaround

 Use one of the following methods to work around the issues:

- Delete the pod that cause the problem, and then do a reconciliation.
- Fix the PDB, and then do a reconciliation.

After that, try to upgrade the cluster to the same version that failed before. This process will trigger a reconciliation.

```
az aks upgrade --resource-group myResourceGroup --name myAKSCluster --kubernetes-version <KUBERNETES_VERSION>
```

## Error code: PublicIPCountLimitReached

### Cause

The error might occur if you reached the maximum number of public IP addresses that are allowed for your subscription.

### Resolution

To raise the limit or quota for your subscription, go to the [Azure portal]( https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest), file a **Service and subscription limits (quotas)** support ticket, and set the quota type to **Networking**.

After the quota change takes effect , try to upgrade the cluster to the same version that failed before. This process will trigger a reconciliation.

```
az aks upgrade --resource-group myResourceGroup --name myAKSCluster --kubernetes-version <KUBERNETES_VERSION>
```
 
## Error code: Quotaexceeded

### Cause

The issue occurs if the quota is reached and your subscription doesn’t have available resources that required for the cluster upgrade operation.

### Resolution

To raise the limit or quota for your subscription, go to the [Azure portal]( https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest), file a **Service and subscription limits (quotas)** support ticket.

The following is a sample of the error message:

>Operation results in exceeding quota limits of Core. Maximum allowed: X, Current in use: X, Additional requested: X

In this case, you need to submit a support ticket to increase the quote for Compute cores.

## Error code: subnetisfull 

### Error message

Failed to scale node pool \<AGENT POOL NAME>\' in Kubernetes service '\<NAME>\'. Error: VMSSAgentPoolReconciler retry failed: Code='SubnetIsFull' Message=’\<SUBNET NAME>\ with address prefix \<PREFIX>\ does not have enough capacity for XXX IP addresses.' Details=[]

### Cause

This error occurs if your cluster doesn’t have enough IP addresses to create a new buffer node. 

The number of IP addresses required should include considerations for upgrade and scaling operations. If you set the IP address range to only support a fixed number of nodes, you cannot upgrade or scale your cluster.

- When you upgrade your AKS cluster, a new node is deployed into the cluster. Services and workloads begin to run on the new node, and an older node is removed from the cluster. This rolling upgrade process requires a minimum of one additional block of IP addresses to be available. Your node count is then n + 1.

- This consideration is particularly important when you use Windows Server node pools. Windows Server nodes in AKS do not automatically apply Windows Updates, instead you perform an upgrade on the node pool. This upgrade deploys new nodes with the latest Window Server 2019 base node image and security patches. For more information on upgrading a Windows Server node pool, see Upgrade a node pool in AKS.

- When you scale an AKS cluster, a new node is deployed into the cluster. Services and workloads begin to run on the new node. Your IP address range needs to take into consideration how you may want to scale up the number of nodes and pods your cluster can support. One additional node for upgrade operations should also be included. Your node count is then n + number-of-additional-scaled-nodes-you-anticipate + 1.

For more informaiton see [Plan IP addressing for the cluster](/azure/aks/configure-azure-cni#plan-ip-addressing-for-your-)

### Workaround

To work around the issue, Reduce the cluster nodes to allow enough IPs to be available for the upgrade.

If scaling down is not an option, and your virtual network CIDR has enough IP addresses, try to add a node pool with a [unique subnet](/azure/aks/use-multiple-node-pools#add-a-node-pool-with-a-unique-subnet-preview):
- 
1. Add a new user node pool in the virtual network on a larger subnet.
1. Switch the original node pool to one of type system
1. Scale up the user node pool.
1. Scale down the original node pool.

## Upgrade fails due to NSG rules (for public cluster)

### Cause

A NSG rule is blocking the cluster to download required resources from Internet.

### Resolution

To resolve this issue, follow these steps:

1. Run `az network nsg list -o table`, and then locate the NSG that linked to your cluster. The NSG is placed in a resource group named `MC_<RG name>_<your AKS cluster name>`.

1. View the rules of the NSG:

    ```
    az network nsg rule list --resource-group <Rg name> --nsg-name <nsg name> --include-default -o table
    ```
    The following is the default rules:

    :::image type="content" source="./media/troubleshoot-upgrade-errors/default-nsg-rules.png" alt-text="The screenshot of the default NSG rules":::

1. If you have default rules, the problem should not caused by the NSG rules. if not, revise and remove the rules that are blocking the internet traffic.