---
title: DFSR Health Report shows Event ID 4302
description: Describes a problem that occurs when you run the DFSR Diagnostics Report (DFSR Health Report). Many entries of Event ID 4302 are reported even though the files have already been replicated.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rolandw, clandis
ms.custom: sap:dfsr, csstroubleshoot
---
# DFSR Diagnostics Report shows sharing violations events in Windows Server even though the files have already been replicated

This article provides a workaround for an issue where DFSR Diagnostics Report shows sharing violations events even though the files have already been replicated.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 973836

## Symptoms

When you run the Distributed File System Replication (DFSR) Diagnostics Report (DFSR Health Report) on a Microsoft Windows Server 2008-based computer or on a Windows Server 2003-based computer, the report contains many entries for the sharing violations events. However, when you check the files on the replication partner, you find that the files have already been replicated.

## Cause

This issue occurs in the current implementation of DFSR because no anti-events are triggered when the files are replicated. Therefore, the reporting state of the files remains as sharing violated.

## Workaround

To determine the real state of the file, use the `DFSRDIAG BACKLOG` command to check for sharing violations. The command output provides a list of the first 100 files that are not replicated.

## More information

There two kinds of DFSR events for sharing violations: Event ID 4302 and Event ID 4304. The DFSR Diagnostics combines both kinds of events, and reports them only as Event ID 4302.

The following information explains more about these two kinds of events.

Event ID 4302: A local sharing violation occurs when the service can't receive an updated file because the local file is being used. This occurs on the *receive* side of the file change. The file is already replicated. However, it can't be moved from the installing directory to the final destination.

Event ID 4304: The service can't stage a file for replication because of a sharing violation. This occurs on the "send" side of the file change. DFSR wants to stage or copy the file for replication. However, an exclusive lock prevents this.
