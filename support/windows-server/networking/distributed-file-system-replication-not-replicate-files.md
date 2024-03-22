---
title: DFSR no longer replicates files
description: Discusses an issue where the DFS Replication service doesn't replicate files after restoring a virtualized server's snapshot.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dfsr, csstroubleshoot
---
# DFSR no longer replicates files after restoring a virtualized server's snapshot

This article discusses an issue where the Distributed File System Replication (DFSR) service fails to replicate files after restoring a virtualized server's snapshot.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2517913

## Symptoms

Using any virtualization product, you create a guest snapshot of a server replicating files with DFSR. You later restore that snapshot, returning the server to an earlier point in time.

You notice the following behaviors on the restored server:

- No files replicate inbound or outbound for several minutes, then DFSR events **5014** and **5004** are logged indicating replication is resuming.
- Any files created, deleted, or modified after the snapshot was taken but prior to restoration replicate inbound.
- Any files created, deleted, or modified after the restoration don't replicate outbound.
- Any changes to files on partner servers will replicate inbound, regardless of up-to-dateness, overwriting all changes made locally and potentially deleting newer data.
- After a period of time, the DFSR databases will write errors and warnings in the event log and rebuild automatically. After the rebuild completes successfully, DFSR will again log internal errors and rebuild the database. This will continue infinitely.

    > Log Name:      DFS Replication  
    Source:        DFSR  
    Date:          *\<DateTime>*  
    Event ID: **2212**  
    Task Category: None  
    Level:         Warning  
    Keywords:      Classic  
    User:          N/A  
    Computer:      `2008r2-06-f.contoso.com`  
    Description:  
    The DFS Replication service has detected an unexpected shutdown on volume C:. This can occur if the service terminated abnormally (due to a power loss, for example) or an error occurred on the volume. The service has automatically initiated a recovery process. The service will rebuild the database if it determines it cannot reliably recover. No user action is required.
    >
    > Additional Information:  
    Volume: C:  
    GUID: *\<GUID>*  
    Log Name:      DFS Replication  
    Source:        DFSR  
    Date:          *\<DateTime>*  
    Event ID: **2104**  
    Task Category: None  
    Level:         Error  
    Keywords:      Classic  
    User:          N/A  
    Computer:      `2008r2-06-f.contoso.com`  
    Description:  
    The DFS Replication service failed to recover from an internal database error on volume C:. Replication has been stopped for all replicated folders on this volume.
    >
    > Additional Information:  
    Error: 9214 (Internal database error (-1605))  
    Volume: 92404560-E6C8-11DF-BCA2-806E6F6E6963  
    Database: C:\System Volume Information\DFSR  
    Log Name:      DFS Replication  
    Source:        DFSR  
    Date:          *\<DateTime>*  
    Event ID: **2004**  
    Task Category: None  
    Level:         Error  
    Keywords:      Classic  
    User:          N/A  
    Computer:      `2008r2-06-f.contoso.com`  
    Description:  
    The DFS Replication service stopped replication on volume C:. This failure can occur because the disk is full, the disk is failing, or a quota limit has been reached. This can also occur if the DFS Replication service encountered errors while attempting to stage files for a replicated folder on this volume.
    >
    > Additional Information:  
    Error: 9014 (Database failure)  
    Volume: 92404560-E6C8-11DF-BCA2-806E6F6E6963  
    Log Name:      DFS Replication  
    Source:        DFSR  
    Date:          *\<DateTime>*  
    Event ID: **2106**  
    Task Category: None  
    Level:         Information  
    Keywords:      Classic  
    User:          N/A
    Computer:      `2008r2-06-f.contoso.com`  
    Description:  
    The DFS Replication service successfully recovered from an internal database error on volume C:. Replication has resumed on replicated folders on this volume.
    >
    > Additional Information:  
    Volume: 92404560-E6C8-11DF-BCA2-806E6F6E6963  
    Database: C:\System Volume Information\DFSR  

Any servers that replicate with the restored computer will repeatedly show in their %systemroot%\debug\dfsr*.log files:

> 20110302 11:05:26.068 1192 INCO  7487   InConnection::RestartSession Retrying establish contentset session. connId:{1B7F0404-6B47-4575-97CE-B107D9DEE1FE} csId:{E027985A-B48E-4B96-9F65-23D3EAADE871} csName:snaprf  
20110302 11:05:26.068 1192 INCO  1042 [WARN]  SessionTask::Step (Ignored) Failed, should have already been processed. Error:  
\+ [Error:9027(0x2343) InConnection::EstablishSession inconnection.cpp:6172 1192 C A failure was reported by the remote partner]  
\+ [Error:9027(0x2343) DownstreamTransport::EstablishSession downstreamtransport.cpp:4200 1192 C A failure was reported by the remote partner]  
\+ [Error:9027(0x2343) DownstreamTransport::EstablishSession downstreamtransport.cpp:4179 1192 C A failure was reported by the remote partner*]  
\+ [Error:9028(0x2344) DownstreamTransport::EstablishSession downstreamtransport.cpp:4179 1192 C The content set was not found]  
20110302 11:07:26.080 1192 DOWN  4186 [ERROR]   DownstreamTransport::EstablishSession Failed on connId:{1B7F0404-6B47-4575-97CE-B107D9DEE1FE} csId:{E027985A-B48E-4B96-9F65-23D3EAADE871} rgName:snapshotrg Error:  
\+ [Error:9027(0x2343) DownstreamTransport::EstablishSession downstreamtransport.cpp:4179 1192 C A failure was reported by the remote partner]  
\+ [Error:9028(0x2344) DownstreamTransport::EstablishSession downstreamtransport.cpp:4179 1192 C The content set was not found]

## Cause

Snapshots aren't supported by the DFSR database or any other Windows multi-master databases. This lack of snapshot support includes all virtualization vendors and products. DFSR doesn't implement USN rollback quarantine protection like Active Directory Domain Services.

Under no circumstances should you create or restore snapshots of computers running DFSR on read-write members in a production environment.

Snapshot restore is only supported for read-only members as their version vector isn't tracked on partners and a USN rollback can't happen.

## Resolution

To resolve this issue, contact Microsoft Support. The resolution involves special database recovery steps that can be used to fix the affected server without impacting other computers.

Recreating the replication group or replicated folder will *not* fix the issue on the restored server and shouldn't be used as a troubleshooting step.

## More information

For more information around snapshots and USN rollback protection, review:

- [Hyper-V Virtual Machine Snapshots: FAQ](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd560637(v=ws.10))
- [USN and USN Rollback](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd348479(v=ws.10))
