---
title: Replicated Cluster Shared Volumes are offline after Azure Stack HCI upgrade
description: Provides methods to start the StorageReplica service after an Azure Stack hyperconverged infrastructure (HCI) upgrade.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-abhjoa, katpa
ms.custom: sap:storage-hardware, csstroubleshoot
---
# Replicated Cluster Shared Volumes are offline after an Azure Stack HCI upgrade

This article provides methods to start the StorageReplica service after an Azure Stack hyperconverged infrastructure (HCI) upgrade.

## Summary

After you upgrade a stretched cluster from Azure Stack HCI, version 20H2 to version 21H2, all the replicated Cluster Shared Volumes are offline.

In addition, Event ID 7001 is logged in the **Event Viewer**.

```output
Event ID: 7001
Event Source: Service Control Manager
Event Details: The StorageReplica service depends on the LanmanWorkstation service which failed to start because of the following error:
The service cannot be started, either because it is disabled or because it has no enabled devices associated with it.
```

## The StorageReplica service fails to start

This issue occurs because the StorageReplica service fails to start. The StorageReplica service depends on the LanmanWorkstation service that doesn't start. After some time, the LanmanWorkstation service is started and in the running status. However, the StorageReplica service remains stopped.

## Restart the server or manually start the StorageReplica service

To fix this issue, restart the server again or manually start the StorageReplica service.

> [!NOTE]
> These methods are required only once on each server after a Cluster-Aware Updating (CAU) upgrade.

## Create a post-update script to avoid the issue

Upgrading stretched clusters with a CAU post-update script is supported by using Windows PowerShell. To avoid this issue, run the `Invoke-CauRun` cmdlet with a post-update script when you upgrade the cluster.

> [!NOTE]
> Upgrading stretched clusters by using Windows Admin Center is not supported.

1. Create a PowerShell script (named *Post_Update_Script.ps1*) as follows:

    ```powershell
    Get-Service "Storage Replica" | Stop-Service
    sleep 20
    Get-Service "Storage Replica" | Start-Service
    sleep 20
    ```

2. Run the `Invoke-CauRun` cmdlet with the created post-update script:

    ```powershell
    Invoke-CauRun -ClusterName <ServerName> -CauPluginName "Microsoft.RollingUpgradePlugin" -CauPluginArguments @{'WuConnected'='true';} -Verbose -EnableFirewallRules -Force -PostUpdateScript Post_Update_Script.ps1
    ```
