---
title: Windows 365 BCDR Known Issues
description: Learn about known issues that involve Windows 365 disaster recovery, including workarounds and updated fixes.
ms.reviewer: kaushika; aradinger; v-appelgatet
ms.date: 02/12/2026
ms.topic: troubleshooting-known-issue
ms.service: windows-365
ms.custom:
  - pcy:WinComm User Experience
  - sap:Windows 365 Enterprise Edition\Cloud PC Recovery\Disaster Recovery Issues
---
# Windows 365 BCDR known issues

This article addresses a known issue that's related to Windows 365 Business Continuity and Disaster Recovery (BCDR) scenarios.

## Classic Outlook is corrupted after disaster recovery failover or failback

After you restore a Cloud PC from a snapshot during a disaster recovery failover, or upon failing back to the primary region after the disaster, users might encounter an error message when they start classic Outlook.

This issue occurs because the Outlook offline cache becomes corrupted because the client and the server become out of sync during a failover. The client on the snapshot reflects a past state relative to the server's current status. The process of resynchronizing the Offline Storage Table (OST) file can take time.

This process doesn't cause any data loss.

### Workaround

After you complete a failover or failback operation, delete the Cloud PC's OST file.

This action forces Outlook to rebuild the search index and the offline cache of the mailbox. This process doesn't cause any data loss.

### Resolution

Use the new Outlook app. The new Outlook app uses a different caching mechanism that eliminates this synchronization issue.
