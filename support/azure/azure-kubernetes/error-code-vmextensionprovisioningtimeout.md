---
title: Troubleshoot the VMExtensionProvisioningTimeout error code
description: Learn how to troubleshoot the VMExtensionProvisioningTimeout error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 3/10/2022
author: DennisLee-DennisLee
ms.author: v-dele
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi
ms.service: container-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VMExtensionProvisioningTimeout error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the VMExtensionProvisioningTimeout error code

This article describes how to identify and resolve the `VMExtensionProvisioningTimeout` error, which might occur if you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), version 2.28.0 or higher. If Azure CLI is already installed, you can find the version number by entering `az --version`.

## Symptoms

When you try to create the cluster, you receive the following error message:

> Failed to reconcile agent pool agentpool0: err: **VMSSAgentPoolReconciler retry failed:**
>
> **Category: InternalError;**
>
> **SubCode: VMExtensionProvisioningTimeout;**
>
> Dependency: Microsoft.Compute/VirtualMachineScaleSet;
>
> OrginalError: 
>
> Code="VMExtensionProvisioningTimeout"
>
> Message="Provisioning of VM extension vmssCSE has timed out. Extension provisioning has taken too long to complete. The extension last reported \"Plugin enabled\".\r\n\r\nMore information on troubleshooting is available at <https://aka.ms/VMExtensionCSELinuxTroubleshoot>";
>
> AKSTeam: NodeProvisioning,
>
> Retriable: true

## Cause

For the VMExtensionProvisioningError class of errors, there can be a few different causes, but what we check remains the same. Possible causes are as follows:

- The custom script extension that provisions the virtual machines (VMs) couldn't establish a connection to the endpoint that's used for downloading the Kubernetes binaries.

- The custom script extension that provisions the VMs couldn't establish a connection to the endpoint that's used for downloading the CNI binaries.

- The custom script extension that provisions the VMs couldn't establish the required outbound connectivity to obtain packages.

- The cluster couldn't resolve the necessary Domain Name System (DNS) address to properly provision the node.

- The custom script extension that provisions the VMs reached a timeout while running the [apt-get]() update.

## Solution

Follow these steps:

1. If egress filtering is set up on the cluster, see [Control egress traffic for cluster nodes in AKS](/azure/aks/limit-egress-traffic) to view the necessary prerequisites and make sure that your setup meets those prerequisites.

1. On your DNS servers and firewall, make sure that nothing blocks the resolution of your cluster's fully qualified domain name (FQDN).

1. Review the following articles if FQDN resolution continues to be blocked, because your custom DNS server might be configured incorrectly:
    - [Create a private AKS cluster](/azure/aks/private-clusters)
    - [Private Azure Kubernetes service with custom DNS server](https://github.com/Azure/terraform/tree/00d15e09c54f25fb6387330c36aa4366122c5aaa/quickstart/301-aks-private-cluster)
    - [What's IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)
    
## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)
