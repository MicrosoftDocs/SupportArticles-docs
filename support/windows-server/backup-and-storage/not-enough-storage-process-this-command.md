---
title: Fail to access file shares on SOFS-configured server
description: Describes an issue that occurs when you try to access file shares on a SMB server that has the Scale-Out File Server role configured, and provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, nedpyle, kapilth, robhind, jgerend, kumud
ms.custom: sap:Backup, Recovery, Disk, and Storage\File Server Resource Manager (FSRM) , csstroubleshoot
---
# Error when you access file shares on a SOFS-configured server: Not enough server storage is available to process this command

This article provides a solution to an issue that occurs when you access file shares on a SMB server that has the Scale-Out File Server role configured.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3101545

## Symptoms

Consider the following scenario:

- You configure the [Scale-Out File Server](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831349(v=ws.11)) (SOFS) role on a server that's running Window Server 2012 R2.
- You have server applications and clients that access file shares frequently.
- The applications and clients open many short-lived sessions in which they connect, authenticate, change files, and close the session immediately.

In this scenario, after some time, access to the file shares is unsuccessful, and a STATUS_INSUFF_SERVER_RESOURCES error is recorded in a network capture.

Additionally, when users try to connect to SOFS shares, they receive the following error message:

> Not enough server storage is available to process this command.

You also see a high handle count in Lsass.exe on both the coordinator and non-coordinator nodes of the cluster.

> [!NOTE]
> If you failover the disk resource to another node, the issue temporarily does not occur.

## Cause

This issue occurs because the applications create new sessions every time that they change a file instead of reusing sessions to generate many metadata changes.

The CSV File System uses the SMB protocol to keep metadata information consistent between the cluster nodes. A high volume of metadata changes generate many SMB sessions between the non-coordinator and coordinator nodes of the cluster and exhaust the SMB table on the coordinator node.

## Resolution

To fix this issue for these kinds of application workloads, we recommend that you use the File Server for General Use role instead of SOFS.

> [!NOTE]
> The SOFS role should not be used if the workload generates an exceptionally high number of metadata operations, such as opening and creating new files or renaming existing files.

## More information

In a network capture between non-coordinator and coordinator nodes, you see that after an SMB Session Setup request, the coordinator node responds with a STATUS_INSUFF_SERVER_RESOURCES error.
