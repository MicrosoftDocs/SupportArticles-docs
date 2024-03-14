---
title: Upgrade Readiness data is downloaded continuously
description: Describes an issue in which Upgrade Readiness data is downloaded continuously in Configuration Manager, and the download interval becomes 0 minutes.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Client Installation, Registration and Assignment\Client Upgrade
---
# Upgrade Readiness data is downloaded continuously in Configuration Manager

This article helps you resolve an issue in which the Upgrade Readiness data is downloaded continuously in Configuration Manager, and the download interval becomes 0 minutes.

_Original product version:_ &nbsp; Configuration Manager (current branch - version 1810), Configuration Manager (current branch - version 1806), Configuration Manager (current branch - version 1802)  
_Original KB number:_ &nbsp; 4498259

## Symptoms

You integrate Upgrade Readiness with Configuration Manager to access client upgrade compatibility data in Configuration Manager. In this scenario, you may notice that Upgrade Readiness data is downloaded continuously. This causes many ConfigMgr.OMSUpgradeAnalytics_{*date code*}.OMS files to be added to the following folder:

`C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD`

Also, the following entry is logged in DMPDownloader.log:

> OMSUpgradeAnalyticsDownload finished~~  
> OMSUA: Updating LastSyncedTime registry value  
> OMS Upgrade Analytics Download interval is: **every 0 minutes**  

## Cause

The initial download interval of Upgrade Readiness data is set by the following registry value:

`HKEY_LOCAL_MACHINE\Software\Microsoft\SMS\Components\SMS_DMP_DOWNLOADER\OMSUpgradeAnalyticsDownloadInterval`

By default, this registry value is set to **10080 minutes** (7 days). However, the download interval automatically decreases when the SMS_DMP_DOWNLOADER thread runs. When the interval reaches zero (0), Upgrade Readiness data is downloaded continuously.

## Resolution

To fix this issue, update to Configuration Manager current branch version 1902.

## Workaround

To work around this issue without updating, make sure that the following registry value is set to **10080**:

`HKEY_LOCAL_MACHINE\Software\Microsoft\SMS\Components\SMS_DMP_DOWNLOADER\OMSUpgradeAnalyticsDownloadInterval`

Then, restart the SMS_Executive service or the SMS_DMP_DOWNLOADER thread.

> [!NOTE]
> The download interval will continue to automatically decrease when the SMS_DMP_DOWNLOADER thread runs.
