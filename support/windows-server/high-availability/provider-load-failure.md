---
title: Error (Provider load failure) when you add a node to a Failover Cluster
description: Provides a solution to an error that occurs when you try to add a node to a Windows Server 2008-based Failover Cluster.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, stevenek, rspitz
ms.custom: sap:initial-cluster-creation-or-adding-node, csstroubleshoot
---
# Error message "Provider load failure" when you try to add a node to a Windows Server 2008-based Failover Cluster

This article provides a solution to an error that occurs when you try to add a node to a Windows Server 2008-based Failover Cluster.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2854337

## Symptoms

When you attempt to add a node to your existing Windows Server 2008-based Failover Cluster using the Add-Node wizard, you receive the following error message at the bottom of the Add-Node wizard screen:

> Provider load failure

## Cause

The error "Provider Load Failure" is returned from WMI when a query is performed and it's unable to load the required providers to satisfy the query. In this case, the cluster "Add Node" wizard is making query to identify the domain of the server and the provider is not correctly registered on the server.

Follow these steps to determine if you are experiencing this issue, on both the server you are attempting to add to the cluster as well as the node that is already part of the cluster:

1. Open WMI Tester - wbemtest.exe.
2. Select **Connect**.
3. In the **Namespace** box enter *root\\cimv2*, and then select **Connect**.
4. Select **Query** and then enter `SELECT Domain FROM Win32_ComputerSystem`.

If you get the "Provider load failure" error, you are experiencing the problem documented in this article, on this server.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this problem you need to correct the registration information for the Cimwin32.dll file in the registry, using these steps:

1. Identify a Windows Server 2008 computer that is at the same Service Pack and Hotfix level as the problem server and you are able to run the above mentioned query successfully, in Wbemtest.exe.

    > [!NOTE]
    > This do not necessarily need to be a Cluster node.

2. To open Registry Editor, select **Start** and then enter *regedit*.‌

    Administrator permission required if you are prompted for an administrator password or confirmation, type the password or provide confirmation.
3. Navigate to the following key:

    `HKEY_CLASSES_ROOT\CLSID\{D63A5850-8F16-11CF-9F47-00AA00BF345C}\InprocServer32`
4. Select the key or the subkey that you want to back up.
5. Select the **File** menu, and then select **Export**.
6. In the **Save** in box, select the location where you want to save the backup copy, and then type a name for the backup file in the **File name** box. Save it as a .REG file.
7. Copy the above saved .REG file to the problem server.
8. Access the file on the problem server and double-click the file to merge it into the registry.
9. Restart the server.
