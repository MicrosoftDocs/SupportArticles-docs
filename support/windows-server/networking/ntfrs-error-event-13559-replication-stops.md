---
title: NTFRS error event 13559 intermittently and replication stops
description: Describes a problem where NTFRS runs into a fatal error communicating with the file system sporadically.
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# NTFRS error event 13559 intermittently and replication stops

_Original product version:_ &nbsp; Windows Server 2008 R2 Standard, Windows Server 2008 R2 Enterprise, Windows Server 2008 R2 Datacenter  
_Original KB number:_ &nbsp; 2768745

## Symptom

On various DCs you are receiving 13559 events from the File Replication Service (FRS) similar details:

Log Name: File Replication Service
Source: NtFrs
Event ID: 13559
Task Category: None
Level: Error
Description:  
The File Replication Service has detected that the replica root path has changed from "c:\windows\sysvol\domain" to "c:\windows\sysvol\domain". If this is an intentional move then a file with the name NTFRS_CMD_FILE_MOVE_ROOT needs to be created under the new root path.
This was detected for the following replica set:
 "DOMAIN SYSTEM VOLUME (SYSVOL SHARE)"
Changing the replica root path is a two step process which is triggered by the creation of the NTFRS_CMD_FILE_MOVE_ROOT file.
 [1] At the first poll which will occur in 5 minutes this computer will be deleted from the replica set.
 [2] At the poll following the deletion this computer will be re-added to the replica set with the new root path. This re-addition will trigger a full tree
sync for the replica set. At the end of the sync all the files will be at the new location. The files may or may not be deleted from the old location depending on whether they are needed or not.

This is sample a logging level 4 for ntfrs verbosity, leading to the event 13559 being logged:
<RcsHasReplicaRootPathMoved: S4: > :S: Oid for replica root is 00000000-0000-0000-0000000000000000
<RcsHasReplicaRootPathMoved: S0: > ERROR - Replica root guid mismatch for Replica Set (DOMAIN SYSTEM VOLUME (SYSVOL SHARE))
<RcsHasReplicaRootPathMoved: S0: > ERROR - Replica root guid (FS) (17358178-8dd7-47e5-8ec1642bbc6ba318)
<RcsHasReplicaRootPathMoved: S0: > ERROR - Replica root guid (DB) (17358178-8dd7-47e5-8ec1642bbc6ba318)
<RcsHasReplicaRootPathMoved: S0: > ERROR - Replica Set (DOMAIN SYSTEM VOLUME (SYSVOL SHARE)) is marked to be deleted

We have also seen cases where the File System GUID is reported as NULL on the second debug print:
<RcsHasReplicaRootPathMoved: S4: > :S: Oid for replica root is 00000000-0000-0000-0000000000000000
<RcsHasReplicaRootPathMoved: S0: > ERROR - Replica root guid mismatch for Replica Set (DOMAIN SYSTEM VOLUME (SYSVOL SHARE))
<RcsHasReplicaRootPathMoved: S0: > ERROR - Replica root guid (FS) (00000000-0000-0000-0000000000000000)
<RcsHasReplicaRootPathMoved: S0: > ERROR - Replica root guid (DB) (17358178-8dd7-47e5-8ec1642bbc6ba318)
<RcsHasReplicaRootPathMoved: S0: > ERROR - Replica Set (DOMAIN SYSTEM VOLUME (SYSVOL SHARE)) is marked to be deleted

You have to enable logging level 4 to be positive that you are affected by this problem.

## Cause

At the polling cycle the GUID for the root folder returned from NTFS doesn't not match what is expected. The GUID of the volue is seen as "00000000-0000-0000-0000000000000000". Although FRS uses synchronous IO, the NTFS IO control is working asynchronously. So in the problem cases, the IO control returned "STATUS_PENDING", but this status is not used correctly by NTFRS.

## Resolution

NTFRS is only needed to support Windows Server 2003 Domain Controllers. Since support for Windows Server 2003 ends in July 2015, it is strongly recommended to remove these Domain Controllers completely, and migrate to a newer version of Windows.

Newer versions of Windows allow the use of DFS-R to replicate SYSVOL, and these are not affected by this problem.

There are these work-arounds:

1. Create a task that is triggered by Event 13559 and restart the service  

Create a script triggered on the event 13559 that restarts the NTFRS service, follow these steps:

a) In Event Viewer, find a even 13559 and right-Click it. There is an entry "Attach Task To This Event...":
![Sample Event, create Task ](./media/ntfrs-error-event-13559-replication-stops/2973719.JPG)

b) You will be taken to the "Create new Basic Task wizard, and the options to run the task based on the event you have selected will be pre-populated. So you can walk many of the wizard pages.

c) You need to specify the task action, to start a program:
![Select Task action ](./media/ntfrs-error-event-13559-replication-stops/2973720.JPG)

d) As the task, have a short script that restarts NTFRS:
![Example Script ](./media/ntfrs-error-event-13559-replication-stops/2973721.JPG)

e) Specify the script as the program to start:
![Start action for task ](./media/ntfrs-error-event-13559-replication-stops/2973722.JPG)

f) This approach will resume the operations of NTFRS without performing an authoritative restore.

2. Put empty file " NTFRS_CMD_FILE_MOVE_ROOT " into the root of the replica  

When seeing the mismatch with the GUIDs, NTFRS checks the precense of this file to see whether it might have been intentional. If it finds the file, it logs event 13560 and commences to do a non-authoritative restore of NTFRS.

For SYSVOL place it in the target folder for the junction in the SYSVOL share, e.g. c:\windows\sysvol\domain.

Note that during the non-authoritative restore, it will take the SYSVOL and NETLOGON share offline and netlogon will stop. If the DC is the only DC in a site, that might not be acceptable.

## More Information

Please find guides on SYSVOL migration here:
 [https://technet.microsoft.com/library/dd640019(v=WS.10).aspx](https://technet.microsoft.com/library/dd640019%28v=ws.10%29.aspx) 

This blog has a FAQ on the migration and an illustrated guide on the topic:
 [http://blogs.technet.com/b/askds/archive/2009/01/05/dfsr-sysvol-migration-faq-useful-trivia-that-may-save-your-follicles.aspx](http://blogs.technet.com/b/askds/archive/2009/01/05/dfsr-sysvol-migration-faq-useful-trivia-that-may-save-your-follicles.aspx)
