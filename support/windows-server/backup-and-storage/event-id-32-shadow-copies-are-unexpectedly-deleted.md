---
title: Event ID 32 occurs and shadow copies are unexpectedly deleted
description: Introduces a workaround for an issue in which shadow copy volume is delayed in being brought online, and shadow copies are unexpectedly deleted. Event ID 32 is received when the issue occurs.
ms.topic: troubleshooting
ms.date: 12/26/2023
ms.reviewer: kaushika, cdascoli, bechinch, khoffman
ms.custom: sap:Backup, Recovery, Disk, and Storage\Volume Shadow Copy Service (VSS) , csstroubleshoot
---
# Event ID 32 occurs, and shadow copies are unexpectedly deleted

This article introduces a workaround for an issue in which shadow copy volume is delayed in being brought online, and shadow copies are unexpectedly deleted. Event ID 32 is received when the issue occurs.

## Symptom

On a server, shadow copies are stored on a different volume. After you restart the server, you find shadow copies are deleted. Additionally, you receive the following event log:

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

This issue occurs because there are multiple phantom shadow copy entries under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\STORAGE\VolumeSnapshot`. It increases the time for the snapshots to be enumerated on the shadow storage volume when the parent volume comes online.

If it takes a long time in the enumeration, volsnap will delete these snapshots.

## Workaround

To work around this issue, use the [devnodeClean.exe tool](https://www.microsoft.com/download/details.aspx?id=42286) to clean up the large buildup of phantom VolumeSnapshots in the registry key under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\STORAGE\VolumeSnapshot`.

> [!NOTE]
> The *devnodeclean.exe* tool will only delete phantom shadow copies. Valid shadow copies will remain intact.

To get the list of entries to be deleted, run the following command:

```console
devnodeclean /n
```

To delete the phantom shadow copies, run the following command:

```console
devnodeclean
```

Additionally, we recommend configuring a `devnodeclean` scheduled task to proactively remove stale entries.
