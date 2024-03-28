---
title: Hotfixes for DFS technologies
description: Lists the currently available hotfixes for Distributed File System (DFS) technologies in Windows Server 2012 and Windows Server 2012 R2.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# List of currently available hotfixes for Distributed File System (DFS) technologies in Windows Server 2012 and Windows Server 2012 R2

This article lists the hotfixes that are currently available for users who have installed Distributed File System (DFS) technologies on a Windows Server 2012-based computer or a Windows Server 2012 R2-based computer.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2951262

## Summary

This Microsoft Knowledge Base articles that are listed in this article describe the available fixes. If you have installed DFS technologies on a Windows Server 2012-based computer or a Windows Server 2012 R2-based computer, we recommend that you review and install the hotfixes that are described in [More information](#more-information).

Note. The two technologies in DFS are DFS Namespaces (DFS-N) and DFS Replication (DFS-R).

A servicing approach of installing the monthly rollups provides customers with a consistent model for staying current and secure. You may substitute a more recent monthly rollup for an older monthly rollup. The remainder of the updates in this list are still required because some components in those updates were released prior to October 2016 and aren't included in a more recent monthly rollup. For more information about this servicing approach, see [Simplified servicing for Windows 7 and Windows 8.1: the latest improvements](https://techcommunity.microsoft.com/t5/windows-blog-archive/simplified-servicing-for-windows-7-and-windows-8-1-the-latest/ba-p/166798).

## Windows Server 2012 R2

You can get the latest fixes for these DFS components by installing the following updates:

- [KB 4056895: January 8, 2018-KB4056895 (Monthly Rollup) or later](https://support.microsoft.com/help/4056895)
- [KB 2996883: DFSR stops replication after an unexpected shutdown in a Windows 8.1 or Windows Server 2012 R2 environment](https://support.microsoft.com/help/2996883)
- [KB 3000850: November 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2](https://support.microsoft.com/help/3000850)
- [KB 3046481: DFS Namespaces deployment causes slow access or access time-out when you access DFS share in Windows Server 2012 R2](https://support.microsoft.com/help/3046481)

## Windows Server 2012

You can get the latest fixes for these DFS components by installing the following updates:

- [KB 4025331: July 11, 2017-KB4025331 (Monthly Rollup) or later](https://support.microsoft.com/help/4025331)
- [KB 2884176: Large backlogs on Windows -based DFSR servers](https://support.microsoft.com/help/2884176)
- [KB 2962407: Windows RT, Windows 8, and Windows Server 2012 update rollup: June 2014](https://support.microsoft.com/help/2962407)

## More information

> [!NOTE]
> Some of the following tables contain blank cells to accommodate information that will be supplied later.

### DFS namespaces

#### Windows Server 2012 R2

|Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
|---|---|---|---|---|
|April 15, 2020| [4056895](https://support.microsoft.com/help/4056895)|January 8, 2018-KB4056895 (Monthly Rollup)|This monthly rollup contains the 6.3.9600.18895 version of Dfsc.sys. (client-side).|Included in [January 3, 2018-KB4056898 (Security-only update)](https://support.microsoft.com/help/4056898).Included in [January 8, 2018-KB4056895 (Monthly Rollup) and later](https://support.microsoft.com/help/4056895) monthly rollups.|
|Mar 06, 2015| [3046481](https://support.microsoft.com/help/3046481)|DFS Namespaces deployment causes slow access or access time-out when you access DFS share in Windows Server 2012 R2.|This hotfix contains the most current version of Dfssvc.exe for Windows Server 2012 R2.|To install this update, you must have Windows Server 2012 R2 installed.|

#### Windows Server 2012

|Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
|---|---|---|---|---|
|April 15, 2020| [3192406](https://support.microsoft.com/help/3192406)|October 2016 Preview of Monthly Quality Rollup for Windows Server 2012|This monthly rollup contains the 6.2.9200.21968 version of Dfssvc.exe and the 6.2.9200.21976 version of Dfsc.sys for Windows Server 2012.|Included in October 2016 Preview of Monthly Quality Rollup for Windows Server 2012 and later monthly rollups.|

### DFS replication

#### Windows Server 2012 R2

|Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
|---|---|---|---|---|
|April 15, 2020| [4038774](https://support.microsoft.com/help/4038774)|September 19, 2017-KB4038774 (Preview of Monthly Rollup)|This monthly rollup contains the 6.3.9600.18776 version of Dfsrs.exe for Windows Server 2012 R2.|Included in September 19, 2017-KB4038774 (Preview of Monthly Rollup) and later monthly rollups.|
||Not applicable||This hotfix contains the most current version of Dfsrro.sys for Windows Server 2012 R2.|To install this hotfix, you must have Windows Server 2012 R2 installed.|
||Not applicable||This hotfix contains the most current version of Dfsrclus.dll for Windows Server 2012 R2.| |
|August 31, 2014| [2996883](https://support.microsoft.com/help/2996883)|DFSR stops replication after an unexpected shutdown in a Windows 8.1 or Windows Server 2012 R2 environment|This hotfix contains the most current versions of Dfsrdiag.exe and Dfsrmig.exe for Windows Server 2012 R2.|To apply this hotfix, you must be running Windows Server 2012 R2 and April 2014 Update [2919355](https://support.microsoft.com/help/2919355).|

#### Windows Server 2012

|Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
|---|---|---|---|---|
|February 14, 2015| [2884176](https://support.microsoft.com/help/2884176)|Large backlogs on Windows-based DFSR servers|This hotfix contains the most current version of Dfsrs.exe and Dfsrress.dll for Windows Server 2012.|To install this hotfix, you must have Windows Server 2012 installed. This hotfix is available for individual download.|
|Jan-10 2016| [3121255](https://support.microsoft.com/help/3121255)|0x00000024 Stop error in FsRtlNotifyFilterReportChange and VSS backup of PI Data server fails in Windows|This hotfix contains an update for Ntfs.sys for Windows Server 2012.|To install this hotfix, you must have Windows Server 2012 installed. This hotfix is available for individual download. This hotfix is also included in [July 11, 2017-KB4025331 (Monthly Rollup) and later](https://support.microsoft.com/help/4025331) monthly rollups.|

#### DFS replication - Sysvol migration

|Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
|---|---|---|---|---|
||Not applicable||This hotfix contains the most current versions of Dfsrdiag.exe and Dfsrmig.exe for Windows Server 2012.|To install this hotfix, you must have Windows Server 2012 installed.|

### Robocopy

#### Windows Server 2012 R2

|Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
|---|---|---|---|---|
|18-Nov-2014| [3000850](https://support.microsoft.com/help/3000850)|November 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2|This hotfix contains the most current version of Robocopy.exe.<br/><br/>Robocopy can be used to pre-seed data for new replicated folders and is also used during the migration of Sysvol from FRS to DFSR.|To install this update rollup, you must have Windows Server 2012 R2 installed and April 2014 Update [2919355](https://support.microsoft.com/help/2919355).|

#### Windows Server 2012

|Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
|---|---|---|---|---|
|May 16, 2014| [2962407](https://support.microsoft.com/help/2962407)|Windows RT, Windows 8, and Windows Server 2012 update rollup: June 2014|This hotfix contains the most current version of Robocopy.exe.<br/><br/>Robocopy can be used to pre-seed data for new replicated folders and is also used during the migration of Sysvol from FRS to DFSR.|To install this hotfix, you must have Windows 8 or Windows Server 2012 installed.|

#### DFS-related registry subkeys that were introduced in hotfixes or security updates

|Date|Knowledge Base article|Registry subkey|
|---|---|---|
|January 21, 2012| [KB 2663685](https://support.microsoft.com/help/2663685)| `HKLM\System\CurrentControlSet\Services\DFSR\Parameters\StopReplicationOnAutoRecovery/strong>`|
|November 18. 2009| KB 967326| `HKLM\System\CurrentControlSet\Services\DFSR\Parameters\Settings\RpcContextHandleTimeoutMs`|

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## References

- [KB 968429: List of currently available hotfixes for Distributed File System (DFS) technologies in Windows Server 2008 and in Windows Server 2008 R2](https://support.microsoft.com/help/968429)
- [KB 2473205: List of currently available hotfixes for the File Services technologies in Windows Server 2008 and in Windows Server 2008 R2](https://support.microsoft.com/help/2473205)
- [KB 2899011: List of currently available hotfixes for the File Services technologies in Windows Server 2012 and in Windows Server 2012 R2](https://support.microsoft.com/help/2899011)
