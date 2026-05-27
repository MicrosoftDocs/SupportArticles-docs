---
title: Collect logs and traces on the Azure File Sync server
description: Collect logs and traces on an Azure File Sync server with AFSDiag to troubleshoot sync issues quickly. Follow these steps and send results to support.
author: khdownie
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 07/21/2025
ms.author: kendownie
ms.custom: sap:File Sync, copilot-scenario-highlight
---

# Collect logs and traces on the Azure File Sync server 

## Summary

If troubleshooting steps don't resolve your issue, use AFSDiag to collect logs and traces on the Azure File Sync server, then send the .zip output to your support engineer for further diagnosis.

## Use the AFSDiag tool to collect logs and traces

To run AFSDiag and collect logs and traces, follow these steps:

1. Open an elevated PowerShell window, and then run the following commands (press <kbd>Enter</kbd> after each command):

    > [!NOTE]
    > AFSDiag creates the output directory and a temp folder within it before collecting logs. It deletes the temp folder after execution. Specify an output location that doesn't contain data.

    ```powershell
    Import-Module "C:\Program Files\Azure\StorageSyncAgent\StorageSync.Management.ServerCmdlets.dll"
    Debug-StorageSyncServer -AFSDiag -OutputDirectory C:\output -KernelModeTraceLevel Verbose -UserModeTraceLevel Verbose
    ```

1. Reproduce the issue. When you finish, enter *D*.
1. A .zip file that contains logs and trace files is saved to the output directory that you specified.

 
