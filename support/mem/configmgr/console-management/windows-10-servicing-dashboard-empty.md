---
title: No data in the Windows 10 servicing dashboard
description: After you upgrade to Configuration Manager version 2103, no data appears in the Windows 10 servicing dashboard.
author: helenclu
ms.author: vinpa
ms.reviewer: kaushika, vinpa
ms.date: 12/05/2023
---
# The Windows 10 servicing dashboard shows no data

*Applies to*: Configuration Manager current branch version 2103

## Symptoms

After you upgrade to Microsoft Endpoint Configuration Manager version 2103, the [Windows 10 servicing dashboard](/mem/configmgr/osd/deploy-use/manage-windows-as-a-service#bkmk_2103-dashboard) doesn't show any data.

## Cause

The issue might occur in either of the following situations:

- The service connection point is running in Offline mode.
- The service connection point is running in Online mode, but it can't obtain the Admin UI content payload.

## Resolution

If the service connection point is running in Offline mode, use the [service connection tool](/mem/configmgr/core/servers/manage/use-the-service-connection-tool) to download and import updates that include the Admin UI content payload.

If the service connection point is running in Online mode, review DmpDownloader.log for failures that occur when accessing the payload URL. To work around the issue, follow these steps:

1. Download the *ConfigMgr.AdminUIContent.cab* file from [https://go.microsoft.com/fwlink/?LinkID=619849](https://go.microsoft.com/fwlink/?LinkID=619849).
2. Copy the ConfigMgr.AdminUIContent.cab file to the top-level site server.
3. Rename the *ConfigMgr.AdminUIContent.cab* file to *ConfigMgr.AdminUIContent.auc*.
4. Copy the *ConfigMgr.AdminUIContent.auc* file to the following directory:

     `<Configuration Manager installation path>\inboxes\hman.box\CFD`

   For example, copy the file to `C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD`.
5. In Hman.log, you should see entries that resemble the following example:

    :::image type="content" source="media/windows-10-servicing-dashboard-empty/hman-log.png" alt-text="Screenshot of the example entries in Hman.log.":::
6. Try again to open the Windows 10 servicing dashboard.
