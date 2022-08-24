---
title: Dynamics GP crashes if emailing with MAPI after updating Office
description: Microsoft Dynamics GP crashes when emailing with MAPI after applying Microsoft Office update.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Microsoft Dynamics GP crashes when emailing with MAPI after applying a Microsoft Office update

You can send Word template emails successfully using MAPI in Microsoft Dynamics GP. However, after applying a Microsoft Office update, the emails would no longer send and it causes Microsoft Dynamics GP to crash.

> [!NOTE]
> This issue was found on Microsoft Dynamics GP 2013 with Microsoft Office 2010.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4038605

## Resolution

The recommended resolution is to apply the latest service pack/highest version of Outlook for their version, or upgrade their Office version.

> [!NOTE]
> Applying the most recent patch update for Microsoft Office 2010 resolved the issue.
