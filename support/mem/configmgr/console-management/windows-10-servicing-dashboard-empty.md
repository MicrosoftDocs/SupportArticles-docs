---
title: Windows Servicing dashboard shows no data or stale OS versions
description: Troubleshoot the Windows Servicing dashboard when it displays no data or contains stale operating system version information.
author: Cloud-Writer
ms.author: vinpa
ms.reviewer: kaushika, payur
ms.date: 06/24/2026
ms.custom: sap:Configuration Manager Setup, High Availability, Migration and Recovery\Updates and Servicing
---
# The Windows Servicing dashboard shows no data

*Applies to*: Microsoft Configuration Manager

## Symptoms

The [Windows Servicing dashboard](/intune/configmgr/osd/deploy-use/manage-windows-as-a-service) displays no data or contains stale operating system version information.

## Cause

The issue might occur in either of the following situations:

- The service connection point is running in Offline mode.
- The service connection point is running in Online mode, but it can't obtain the Admin UI content payload.

## Resolution

If the service connection point is running in Offline mode, use the [service connection tool](/intune/configmgr/core/servers/manage/use-the-service-connection-tool) to download and import updates that include the Admin UI content payload.

If the service connection point is running in Online mode, review the DmpDownloader.log file for failures that occurred when accessing the ConfigMgr.AdminUIContent.cab payload URL. For troubleshooting steps, refer to [Troubleshoot the Synchronization stage](../setup-migrate-backup-recovery/understand-troubleshoot-updates-servicing.md#troubleshoot-the-synchronization-stage).

To work around the issue, follow these steps:

1. Manually download the ConfigMgr.AdminUIContent.cab file from [https://go.microsoft.com/fwlink/?LinkID=619849](https://go.microsoft.com/fwlink/?LinkID=619849).
1. Copy the ConfigMgr.AdminUIContent.cab file to the top-level site server.
1. Rename the ConfigMgr.AdminUIContent.cab file to ConfigMgr.AdminUIContent.auc.
1. Copy the ConfigMgr.AdminUIContent.auc file to the following directory:

   \<Configuration Manager installation path>\\inboxes\\hman.box\\CFD

   For example, copy the file to E:\ConfigMgr\inboxes\hman.box\CFD\.
1. In Hman.log, you should see entries that resemble the following example:

   ```output
   File 'E:\ConfigMgr\inboxes\hman.box\CFD\ConfigMgr.AdminUIContent.auc' is signed and trusted.
   File 'E:\ConfigMgr\inboxes\hman.box\CFD\ConfigMgr.AdminUIContent.auc' is signed with MS root cert.
   Extracting file E:\ConfigMgr\inboxes\hman.box\CFD\ConfigMgr.AdminUIContent.auc to E:\ConfigMgr\AdminUIContentStaging\~
   Extracted E:\ConfigMgr\AdminUIContentStaging\CAMPServicingStates.xml~
   Extracted E:\ConfigMgr\AdminUIContentStaging\DriverUpdates.xml~
   Extracted E:\ConfigMgr\AdminUIContentStaging\LifecycleProducts.xml~
   Extracted E:\ConfigMgr\AdminUIContentStaging\NotificationBannerData.xml~
   Extracted E:\ConfigMgr\AdminUIContentStaging\UUPPSFXProductsAndOSVersions.xml~
   Extracted E:\ConfigMgr\AdminUIContentStaging\WindowsServicingBusinessReadyUpdates.xml~
   Extracted E:\ConfigMgr\AdminUIContentStaging\WindowsServicingLocalizedNames.xml~
   Extracted E:\ConfigMgr\AdminUIContentStaging\WindowsServicingProductCategoryNames.xml~
   Extracted E:\ConfigMgr\AdminUIContentStaging\WindowsServicingStates.xml~
   Extracted E:\ConfigMgr\AdminUIContentStaging\WindowsServicingTimeline.html~
   Extracted E:\ConfigMgr\AdminUIContentStaging\WindowsServicingXtBusinessReadyUpdates.xml~
   Successfully updated AdminUI content.
   ```

1. Try again to open the Windows Servicing dashboard.
