---
title: Troubleshoot Auto Update for Expired Azure File Sync Agents    
description: Troubleshoot Auto Update when an Azure File Sync agent is near expiration or expired, verify metadata and connectivity, and restore updates now.
author: khdownie
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 07/21/2025
ms.author: kendownie
ms.custom: sap:File Sync, copilot-scenario-highlight
---
# Auto Update can't upgrade a "to be expired" or expired Azure File Sync agent

## Summary

This article explains how to troubleshoot situations where the Azure File Sync agent that's about to expire or is already expired can't be upgraded automatically by the Auto Update feature. It describes how to verify that the agent expiration metadata is correctly applied to the server and how to check network connectivity if the metadata isn't set.

## Troubleshooting steps

If Auto Update can't upgrade your Azure File Sync agent that's about to expire or is expired, check that the agent expiration information is properly applied to the server. Auto Update needs the expiration metadata to work correctly.

To check if the `AgentExpirationDate` metadata is set, run the following command from an elevated PowerShell session:

```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Get-StorageSyncServer
```

If the `AgentExpirationDate` metadata isn't set or its value is empty, a networking problem might be preventing the server from receiving the expiration data. To test network connectivity, run the following command:

```powershell
Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
Test-StorageSyncNetworkConnectivity
```

If the test reports network connectivity problems, you can manually update the agent by downloading it from the [Microsoft Update Catalog](https://catalog.update.microsoft.com/Search.aspx?q=azure%20file%20sync).

After you download the appropriate agent version, see the specific KB article in the catalog for step-by-step installation instructions.

If there are no connectivity problems and the `AgentExpirationDate` metadata is still not set, contact Azure File Sync support for help.



