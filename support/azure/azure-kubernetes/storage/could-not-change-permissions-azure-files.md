---
title: Could not change permissions using Azure Files
description: Troubleshoot an error in which you could not change permissions when you use Azure Files in Azure Kubernetes Service (AKS).
ms.date: 02/28/2025
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why I receive a "could not change permissions" error when I use Azure Files so that I can successfully use my Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Storage
---
# "Could not change permissions" error while using Azure Files

This article discusses how to troubleshoot a "could not change permissions" error when you use Microsoft Azure Files with your Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you run PostgreSQL on the Azure Files plug-in, you receive an error that resembles the following output:

> initdb: could not change permissions of directory "/var/lib/postgresql/data": Operation not permitted
>
> fixing permissions on existing directory /var/lib/postgresql/data
> 
> Message: 'OSError while changing ownership of the log file. 'Arguments: PermissionError: [Errno 1] Operation not permitted

## Cause

The Azure Files plug-in uses the Common Internet File System (CIFS) protocol, which is a dialect of the Server Message Block (SMB) protocol. When this protocol is in use, the file and directory permissions can't be changed after the files and directories are mounted.

## Workaround

Use the Azure Disk plug-in instead, and [use the subPath property](https://kubernetes.io/docs/concepts/storage/volumes/#using-subpath).

> [!NOTE]
> For the ext3 or ext4 disk type, there's a *lost+found* directory after the disk is formatted.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
