---
title: Windows 365 BCDR Known Issues
description: This article provides troubleshooting steps for the recent known issues with Windows 365 disaster recovery
ms.reviewer: kaushika; aradinger
ms.date: 10/16/2025
ms.topic: troubleshooting-known-issue
ms.service: windows-365
ms.custom:
  - pcy:WinComm User Experience
  - sap:Windows 365 Enterprise Edition\Cloud PC Recovery\Disaster Recovery Issues
---
# Windows 365 BCDR known issues

## Summary

This article addresses a known issue that's related to Windows 365 Business Continuity and Disaster Recovery (BCDR) scenarios.

## Classic Outlook is corrupted after disaster recovery failback and failover

This issue occurs when the Outlook offline cache becomes corrupted after restoring a Cloud PC from a snapshot during a disaster recovery failover or upon failing back to the primary region post-disaster. Users may encounter an error message when starting Outlook.

The root cause lies in the synchronization process between the client and server. During a failover, the client and server become out of sync because the client on the snapshot reflects a past state relative to the server's current status. Although no data is lost, the process of re-synchronizing the Offline Storage Table (OST) file can take time.

### Workaround

After you complete a failover or failback operation, delete the Cloud PC's OST file. 

This action forces Outlook to rebuild the search index and the offline cache of the mailbox. No user data is lost during this process.

### Resolution

Switch to the new Outlook app. The new Outlook app uses a different caching mechanism that eliminates this synchronization issue.
