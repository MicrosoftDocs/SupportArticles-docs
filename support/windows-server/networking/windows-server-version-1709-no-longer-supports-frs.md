---
title: Windows Server version 1709 no longer supports FRS
description: Discusses that Windows Server 2016 RS3 no longer supports the File Replication Service (FRS). Provides a workaround.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Windows Server version 1709 no longer supports FRS

_Original product version:_ &nbsp;   
_Original KB number:_ &nbsp; 4025991

## Summary

Windows Server version 1709 can no longer be added as an Active Directory domain controller (DC) to an existing domain that is still using File Replication Service (FRS) for replication of the SYSVOL share.When you try to add a Windows Server version 1709-based server as a DC to the domain, you receive the following error message:
The specified domain %1 is still using the File Replication Service (FRS) to replicate the SYSVOL share. FRS is deprecated.

The server being promoted does not support FRS and cannot be promoted as a replica into the specified domain.

You MUST migrate the specified domain to use DFS Replication using the DFSRMIG command before continuing.

For more information, see https://go.microsoft.com/fwlink/?linkid=849270.

## Workaround

The replacement for FRS is the Distributed File System Replication (DFSR). To work around this issue, migrate the existing domain to DFSR replication. The following articles describe in more detail how to make this change:
- [SYSVOL Replication Migration Guide: FRS to DFS Replication](https://technet.microsoft.com/library/dd640019%28v=WS.10%29.aspx) 
- [Streamlined Migration of FRS to DFSR SYSVOL](https://blogs.technet.microsoft.com/filecab/2014/06/25/streamlined-migration-of-frs-to-dfsr-sysvol/) 

## References

For more information, see the following Server and Tools Blog article:
 [The End is Nigh (for FRS)](https://blogs.technet.microsoft.com/filecab/2014/06/25/the-end-is-nigh-for-frs/)
