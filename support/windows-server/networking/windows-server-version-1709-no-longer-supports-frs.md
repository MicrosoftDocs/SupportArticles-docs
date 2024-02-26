---
title: Windows Server version 1709 no longer supports FRS
description: Discusses that Windows Server 2016 RS3 no longer supports the File Replication Service (FRS). Provides a workaround.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:frs, csstroubleshoot
---
# Windows Server version 1709 no longer supports FRS

This article discusses that Windows Server version 1709 no longer supports the File Replication Service (FRS).

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4025991

## Summary

Windows Server version 1709 can no longer be added as an Active Directory domain controller (DC) to an existing domain that is still using File Replication Service (FRS) for replication of the SYSVOL share.

When you try to add a Windows Server version 1709-based server as a DC to the domain, you receive the following error message:

> The specified domain %1 is still using the File Replication Service (FRS) to replicate the SYSVOL share. FRS is deprecated.  
> The server being promoted does not support FRS and cannot be promoted as a replica into the specified domain.  
> You MUST migrate the specified domain to use DFS Replication using the DFSRMIG command before continuing.  
> For more information, see `https://go.microsoft.com/fwlink/?linkid=849270`.

## Workaround

The replacement for FRS is the Distributed File System Replication (DFSR). To work around this issue, migrate the existing domain to DFSR replication. The following articles describe in more detail how to make this change:

- [Migrate SYSVOL replication to DFS Replication](/windows-server/storage/dfs-replication/migrate-sysvol-to-dfsr)
- [Streamlined Migration of FRS to DFSR SYSVOL](https://techcommunity.microsoft.com/t5/storage-at-microsoft/streamlined-migration-of-frs-to-dfsr-sysvol/ba-p/425405)

## References

[The End is Nigh (for FRS)](https://techcommunity.microsoft.com/t5/storage-at-microsoft/the-end-is-nigh-for-frs-8211-updated-for-ws2016/ba-p/425379)
