---
title: Event ID 1222 when you create failover cluster
description: Resolves an issue in which event ID 1222 is generated in the System log when you create a Windows Server 2012 failover cluster.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: robsmi, kaushika, qianyu
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
---
# Event ID 1222 when you create a Windows Server 2012 failover cluster

This article provides a solution to solve an issue where the event ID 1222 is logged when you create a Windows Server 2012 failover cluster.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2770582

## Symptoms

When you create a Windows Server 2012 failover cluster, the event ID 1222 is logged in the System log.

## Cause

When you create a Windows Server failover cluster, a Cluster Computer object for the cluster name is created in Active Directory Domain Services (AD DS). The object is called a Cluster Name Object (CNO).

A new feature in Windows Server 2012 flags Cluster Computer objects to prevent them being deleted accidentally. If you do not have sufficient rights to the organizational unit (OU) in AD DS where the Computer objects are being created, an event is logged that notifies you that the cluster objects are not protected from accidental deletion.

## Resolution

To resolve this issue, follow these steps:

1. Start **Active Directory Administrative Center**, and then select the tree view.
2. Select the CNO's organizational unit (OU).
3. Locate and right-click the CNO, and then click **Properties**.
4. Click to select the **Protect from accidental deletion**  check box, and then click **OK**.

> [!NOTE]
> Cluster Computer objects that are not protected from accidental deletion have no adverse effect on the functionality of the cluster. If you are not concerned about the unintentional deletion of Cluster Computer objects, you can safely ignore this warning.

## More information

To improve the level of protection and ability to recover from the accidental deletion of Custer Computer objects, we recommend that you enable the Active Directory Recycle Bin feature. For more information about how to do this, go to the following websites:

- [Step-by-step guide to the Active Directory Recycle Bin feature](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd392261(v=ws.10))

- [How to configure accounts in Active Directory](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731002(v=ws.10))

For more information about Cluster Computer Objects, go to the following MSDN website:

[How to identify stale Cluster Computer objects](https://techcommunity.microsoft.com/t5/failover-clustering/identifying-stale-cluster-computer-objects/ba-p/371687)
