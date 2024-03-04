--- 
title: No virtual network found error when configuring Azure deployment settings in HPC Pack Cluster Manager
description: This article describes how to resolve a no virtual network found error. This error occurs when you configure Azure deployment settings in HPC Pack Cluster Manager.  
ms.date: 11/18/2022
editor: v-jsitser
ms.reviewer: arrhpcglobal, v-leedennis
ms.service: azure-common-issues-support
#Customer intent: As an Azure HPC Pack user, I want to resolve the no virtual network found error that occurs when I configure Azure deployment settings in HPC Pack Cluster Manager.
---

# "No virtual network found" error when you configure Azure deployment settings

This article explains how to resolve the "no virtual network found" error that occurs when you configure Azure deployment settings in HPC Pack Cluster Manager.

## Symptoms

You deploy an HPC Pack cluster purely in Azure or in a Hybrid (burst to Azure IaaS nodes) environment. After you manually input the service principal application ID in the **Azure Deployment Settings** section of the **Azure Service Principal** webpage, you receive the following error message:

> No virtual network found in this Azure subscription, select another subscription.

## Cause

This error might occur if you use Azure Service Principal instead of Managed Identity to enable the head node to manage the Azure IaaS compute nodes.  

If you use a service principal, and if the Contributor role for the subscription isn't assigned, you have to manually input the application ID in the GUI. This error occurs because the subscription-level Contributor role isn't assigned to the service principal. (For example, you might have configured the service principal without assigning the Contributor role because you want to limit access to only certain resource groups.)

In this situation, the service principal is listed on the HPC Pack deployment wizard menu. (You don't have to manually input the application ID in the GUI.)

## Solution 1: If you don't want to limit permissions to specific resource groups

Unless you want to limit permissions to specific resource groups, you must assign the Contributor role for the service principal. See [Assign Azure roles using the portal](/azure/role-based-access-control/role-assignments-portal) and [Steps to assign an Azure role](/azure/role-based-access-control/role-assignments-steps).

## Solution 2: If you want to limit permissions to specific resource groups

If you want to limit permissions to specific resource groups, you must grant the following roles before you manually input the service principal application ID.

|Role|Description
|---|---
|Virtual Machine Contributor|For the resource groups in which you want to create compute nodes
|Network Contributor|For the virtual network in which the Azure virtual machine (VM) compute nodes join
|Key Vault Contributor|For the Azure Key Vault in which the Azure Key Vault certificate was created

## More information

- [Access control for Azure resources in HPC Pack clusters](/powershell/high-performance-computing/hpcpack-azure-access-permissions)
- [Configure the cluster to support deployments of Azure Iaas compute nodes](/powershell/high-performance-computing/hpcpack-burst-to-azure-iaas-nodes#step-1-configure-the-cluster-to-support-deployments-of-azure-iaas-compute-nodes)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
