---
title: Hotfixes for File Services technologies
description: This article lists the hotfixes that are currently available for users who have installed the File Services technologies on a Windows Server 2012-based computer or on a Windows Server 2012 R2-based computer.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: WalterE, cpuckett, kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
ms.subservice: networking
---
# List of currently available hotfixes for the File Services technologies

This article lists the hotfixes that are currently available for users who have installed the File Services technologies on a Windows Server 2012-based computer or a Windows Server 2012 R2-based computer.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2899011

## Summary

File Services provides technologies that help you manage storage, enable file replication, manage shared folders, provide fast file searching, and enable access for UNIX client computers. This article also lists the hotfixes that are currently available for users who use File Services on Windows 8-based computers or Windows 8.1-based computers.

This article contains lists of Microsoft Knowledge Base articles that describe the currently available fixes. The article is divided into two sections. The first section applies to Windows Server 2012 and to Windows 8, and the second section applies to Windows Server 2012 R2 and to Windows 8.1. Each section is divided into subsections for different component drivers: SRV, MRXSMB, and RDBSS. In general, the SRV drivers should be updated on the server or client computer that is hosting the data. The MRXSMB and RDBSS drivers should be updated on the server or client computer that is initiating access to the data. If you are unsure about which component should be updated on which computer, you can update all three component drivers on both the computer that is hosting the data and the computer that is accessing the data.

A servicing approach of installing the monthly rollups provides customers with a consistent model for staying current and secure. You may substitute a more recent monthly rollup in place of an older monthly rollup. The remainders of the updates in this list are still needed as some components in those updates released prior to October 2016 and are not included in a more recent monthly rollup.

## Windows Server 2012 and Windows 8

The latest fixes for these SMB components can be achieved by installing two updates:

1. [KB 2984005](https://support.microsoft.com/help/2984005/) - September 2014 update rollup for Windows RT, Windows 8, and Windows Server 2012
2. [KB 4520007](https://support.microsoft.com/help/4520007) - October 8, 2019-KB4520007 (Monthly Rollup) or later  

NTFS component

| Date added| Knowledge Base Article| Title| Why we recommend this hotfix| Hotfix type and availability |
|---|---|---|---|---|
| 10-Jan-2016| [3121255](https://support.microsoft.com/help/3121255)|0x00000024 Stop error in FsRtlNotifyFilterReportChange and copy file may fail in Windows|This hotfix contains an update for Ntfs.sys for Windows Server 2012.|To apply this update, you must have Windows 8 or Windows Server 2012 installed. Available on Windows Update. Also included in July 11, 2017-KB4025331 (Monthly Rollup) and later monthly rollups.|

SRV component

| Date added| Knowledge Base Article| Title| Why we recommend this hotfix| Hotfix type and availability |
|---|---|---|---|---|
| 15-April-2020| [4493451](https://support.microsoft.com/help/3161561)|April 9, 2019-KB4493451 (Monthly Rollup)|This hotfix contains the 6.2.9200.22707 version of srvnet.sys, srv2.sys.|Included in April 9, 2019-KB4493450 (Security-only update).<br/>Included in April 9, 2019-KB4493451 (Monthly Rollup) and later monthly rollups.|
|11-Aug-2014| [2984005](https://support.microsoft.com/help/2984005)|September 2014 update rollup for Windows RT, Windows 8, and Windows Server 2012|This update rollup contains the most current version of srvsvc.dll.|To apply this update rollup, you must have Windows 8, or Windows Server 2012 installed.|

MRXSMB component

| Date added| Knowledge Base article| Title| Why we recommend this hotfix| Hotfix type and availability |
|---|---|---|---|---|
|15-Apr-2020| [4516055](https://support.microsoft.com/help/3156416)|September 10, 2019-KB4516055 (Monthly Rollup)|This update rollup contains the 6.2.9200.22859 version of mrxsmb.sys, 6.2.9200.22702 version of mrxsmb10.sys, and 6.2.9200.22365 version of mrxsmb20.sys.|Included in September 10, 2019-KB4516062 (Security-only update).<br/>Included in September 10, 2019-KB4516055 (Monthly Rollup) and later monthly rollups.|

RDBSS component

| Date added| Knowledge Base article| Title| Why we recommend this hotfix| Hotfix type and availability |
|---|---|---|---|---|
| 15-April-2020| [4520007](https://support.microsoft.com/help/3137916)|October 8, 2019-KB4520007 (Monthly Rollup)<br/>|This update contains the 6.2.9200.22874 version of rdbss.sys.|Included in October 8, 2019-KB4519985 (Security-only update).<br/>Included in October 8, 2019-KB4520007 (Monthly Rollup) and later monthly rollups.|

## Windows Server 2012 R2 and Windows 8.1

> [!NOTE]
> The latest fixes for these SMB components can be achieved by installing [KB 4525243](https://support.microsoft.com/help/4525243).

| Date added| Knowledge Base Article| Title| Why we recommend this hotfix| Hotfix type and availability |
|---|---|---|---|---|
|13-May-2016| [3121255](https://support.microsoft.com/help/3121255)|0x00000024 Stop error in FsRtlNotifyFilterReportChange and copy file may fail in Windows|This update contains the 6.3.9600.18183 version of ntfs.sys.|To apply this update, you must be running Windows 8.1 or Windows Server 2012 R2 and April 2014 Update 2919355. Available from Windows Update.<br/>Also included in May 9, 2017-KB4019215 (Monthly Rollup) and later monthly rollups.|

SRV component

| Date added| Knowledge Base Article| Title| Why we recommend this hotfix| Hotfix type and availability |
|---|---|---|---|---|
| 15-April-2020| [4493446](https://support.microsoft.com/help/3161561)|April 9, 2019-KB4493446 (Monthly Rollup)|This hotfix contains the 6.3.9600.19309 version of srv.sys, srv2.sys, and srvnet.sys.|Included in April 9, 2019-KB4493467 (Security-only update).<br/>Included in April 9, 2019-KB4493446 (Monthly Rollup) and later monthly rollups.|

MRXSMB component

| Date added| Knowledge Base article| Title| Why we recommend this hotfix| Hotfix type and availability |
|---|---|---|---|---|
|15-April-2020| [4525243](https://support.microsoft.com/help/3156418)|November 12, 2019-KB4525243 (Monthly Rollup)<br/>|This update rollup contains the 6.3.9600.19537 version of mrxsmb.sys, 6.3.9600.19293 version of mrxsmb10.sys, and 6.3.9600.18586 version of mrxsmb20.sys.|Included in November 12, 2019-KB4525250 (Security-only update).<br/>Included in November 12, 2019-KB4525243 (Monthly Rollup) and later monthly rollups.|

RDBSS component

| Date added| Knowledge Base article| Title| Why we recommend this hotfix| Hotfix type and availability |
|---|---|---|---|---|
|15-April-2020| [4520005](https://support.microsoft.com/help/3156418)|October 8, 2019-KB4520005 (Monthly Rollup)|This update rollup contains the 6.3.9600.19481 version of rdbss.sys|Included in October 8, 2019-KB4519990 (Security-only update).<br/>Included in October 8, 2019-KB4520005 (Monthly Rollup) and later monthly rollups.|

## Registry keys introduced with hotfixes or security updates

Windows Server 2012 and Windows Server 2012 R2

| Date| Knowledge Base article| Registry key |
|---|---|---|
|06/10/2013| [2848322](https://support.microsoft.com/help/2848322)|`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters\ AsynchronousCredits` <br/>`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\ ExtendedSessTimeout` |

## Services for NFS in a Windows Server 2012 environment

Network File System (NFS) Server components Windows Server 2012 and Windows 8.0

| Date added| Knowledge Base article| Title| Why we recommend this hotfix| Hotfix type and availability |
|---|---|---|---|---|
|03-Jun-2016| [3130902](https://support.microsoft.com/help/3130902)|Stop error 0x9E and failover cluster can't come online in Windows Server 2012|This update contains the most current version of Nfssvc.exe, Nfssvr.sys, and Msnfsflt.sys.|To apply this update, you must be running Windows Server 2012. Available for individual download.|

NFS Client components Windows Server 2012 and Windows 8.0

| Date added| Knowledge Base article| Title| Why we recommend this hotfix| Hotfix type and availability |
|---|---|---|---|---|
|03-Jun-2016| [3042826](https://support.microsoft.com/help/3042826)|POSIX subsystem crashes when you try to create a Telnet session in Windows|This hotfix contains the most current version of Psxdll.dll, Psxdllsvr.dll, Psxss.exe, Posix.exe.|To apply this hotfix, you must be running Windows 8 or Windows Server 2012. Available for individual download.|

## Services for NFS in a Windows Server 2012 R2 environment

> [!NOTE]
> The latest fixes for these Network File System (NFS) components can be achieved by installing [KB 4503276](https://support.microsoft.com/help/4503276).

| Date added| Knowledge Base article| Title| Why we recommend this hotfix| Hotfix type and availability |
|---|---|---|---|---|
|15-April-2020| [4487016](https://support.microsoft.com/help/3094202)|February 19, 2019-KB4487016 (Preview of Monthly Rollup)|This hotfix contains the 6.3.9600.18751 version of Nfssvc.exe, 6.3.9600.19240 version of `Nfssvr.sys`.|Included in February 19, 2019-KB4487016 (Preview of Monthly Rollup) and later monthly rollups.|
|15-April-2020| [4503276](https://support.microsoft.com/help/4503276)|June 11, 2019-KB4503276 (Monthly Rollup)|This hotfix contains the 6.3.9600.19364 version of `Rpcxdr.sys`.|Included in June 11, 2019-KB4503290 (Security-only update).<br/> Included in June 11, 2019-KB4503276 (Monthly Rollup) and later monthly rollups.|

NFS Client components Windows Server 2012 R2 and Windows 8.1

| Date added| Knowledge Base article| Title| Why we recommend this hotfix| Hotfix type and availability |
|---|---|---|---|---|
|15-Apr-2020| [4038792](https://support.microsoft.com/help/3025097)|September 12, 2017-KB4038792 (OS Build Monthly Rollup)|This hotfix contains the 6.3.9600.18751 version of `Nfsclnt.exe`, 6.3.9600.18385 version of `Nfsrdr.sys` and 6.3.9600.18384 version of `Nfsnp.dll`.|Included in September 12, 2017-KB4038792 (OS Build Monthly Rollup) and later monthly rollups.|

## Server Message Block (SMB) model

The SMB model consists of two entities: the client and the server.

On the client, applications perform system calls by requesting operations on remote files. These requests are handled by the redirector subsystem (`rdbss.sys`) and by the SMB mini-redirector (`mrxsmb.sys`), both of which translate the requests into SMB protocol sessions and requests over TCP/IP. Starting with Windows Vista, the SMB 2.0 protocol is supported. The mrxsmb10.sys driver handles legacy SMB traffic, and the mrxsmb20.sys driver handles SMB 2.0 and SMB 3.0 traffic.

On the server, SMB connections are accepted, and SMB requests are processed as local file system operations through NTFS and the local storage stack. The srv.sys driver handles legacy SMB traffic, and the srv2.sys driver handles SMB 2.0 traffic. The `srvnet.sys` component implements the interface between networking and the file server for both SMB protocols. File system metadata and content can be cached in memory via the system cache in the kernel (`ntoskrnl.exe`).

The following screenshot provides an overview of the different layers through which a user request on a client computer must go to perform file operations over the network on a remote SMB file server by using SMB 2.0.

:::image type="content" source="media/hotfixes-for-file-services-technologies/windows-smb-components.png" alt-text="Screenshot of the SMB components which provides an overview of the different layers.":::

## Components in services for NFS in a Windows Server 2012 environment

Services for NFS includes the following components:

- Server for NFS

    This component corresponds to the server-side implementation of the NFS file-sharing protocol. Server for NFS enables a computer that is running Windows Server 2012 or Windows Server 2012 R2 to act as a file server for UNIX-based client computers.

- Client for NFS

    This component corresponds to the client-side implementation of the NFS file-sharing protocol. Client for NFS enables a Windows-based computer that is running Windows Server 2012 (or Windows 8) to access files that are stored on a UNIX-based NFS server.

Windows Server 2012 includes both the Server for NFS and Client for NFS components. However, Windows 8 includes only Client for NFS.

Microsoft Services for NFS provides a file-sharing solution for enterprises that have a mixed Windows and UNIX environment. This communication model consists of client computers and a server. Applications on the client request files that are located on the server through the redirector (`Rdbss.sys`) and NFS mini-redirector (`Nfsrdr.sys`). The mini-redirector uses the NFS protocol to send its request through TCP/IP. The server receives multiple requests from the clients through TCP/IP and routes the requests to the local file system (`Ntfs.sys`), which accesses the storage stack.

## References

For more information about currently available hotfixes for the File Services technologies in Windows Server 2008 and Windows Server 2008 R2, see [KB2473205](https://support.microsoft.com/help/2473205).

For more information about performance tuning, see the **Tuning parameters for SMB file servers** section in [Performance Tuning for File Servers](/windows-server/administration/performance-tuning/role/file-server/).
