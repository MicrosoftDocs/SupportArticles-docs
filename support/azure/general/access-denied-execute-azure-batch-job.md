---
title: 
description: 
ms.date: 09/20/2022
ms.service:
ms.author: genli
author: AmandaAZ
ms.reviewer: 
---
# Azure Storage Account with firewall causes errors when executing Batch jobs

The Azure Storage Account is a necessary dependent component for Azure Batch account to store resource files, application packages and output files. In many cases, you use Azure Storage Account with a firewall to enhance the security of the Azure Storage Account. However, Azure Storage Account with firewall may cause some errors when you execute Azure Batch jobs. This article provides solutions to such issues.

## Symptoms

When executing Azure Batch Jobs, you may encounter errors that're related to the associated Azure Storage Account. For example, 

> **Category**: UserError  
> **Code**: ResourceContainerAccessDenied  
> **Message**: Access for one of the specified Azure Blog container(s) is denied

## Cause

When you create an Azure Batch pool, new virtual machines (Batch nodes) will be provisioned. If you don't assign a static public IP to the Batch pool, a random public IP will be assigned. Whenever you resize the number of nodes to 0 and resize out again, the public IP address of these new Batch nodes will change. Therefore, if the associated Azure Storage Account has a firewall configured, it's hard for you to manage the allow list of the firewall.
 
Additionally, if the Azure Storage Account and the Azure Batch pool are in the same region, the outbound traffic from Azure Batch nodes will go via Azure backbone internet (private IPs) instead of the public IP. Meanwhile, Azure Storage Firewall isn't allowed to add a private IP in the allow list, which will also cause the traffic to the Azure Storage Account to be denied.

## Resolution

To resolve this issue, manage the Azure Batch pool and the Azure Storage Account configurations based on the their regions.

### Scenario 1: Azure Batch pool and Storage Account are in the same region, and Batch pool has VNET

When an Azure Batch pool has configured a virtual network, check the Subnet information under Network Configuration from the Azure Portal -> Batch Account -> Pool -> Properties. The subnet info is displayed as shown below: