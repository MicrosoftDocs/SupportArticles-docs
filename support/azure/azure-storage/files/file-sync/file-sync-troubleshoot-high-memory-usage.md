---
title: Troubleshoot high memory usage on a server running Azure File Sync
description: Learn how to troubleshoot high memory usage on a server running Azure File Sync and cap ESE database cache consumption to improve stability—follow these steps now.
author: khdownie
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 07/21/2025
ms.author: kendownie
ms.custom: sap:File Sync, copilot-scenario-highlight
---
# High memory usage on an Azure File Sync server

## Summary

This article explains how to troubleshoot high memory usage on a server running Azure File Sync. It describes how the Extensible Storage Engine (ESE) databases used by Azure File Sync can consume a large portion of system memory and how to limit that memory usage by configuring the `MaxESEDbCachePercent` registry setting.

## Troubleshooting high memory usage

Azure File Sync uses Extensible Storage Engine (ESE) databases for sync and cloud tiering. The ESE databases can use up to 80% of system memory to improve performance. To limit the amount of memory the ESE databases use, you can configure the `MaxESEDbCachePercent` registry setting on the server.

To reduce the ESE memory usage limit to 60%, which is a good balance between memory use and enough cache to keep decent performance of the databases, run the following command from an elevated command prompt:

```console
REG ADD HKLM\Software\Microsoft\Azure\StorageSync /v MaxESEDbCachePercent /t REG_DWORD /d 60
```

After you create the `MaxESEDbCachePercent` registry setting, restart the Storage Sync Agent (FileSyncSvc) service. 
