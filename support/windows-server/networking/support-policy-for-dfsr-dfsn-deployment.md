---
title: Unsupported DFS-R and DFS-N deployment scenario
description: This article describes a DFS-R and DFS-N deployment scenario that Microsoft does not support.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, luche
ms.custom: sap:dfsr, csstroubleshoot
---
# Information about Microsoft support policy for a DFS-R and DFS-N deployment scenario

This article describes a Distributed File System Replication (DFS-R) and Distributed File System Namespace (DFS-N) deployment scenario that Microsoft does not support.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2533009

## Unsupported scenario

When you deploy DFS-R and DFS-N together with user home folders or with roaming user profiles, the following scenario is not supported by Microsoft:  

- You deploy a single file server for each branch office. User home folders and roaming user profiles of users in the branch office are stored on the branch office file server.
- You use DFS-R over WAN links from multiple branch office file servers to a central hub server for centralized backup. You configure the hub server with read-only replicated folders or read/write replicated folders.
- You configure a DFS namespace to create a unified namespace.
- You configure one namespace folder to have multiple folder targets. And, you add the shared folder of the central file server as a second DFS-N folder target. You enable all namespace folder targets, or you enable only one folder target at a time.
- You configure the target priority of DFS-N so that the client refers to the branch office file server first. When the branch office file server is not available, the client will be redirected to the central file server. You may also specify that roaming users be directed to a file server that contains their user data or user profile and that is closest to their physical location.

> [!NOTE]
> Although this scenario cites home folders and roaming user profiles as specific content examples, the same issue applies to any fast-changing content that may not have been replicated to a replication partner when the referral redirects the user from a different partner to that partner. Additionally, the "central" file server and "branch office" file server are examples, any similar deployment configurations are equally susceptible to the problems outlined in this article. Therefore, they are not supported by Microsoft. A similar deployment example is that two branch office servers replicate fast-changing content between one another.

## Technical reasons that Microsoft does not support the scenario

We do not support the deployment scenario for the following reasons:  

- User home folders or user profiles that are replicated by using DFS-R between the branch office file servers and the central file server may not be up to date. The issue may occur for one of the following reasons:
  - Large replication backlogs
  - Heavy system load
  - Bandwidth throttling
  - Replication schedules
- DFS-R does not perform transactional replication of user profile data. A transactional replication either replicates all changes to a user profile or replicates nothing at all. Therefore, some files of a user profile may have been replicated, whereas other files may not have been replicated before the user was failed over to the central file server.
- The client computer may be failed over to the central file server by the DFS-N client in one of the following scenarios:
  - There are transient network glitches when the client computer accesses data over Server Message Block (SMB) from the branch office file server.
  - There are specific error codes when the client computer accesses data over SMB from the branch office file server. The redirection may occur even when the branch office file server is available. Therefore, a user may be redirected to the central file server even if you configure the target referral priority of the branch office file server at a higher level.

## Potential data consistency or data staleness issues that may occur in the unsupported scenario

If the replicated folder of the central file server is a read/write replica, one of the following issues may occur:  

- Roaming user profiles may be corrupted because all the changes that were made by the users during their last logon may not have been replicated to the central file server. Therefore, the users may change a stale or an incomplete copy of the roaming profile during their next logon. This may cause user profile corruption.
- A user may experience data loss or data corruption because the data on the central file server may be stale or out-of-sync with the data on the branch office file server. The user data becomes stale because the latest modification of the user data is not yet replicated.
- When a user edits a stale copy of the user data on the central file server, the data on the central file server will overwrite the fresher data on the branch office file server. This issue occurs because DFS-R is a multi-master replication engine that uses a conflict-resolution heuristic of last writer wins for files that are in conflict. If the replicated folder of the central file server is a read-only replica, one of the following issues may occur:
- When a user is directed to the central file server, applications and users will be unable to change files that are stored in the shared folder. The user will be confused because a file that can be changed before suddenly becomes read-only.
- When a user is directed to the central file server, the roaming user profile may be corrupted because all changes that were made by the user during his last logon may not have been replicated to the central file server. Additionally, the roaming user profiles infrastructure cannot write back any changes to the profile when the user is logged off.
- A user may experience data loss or data corruption because the data on the central file server may be stale or out-of-sync with the data on the branch office file server. The user data becomes stale because the latest modification of the user data is not replicated. Additionally, users will notice synchronization errors or conflicts of files that are changed on their computers. Users cannot resolve the conflicts because the replicated folder is read-only.
