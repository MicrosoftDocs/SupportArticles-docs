---
title: Pull subscriptions do not show up in Windows Synchronization Manager
description: This article provides a workaround for the problem that pull subscriptions are not displaying in Windows Synchronization Manager.
ms.date: 05/26/2021
ms.custom: sap:Replication, Change Tracking, Change Data Capture, Synapse Link
author: aartig13
ms.author: aartigoyle
ms.reviewer: mathoma, tzakir, akbarf, maarumug, brcarrig
---
# Pull subscriptions don't show up in Windows Synchronization Manager

_Applies to:_ &nbsp; SQL Server 2019, SQL Server 2017, SQL Server 2016, SQL Server 2014

## Symptoms

Assume that you [create a pull subscription to a merge publication](/sql/relational-databases/replication/create-a-pull-subscription#to-create-a-pull-subscription-to-a-merge-publication). After enabling the [synchronization with Windows Synchronization Manager](/sql/relational-databases/replication/synchronize-a-subscription-using-windows-synchronization-manager), there's no subscription listed in the Sync Center (mobsync.exe) of the subscriber.

## Workaround

> [!NOTE]
> This workaround applies only to SQL Servers with a single instance.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756).

Here's how to work around this issue:

1. In the search box on the taskbar, type *regedit*, then select **Registry Editor** (Desktop app) from the results to [open Registry Editor in Windows 10](https://support.microsoft.com/windows/how-to-open-registry-editor-in-windows-10-deab38e6-91d6-e0aa-4b7c-8878d9e07b11).

1. Locate and select the registry subkey: `HKLM\Software\Microsoft\Windows\CurrentVersion\SyncMgr\Handlers\{FFAADE58-9A14-45F3-A497-E969A64F09C7}`.

1. Rename the subkey name depending on the SQL Server version as follows:

    SQL Server Version | Registry Handler Value
    :----------------: | :------------------------------------:
    SQL Server 2014    | `D6133761-E626-4DF7-90F6-7DDD8FCCB926`
    SQL Server 2016    | `E828F4BF-6E5C-4549-A3BA-CF53F6A60819`
    SQL Server 2017    | `C96C286D-DFC0-4CF0-9CF8-7D582094D263`
    SQL Server 2019    | `B1544C19-71BD-417C-8DE2-430A0CDCEA06`
