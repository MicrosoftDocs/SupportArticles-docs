---
title: Troubleshoot the VMExtensionProvisioningTimeout error code
description: Learn how to troubleshoot the VMExtensionProvisioningTimeout error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 09/20/2024
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, mariochaves, v-leedennis, v-weizhu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VMExtensionProvisioningTimeout error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the VMExtensionProvisioningTimeout error code

This article discusses how to identify and resolve the `VMExtensionProvisioningTimeout` error that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), version 2.28.0 or a later version. If Azure CLI is already installed, you can find the version number by running `az --version`.

## Symptoms

When you try to create an AKS cluster by using the Azure CLI, you receive the "VMExtensionProvisioningTimeout" error with text like the following example:

```output
Failed to reconcile agent pool agentpool0: err: VMSSAgentPoolReconciler retry failed:
Category: InternalError;
SubCode: VMExtensionProvisioningTimeout;
Dependency: Microsoft.Compute/VirtualMachineScaleSet;
OrginalError:
Code="VMExtensionProvisioningTimeout"
Message="Provisioning of VM extension vmssCSE has timed out. Extension provisioning has taken too long to complete. The extension last reported \"Plugin enabled\".\r\n\r\nMore information on troubleshooting is available at <https://aka.ms/VMExtensionCSELinuxTroubleshoot>";
AKSTeam: NodeProvisioning,
Retriable: true
```

You also can [view the error details in the Azure portal](troubleshoot-aks-cluster-creation-issues.md#view-error-details-in-the-azure-portal).

## Cause

Several different issues can cause the "VMExtensionProvisioningError" class of errors. However, the troubleshooting steps are the same for all the issues. Possible causes are as follows:

- The custom script extension that provisions the virtual machines (VMs) can't establish a connection to the endpoint that's used for downloading the Kubernetes binaries.

- The custom script extension that provisions the VMs can't establish a connection to the endpoint that's used for downloading the CNI binaries.

- The custom script extension that provisions the VMs can't establish the required outbound connectivity to obtain packages.

- The cluster can't resolve the necessary Domain Name System (DNS) address to correctly provision the node.

- The custom script extension that provisions the VMs reached a timeout while running a packet management update (such as [apt-get](https://manpages.ubuntu.com/manpages/xenial/man8/apt-get.8.html) in case the node pool uses Linux).

## Solution

Follow these steps:

1. If egress filtering is set up on the cluster (such as [custom user-defined routes](/azure/virtual-network/virtual-networks-udr-overview#custom-routes)), see [Limit network traffic with Azure Firewall in Azure Kubernetes Service (AKS)](/azure/aks/limit-egress-traffic) and [Outbound network and FQDN rules for AKS clusters](/azure/aks/outbound-rules-control-egress) to view the necessary prerequisites, and make sure that your setup meets the prerequisites.

1. On your DNS servers and firewall, make sure that nothing blocks the resolution of your cluster's fully qualified domain name (FQDN).

1. Because your custom DNS server might be configured incorrectly, review the following articles if FQDN resolution continues to be blocked:
    - [Create a private AKS cluster](/azure/aks/private-clusters)
    - [Private Azure Kubernetes service with custom DNS server](https://github.com/Azure/terraform/tree/00d15e09c54f25fb6387330c36aa4366122c5aaa/quickstart/301-aks-private-cluster)
    - [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
