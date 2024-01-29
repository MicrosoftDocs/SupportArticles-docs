---
title: Error 0x80042409 when you perform a Volume Shadow Copy Service restore operation
description: Describes an issue that occurs when you restore a Virtual Machine while another backup that uses the Hyper-V writer is in progress.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:volume-shadow-copy-service-vss, csstroubleshoot
ms.subservice: backup-and-storage
---
# Error message when you perform a Volume Shadow Copy Service restore operation: 0x80042409

This article describes an issue that occurs when you restore a virtual machine while another backup that uses the Hyper-V writer is in progress.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 978773

## Symptoms

You perform a Volume Shadow Copy Service (VSS) backup or a VSS restore operation. During the backup or restore operation, an event that resembles the following is written to the Application log:

> Event ID: 12289  
>
> Volume Shadow Copy Service error: Unexpected error An older writer session state is being removed. . hr = 0x80042409, Writer status is not available for one or more writers. A writer may have reached the limit to the number of available backup-restore session states.  
>
> Operation: PreRestore Event
>
> Context:  
Old snapshot set: {41379de8-f7e7-4c76-bb47-7f080443e189}  
Old operation: 1019  
Old state: 5  
Old failure: 0x800423f4  
Old extended failure hr: 0x1  
Old extended failure message: 0  
Execution Context: Writer  
Writer Class Id: {66841cd4-6ded-4f4b-8f17-fd23f8ddc3de}  
Writer Name: Microsoft Hyper-V VSS  
Writer Writer Instance ID: {7eef8900-84b4-406e-a461-ce19e5e7ae7f}  

## Cause

This error occurs because a backup or restore session state in the VSS writer isn't cleaned up correctly. The VSS writer infrastructure creates session-state objects for each backup and restore session in which a VSS writer participates. Under typical circumstances, the writer session-state objects are cleaned up when they're not being used. Normal session state cleanup occurs under the following circumstances:

- The backup application sends a BackupComplete response and then checks the writer status by sending a GatherWriterStatus.

- The backup application sends a PostRestore response and then checks the writer status by sending a GatherWriterStatus query.

- The writers receive the OnAbort event callback for the session. The OnAbort event callback is invoked when the backup session is explicitly failed by the backup application, by the writer or, by the VSS infrastructure.

The VSS writer infrastructure performs periodic garbage collection of the remaining session states. The infrastructure then logs the previous event log for each session-state object that is older than two days. The event log is intended to help identify abandoned sessions in the writer that may indicate a misbehaving backup application. You can see several similar events in rapid succession from multiple writers that indicate that there was a series of incomplete backup or restore sessions. This behavior is most frequently seen in test environments.

## Workaround

Ignore intermittent occurrences of this error. The related event is logged in response to garbage collection activities that are started by a backup or restore operation. However, these errors aren't related to the active backup or restore session. If the error is consistently reproducible, make sure that the backup application vendor is following all the VSS backup session cleanup guidelines.
