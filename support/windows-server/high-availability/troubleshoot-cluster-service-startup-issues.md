---
title: How to troubleshoot Cluster service startup issues
description: Describes the basic troubleshooting steps you can use to diagnose Cluster service startup issues with Windows Server 2003.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Clustering and High Availability\Cluster service fails to start, csstroubleshoot
---
# How to troubleshoot Cluster service startup issues in Windows Server 2003

This article describes the basic troubleshooting steps you can use to diagnose Cluster service startup issues with Windows Server 2003.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 266274

## Summary

This article describes basic troubleshooting steps you can use to diagnose Cluster service startup issues with Windows Server 2003. Although this isn't a comprehensive list of all the issues that can cause the Cluster service not to start, it does address a majority Windows Server 2003 startup issues. The contents of this article do NOT apply to Windows Server 2008 or later.

## More information

When the Cluster service initially starts, it attempts to join an existing cluster. For this to occur, the Cluster service must be able to contact an existing cluster node. If the join procedure doesn't succeed, the cluster continues to the form stage; the main requirement of this stage is the ability to mount the quorum device.

These are the steps in the startup process in order:

- Authenticate the Service account.
- Load the local copy of the cluster database.
- Use information in the local database to try to contact other nodes to begin the join procedure. If a node is contacted and authentication is successful, the join procedure is successful.
- If no other node is available, the Cluster service uses the information in the local database to mount the quorum device and updates the local copy of the database by loading the latest checkpoint file and replaying the quorum log.

### Troubleshooting Cluster service startup issues

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. Verify that the cluster node that is having problems is able to properly authenticate the Service account. You can determine this by logging on to the computer with the Cluster service account, or by checking the System event log for Cluster service logon problem event messages.
2. Verify that the %SystemRoot%\Cluster folder contains a valid Clusdb file and that the Cluster service attempted to start. Start Registry Editor (Regedt32.3xe) and verify that the following registry key is valid and loaded: `HKEY_LOCAL_MACHINE\Cluster`  

    The cluster hive should have a structure that is very similar to Cluster Administrator. Make note of the network and quorum keys. If the database isn't valid, you can copy and use the cluster database from a live node.

3. If the node isn't the first node in the cluster, check connectivity to other cluster nodes across all available networks. Use the Ping.exe tool to verify TCP/IP connectivity, and use Cluster Administrator to verify that the Cluster service can be contacted. Use the TCP/IP addresses of the network adapters in the other nodes in the **Connect to** dialog box in Cluster Administrator.
4. If it can't contact any other node, the service continues with the form phase. It attempts to locate information about the quorum in the local cluster database, and then tries to mount the disk. If the quorum disk can't be mounted, the service doesn't start. If another node has successfully started and has ownership of the quorum, the service doesn't start. This is usually caused by connectivity or authentication issues. If this isn't the case, you can check the status of the quorum device by starting the service with the -fixquorum switch, and attempt to bring the quorum disk online, or change the quorum location for the service. Also, check the System event log for disk errors. If the quorum disk successfully comes online, it's likely that the quorum is corrupted.  
5. Check the attributes of the Cluster.log file to make sure that it's not *read-only*, and make sure that no policy is in effect that prevents modification of the Cluster.log file. If either of these conditions exist, the Cluster service can't start.

If these steps don't resolve the problem, you should take additional troubleshooting steps. The cluster log file can be valuable in additional troubleshooting. By default, cluster logging is enabled on Windows 2000-based computers that are running the Cluster service.
