---
title: Error when you share folders in failover cluster
description: Describes a problem in which you may receive warning messages or error messages when you provision a shared folder on a cluster physical disk resource in Windows Server 2008.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ctimon
ms.custom: sap:cannot-bring-a-resource-online, csstroubleshoot
---
# You may receive error messages when you share a folder in a Windows Server 2008 failover cluster

This article provides a solution to an error that occurs when you provision a shared folder on a cluster physical disk resource.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 947051

## Beta Information

This article discusses a beta release of a Microsoft product. The information in this article is provided as-is and is subject to change without notice.

No formal product support is available from Microsoft for this beta product. For information about how to obtain support for a beta release, see the documentation that is included with the beta product files, or check the Web location where you downloaded the release.  

## Symptoms

In Windows Server 2008, you can use the following tools to provision a shared folder on a cluster physical disk resource:  

- Use the Failover Cluster Management snap-in.
- Use the Share and Storage Management snap-in.
- Use Windows Explorer.  

However, when you use these tools to share a folder in a Windows Server 2008 failover cluster, you may experience the following symptoms.

### Symptom 1

When you right-click a folder in Windows Explorer, and then you click **Share**, you may receive the following warning message:  
>Your folder could not be shared

### Symptom 2

You right-click a folder in Windows Explorer, and then you click **Properties**. If you then click **Share this folder** under **Advanced Sharing** on the **Sharing** tab, you may receive the following error message:  
>An error occurred which trying to share **folder_name**. The cluster resource could not be found. The shared resource was not created at this time.

### Symptom 3

When you try to use the Provision a Shared Folder Wizard in the Failover Cluster Management snap-in or in the Share and Storage Management snap-in to share a folder, you may receive the following warning message:  
> The shared folder resides on a highly available volume, but no highly available network server name is associated with the volume. A cluster resource can be created for the shared folder, but clients can only access the shared folder through the local server name **server_name**. Are you sure you want to use this specified located?  

If you click **Yes**, you receive the following error message:  
> Share over SMB  

If you click the **Details** tab that is associated with this error message, you receive the following error message:  
> \\\ **server_name**\\**folder_name**: New SMB shared folder cannot be created. The cluster resource could not be found.  

> [!NOTE]
> Both the Failover Cluster Management snap-in and the Share and Storage Management snap-in use the Provision a Shared Folder Wizard to provision a shared folder. Therefore, provisioning a shared folder in the Failover Cluster Management snap-in is basically the same as provisioning a shared folder in the Share and Storage Management snap-in.

## Cause

These problems occur because you are trying to provision a shared folder on a cluster physical disk resource that is not a member of the **Highly Available Application or Service** group. Cluster physical disk resources are listed in the **Available Storage** group. To view this group, click **Storage** in the Failover Cluster Management snap-in.

## Resolution

To resolve this issue, make sure that the physical disk resource is a member of the **Highly Available Application or Services** group in the cluster that already has a Client Access Point (CAP) configured. Also, make sure that the status of the physical disk resource is "Online."
