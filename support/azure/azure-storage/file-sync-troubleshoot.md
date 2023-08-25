---
title: Troubleshoot Azure File Sync
description: Troubleshoot common issues that you might encounter with Azure File Sync, which you can use to transform Windows Server into a quick cache of your Azure file share.
author: khdownie
ms.service: azure-file-storage
ms.topic: troubleshooting
ms.date: 06/25/2023
ms.author: kendownie
---
# Troubleshoot Azure File Sync

You can use Azure File Sync to centralize your organization's file shares in Azure Files, while keeping the flexibility, performance, and compatibility of an on-premises file server. This article is designed to help you troubleshoot and resolve issues that you might encounter with your Azure File Sync deployment. We also describe how to collect important logs from the system if a deeper investigation of the issue is required. If you don't see the answer to your question, you can contact us through the following channels (in escalating order):

- [Microsoft Q&A question page for Azure Files](/answers/products/azure?product=storage).
- [Azure Community Feedback](https://feedback.azure.com/d365community/forum/a8bb4a47-3525-ec11-b6e6-000d3a4f0f84?c=c860fa6b-3525-ec11-b6e6-000d3a4f0f84).
- Microsoft Support. To create a new support request, in the Azure portal, on the **Help** tab, select the **Help + support** button, and then select **New support request**.

## I'm having an issue with Azure File Sync on my server (sync, cloud tiering, etc.). Should I remove and recreate my server endpoint?

No: removing a server endpoint isn't like rebooting a server! Removing and recreating the server endpoint is almost never an appropriate solution to fixing issues with sync, cloud tiering, or other aspects of Azure File Sync. Removing a server endpoint is a destructive operation. It may result in data loss in the case that tiered files exist outside of the server endpoint namespace. For more information, see [why do tiered files exist outside of the server endpoint namespace](/azure/storage/files/storage-files-faq#afs-tiered-files-out-of-endpoint). Or it may result in inaccessible files for tiered files that exist within the server endpoint namespace. These issues won't resolve when the server endpoint is recreated. Tiered files may exist within your server endpoint namespace even if you never had cloud tiering enabled. That's why we recommend that you don't remove the server endpoint unless you would like to stop using Azure File Sync with this particular folder or have been explicitly instructed to do so by a Microsoft engineer. For more information on remove server endpoints, see [Remove a server endpoint](/azure/storage/file-sync/file-sync-server-endpoint-delete).

## General troubleshooting first steps

If you encounter issues with Azure File Sync on a server, start by completing the following steps:

1. In Event Viewer, review the telemetry, operational, and diagnostic event logs.
    - Sync, tiering, and recall issues are logged in the telemetry, diagnostic, and operational event logs under *Applications and Services\Microsoft\FileSync\Agent*.
    - Issues related to managing a server (for example, configuration settings) are logged in the operational and diagnostic event logs under *Applications and Services\Microsoft\FileSync\Management*.
2. Verify the Azure File Sync service is running on the server:
    - Open the Services MMC snap-in and verify the Storage Sync Agent service (FileSyncSvc) is running.
3. Verify the Azure File Sync filter drivers (*StorageSync.sys* and *StorageSyncGuard.sys*) are running:
    - At an elevated command prompt, run `fltmc`. Verify the *StorageSync.sys* and *StorageSyncGuard.sys* file system filter drivers are listed.

If the issue isn't resolved, run the AFSDiag tool and send its .zip file output to the support engineer assigned to your case for further diagnosis.

To run AFSDiag, perform the steps below:

1. Open an elevated PowerShell window, and then run the following commands (press <kbd>Enter</kbd> after each command):

    > [!NOTE]
    > AFSDiag will create the output directory and a temp folder within it prior to collecting logs and will delete the temp folder after execution. Specify an output location which does not contain data.

    ```powershell
    cd "c:\Program Files\Azure\StorageSyncAgent"
    Import-Module .\afsdiag.ps1
    Debug-AFS -OutputDirectory C:\output -KernelModeTraceLevel Verbose -UserModeTraceLevel Verbose
    ```

2. Reproduce the issue. When you finish, enter *D*.
3. A .zip file that contains logs and trace files is saved to the output directory that you specified.

## Common troubleshooting subject areas

For more detailed information, choose the subject area that you'd like to troubleshoot.

- [Agent installation and server registration issues](file-sync-troubleshoot-installation.md)
- [Sync group management (including cloud endpoint and server endpoint creation)](file-sync-troubleshoot-sync-group-management.md)
- [Sync errors](file-sync-troubleshoot-sync-errors.md)
- [Cloud tiering issues](file-sync-troubleshoot-cloud-tiering.md)

Some issues can be related to more than one subject area.

## See also

- [Monitor Azure File Sync](/azure/storage/file-sync/file-sync-monitoring)
- [Troubleshoot Azure Files](files-troubleshoot.md)
- [Troubleshoot Azure Files performance issues](files-troubleshoot-performance.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
