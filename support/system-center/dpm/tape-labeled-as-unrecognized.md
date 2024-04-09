---
title: Tape is labeled as Unrecognized in DPM
description: Fixes an issue in which tapes are labeled as Unrecognized after you add a tape to the tape library in System Center Data Protection Manager.
ms.date: 04/08/2024
ms.reviewer: Mjacquet
---
# Tape labeled as Unrecognized in System Center Data Protection Manager

This article helps you resolve an issue in which a tape is labeled as **Unrecognized** after you add the tape to the tape library in System Center Data Protection Manager (DPM).

_Original product version:_ &nbsp; System Center 2016 Data Protection Manager, System Center 2012 R2 Data Protection Manager, System Center 2012 Data Protection Manager, System Center Data Protection Manager 2010  
_Original KB number:_ &nbsp; 4051995

## Symptom

After you add a tape to the tape library, **Unrecognized** is displayed as the tape label in System Center Data Protection Manager. Therefore, you can't recover data from the tape.

## Cause

The issue may occur for any of the following reasons:

- The tape contains content that was not created by DPM.
- The tape is associated with a protection group whose name contains special characters, such as `|`, `/`, `(`, `)` and `.`.
- The tape is damaged.

## Resolution

If the tape contains content that was not created by DPM, use third-party software to recover the data. Or, you can just erase the tape and reuse it.

Check the protection group name, and make sure that it doesn't contain any special characters. For more information, see [Tapes are labeled as "Unrecognized" after just previously writing to them and removing them from the library](https://techcommunity.microsoft.com/t5/system-center-blog/dpm-2007-tapes-are-labeled-as-8220-unrecognized-8221-after-just/ba-p/341834).
