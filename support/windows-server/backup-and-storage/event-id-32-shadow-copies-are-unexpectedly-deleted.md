---
title: Event ID 32 occurs and shadow copies are unexpectedly deleted
description: Introduces a workaround for an issue in which shadow copy volume is delayed to be brought online, and shadow copies are unexpectedly deleted. Event ID 32 is received when the issue occurs.
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
ms.date: 5/20/2023
ms.prod: windows-server
ms.reviewer: kaushika, cdascoli, bechinch, khoffman
ms.technology: windows-server-backup-and-storage
ms.custom: sap:volume-shadow-copy-service-vss, csstroubleshoot
---
# Event ID 32 occurs and shadow copies are unexpectedly deleted

This article introduces a workaround for an issue in which shadow copy volume is delayed to be brought online, and shadow copies are unexpectedly deleted. Event ID 32 is received when the issue occurs.

## Symptom

On a server, shadow copies are stored on a different volume. After you restart the server, you found shadow copies are deleted. Additionally, you receive the following event log:

```output
Log Name:      System
Source:        volsnap
Event ID:      32
Task Category: None
Level:         Error
Keywords:      Classic
User:          N/A
Description:
The shadow copies of volume X: were aborted because the shadow copy storage volume was not present.
```

You may notice delays in bringing the shadow copy volume online. 

## Cause

This issue occurs because there are multiple phantom shadow copy entries under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\STORAGE\VolumeSnapshot`. It increases the time for the snapshots being enumerated on the shadow storage volume when the parent volume comes online.

If it takes a long time in the enumeration, volsnap will delete these snapshots.

## Workaround

To work around this issue, use the [devnodeClean.exe tool](https://www.microsoft.com/download/details.aspx?id=42286) to clean up the large buildup of phantom VolumeSnapshots in registry key under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\STORAGE\VolumeSnapshot`.

> [!NOTE]
> The devnodeclean.exe tool will only delete phantom shadow copies, valid shadow copies will remain intact.

To get the list of entries to be deleted, run the following command:

```console
devnodeclean /n
```

To delete the phantom shadow copies, run the following command:

```console
devnodeclean
```

Additionally, we recommend configuring a devnodeclean scheduled task to proactively remove stale entries.
