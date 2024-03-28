---
title: Hotfixes for File Services technologies in Windows Server 2008
description: This article lists the hotfixes that are currently available for users who have installed the File Services technologies on a Windows Server 2008-based computer or on a Windows Server 2008 R2-based computer.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: cpuckett, waltere, kaushika
ms.custom: sap:Backup, Recovery, Disk, and Storage\File Server Resource Manager (FSRM) , csstroubleshoot
---
# List of currently available hotfixes for the File Services technologies in Windows Server 2008 and in Windows Server 2008 R2

This article lists the hotfixes that are currently available for users who have installed the File Services technologies on a Windows Server 2008-based computer or on a Windows Server 2008 R2-based computer.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2, Windows Server 2008  
_Original KB number:_ &nbsp; 2473205

## Summary

File Services provides technologies that help you manage storage, enable file replication, manage shared folders, ensure fast file searching, and enable access for UNIX client computers. This article also lists the hotfixes that are currently available for users who utilize File Services from Windows Vista-based computers or from Windows 7-based computers.

This article contains lists of Microsoft Knowledge Base articles that describe the currently available fixes. The article is divided into two sections. The first section applies to Windows Server 2008 R2 and to Windows 7, and the second section applies to Windows Server 2008 and to Windows Vista. Each section is divided into subsections for different component drivers: SRV, MRXSMB, and RDBSS. In general, the SRV drivers should be updated on the server or client computer that is hosting the data. The MRXSMB and RDBSS drivers should be updated on the server or client computer that is initiating access to the data. If you are unsure about which component should be updated on which computer, you can update all three component drivers both on the computer that is hosting the data and on the computer that is accessing the data.

## Windows Server 2008 R2 and Windows 7

- NTFS component

    |Date added|Knowledge Base Article|Title|Why we recommend this hotfix|Hotfix type and availability|
    |---|---|---|---|---|
    | Jan/08/2016| [3121255](https://support.microsoft.com/help/3121255)|0x00000024 Stop error in FsRtlNotifyFilterReportChange and VSS backup of PI Data server fails in Windows|This hotfix contains the most current version of ntfs.sys.<br/><br/> (LDR)|To apply this hotfix, you must have Windows 7 SP1 or Windows Server 2008 R2 SP1 installed. Available for individual download.|

- SRV component

    |Date added|Knowledge Base Article|Title|Why we recommend this hotfix|Hotfix type and availability|
    |---|---|---|---|---|
    |May/12/2016| [3161561](https://support.microsoft.com/help/3161561)|MS16-075 and MS16-076: Description of the security update for Windows Netlogon and SMB Server: June 14, 2016|This hotfix contains the most current version of srvnet.sys, srv.sys, and srv2.sys.<br/><br/>(LDR)|To apply this security update, you must have Windows 7 SP1, or Windows Server 2008 R2 SP1 installed. Available for individual download.|

- MRXSMB component

    |Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
    |---|---|---|---|---|
    |May/12/2016| [3161561](https://support.microsoft.com/help/3000483)|MS16-075 and MS16-076: Description of the security update for Windows Netlogon and SMB Server: June 14, 2016|This security hotfix contains the most current version of mrxsmb.sys, mrxsmb10.sys<br/> and mrxsmb20.sys. <br/>(LDR)|To apply this security hotfix, you must have Windows 7 SP1, or Windows Server 2008 R2 SP1 installed. Available for individual download.|

- RDBSS component

    |Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
    |---|---|---|---|---|
    |Mar/12/2015| [3044428](https://support.microsoft.com/help/3044428)|0x00000027 or 0x00000050 Stop error in the Rdbss.sys driver in Windows 7 SP1 or Windows Server 2008 R2 SP1|This hotfix contains the most current version of rdbss.sys. (LDR)|To apply this hotfix, you must have Windows 7 SP1 or Windows Server 2008 R2 SP1 installed. Available for individual download.|

## Windows Server 2008 and Windows Vista

- NTFS component

    |Date added|Knowledge Base Article|Title|Why we recommend this hotfix|Hotfix type and availability|
    |---|---|---|---|---|
    |Jan/02/2015| [2928562](https://support.microsoft.com/help/2928562)|Event 55 when you copy an encrypted folder to EFS shared folder in Windows|This hotfix contains the most current version of ntfs.sys.|To apply this hotfix, you must have Windows Vista SP 2 Windows Server 2008 SP2 installed. Available from Microsoft Update.|

- SRV component

    |Date added|Knowledge Base Article|Title|Why we recommend this hotfix|Hotfix type and availability|
    |---|---|---|---|---|
    |May/14/2016| [3161561](https://support.microsoft.com/help/3161561)|MS16-075 and MS16-076: Description of the security update for Windows Netlogon and SMB Server: June 14, 2016|This hotfix contains the most current version of srvnet.sys, srv.sys, and srv2.sys.<br/><br/>(GDR/LDR)|To apply this security update, you must have Windows Vista SP2 or Windows Server 2008 SP2 or later versions installed. Available from Microsoft Update.|

- MRXSMB component

    |Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
    |---|---|---|---|---|
    |May/14/2016| [3161561](https://support.microsoft.com/help/3161561)|MS16-075 and MS16-076: Description of the security update for Windows Netlogon and SMB Server: June 14, 2016|This security hotfix contains the most current Version of mrxsmb .sys, mrxsmb10 .sys and mrxsmb20.sys. (LDR/GDR)|To apply this security hotfix, you must have Windows Vista SP 2 or Windows Server 2008 SP 2 installed. Available for individual download.|

- RDBSS component

    |Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
    |---|---|---|---|---|
    |Jan/07/2015| [3000483](https://support.microsoft.com/help/3000483)|MS15-011: Vulnerability in Group Policy could allow remote code execution: February 10, 2015|This security hotfix contains the most current version of rdbss.sys for Windows Vista SP 2 and for Windows 2008 SP 2. (LDR/GDR)|To apply this security hotfix, you must have Windows Vista SP 2 or Windows Server 2008 SP 2 installed. Available for individual download.|

## More information

- Server 2008 R2 Registry keys that have been introduced with hotfixes or security updates:

    |Date|Knowledge Base article|Registry key|
    |---|---|---|
    | 5/15/2009| [971277](https://support.microsoft.com/help/971277)|`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters\ Level2Compatibility`|
    | 9/06/2010| [2345886](https://support.microsoft.com/help/2345886)|`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters\ SmbServerNameHardeningLevel`|
    | 7/13/2012| [2732618](https://support.microsoft.com/help/2732618)|`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters\ ABELevel`|

- Server 2008 Registry keys that have been introduced with hotfixes or security updates:

    |Date|Knowledge Base article|Registry key|
    |---|---|---|
    |10/05/2012| [2761551](https://support.microsoft.com/help/2761551)|`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters\ SrvMaxThreadsPerQueue` |
    |03/08/2013| [2732618](https://support.microsoft.com/help/2732618)|`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters\ ABELevel` |

## Server Message Block (SMB) model

The Server Message Block (SMB) model consists of two entities: the client and the server.

On the client, applications perform system calls by requesting operations on remote files. These requests are handled by the redirector subsystem (rdbss.sys) and by the SMB mini-redirector (mrxsmb.sys), both of which translate the requests into SMB protocol sessions and requests over TCP/IP. Starting with Windows Vista, the SMB 2.0 protocol is supported. The mrxsmb10.sys driver handles legacy SMB traffic, and the mrxsmb20.sys driver handles SMB 2.0 traffic.

On the server, SMB connections are accepted, and SMB requests are processed as local file system operations through NTFS and the local storage stack. The srv.sys driver handles legacy SMB traffic, and the srv2.sys driver handles SMB 2.0 traffic. The srvnet.sys component implements the interface between networking and the file server for both SMB protocols. File system metadata and content can be cached in memory via the system cache in the kernel (ntoskrnl.exe).

The following image provides an overview of the different layers through which a user request on a client computer must go to perform file operations over the network on a remote SMB file server by using SMB 2.0.

:::image type="content" source="media/file-services-hotfixes-in-windows-server-2008/smb-components.png" alt-text="Overview of the Windows Server Message Block Components.":::

## Services for NFS in a Windows Server 2008 R2 environment

- Network File System (NFS) Server components 2008 R2

    |Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
    |---|---|---|---|---|
    |12-Mar-2015| [3043762](https://support.microsoft.com/help/3043762)|The process cannot access the file error when you open files from NFS server in Windows Server 2008 R2 SP1|This security update contains the most current version of Nfssvc.exe,  and Nfssvr.sys. <br/><br/> (LDR)|To apply this hotfix, you must have Windows Server 2008 R2 SP1 installed. Available for individual download. Available from Microsoft Update.|
    | 29-Aug-2014| [2957486](https://support.microsoft.com/help/2957486)|Ls command takes a long time to list shared files in 2 windows on a Windows 7 or Windows Server 2008 R2-based NFS server|This hotfix contains the most current version of Rpcxdr.sys. (LDR GDR)|To apply this hotfix, you must have Windows Server 2008 R2, or Windows Server 2008 R2 SP1 installed. Available for individual download. |

- NFS Client components

    |Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
    |---|---|---|---|---|
    |14-May-2014| [2956990](https://support.microsoft.com/help/2956990)|NFS client can't reconnect to NFS server in Windows 7 SP1 or Windows Server 2008 R2 SP1|This hotfix contains the most current version of Nfsnp.dll, Nfsclnt.exe, and Nfsrdr.sys.|To apply this hotfix, you must have Windows 7 SP1, or Windows Server 2008 R2 SP1 installed. Available for individual download.|
    |Apr/03/2015| [3042826](https://support.microsoft.com/help/3042826)|POSIX subsystem crashes when you try to create a Telnet session in Windows|This hotfix contains the most current version of Psxdll.dll, Psxdllsvr.dll, Psxss.exe, Posix.exe.|To apply this hotfix, you must have Windows 7 SP1, or Windows Server 2008 R2 SP1 installed. Available for individual download.|

## Services for NFS in a Windows Server 2008 environment

- NFS Server components

    |Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
    |---|---|---|---|---|
    |Jan/02/2014| [2923150](https://support.microsoft.com/help/2923150)|A memory leak occurs on an NFS share server that is running Windows Server 2008|This security update contains the most current version of Nfssvc.exe, Nfssvr.sys, and Msnfsflt.sys.|To apply this hotfix, you must have Windows Vista SP2 or Windows Server 2008 SP2 installed. Available from Microsoft Update.|
    |Sep/25/2014|[2957486](https://support.microsoft.com/help/2957486)|Ls command takes a long time to list shared files in 2 windows on a Windows 7 or Windows Server 2008 R2-based NFS server|This hotfix contains the most current version of Rpcxdr.sys.|To apply this hotfix, you must have Windows Vista SP2 or Windows Server 2008 SP2 installed. Available from Microsoft Update.|

### Components included in services for NFS

- Server for NFS

    This component corresponds to the server-side implementation of the NFS file-sharing protocol. Server for NFS enables a computer that is running Windows Server 2008 R2 to act as a file server for UNIX-based client computers.

- Client for NFS

    This component corresponds to the client-side implementation of the NFS file-sharing protocol. Client for NFS enables a Windows-based computer that is running Windows Server 2008 R2 (or Windows 7) to access files that are stored on a UNIX-based NFS server.

Windows Server 2008 R2 includes both the Server for NFS and Client for NFS components. However, Windows 7 includes only Client for NFS.

For more information about the step-by-step guide for the services for NFS, see [General information about the step-by-step guide for the services for NFS](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd758767(v=ws.10)).

Microsoft Services for NFS provides a file-sharing solution for enterprises that have a mixed Windows and UNIX environment. This communication model consists of client computers and a server. Applications on the client request files that are located on the server through the redirector (Rdbss.sys) and NFS mini-redirector (Nfsrdr.sys). The mini-redirector uses the NFS protocol to send its request through TCP/IP. The server receives multiple requests from the clients through TCP/IP and routes the requests to the local file system (Ntfs.sys), which accesses the storage stack.

## References

- [List of currently available hotfixes for Distributed File System (DFS) technologies in Windows Server 2008 and in Windows Server 2008 R2](https://support.microsoft.com/help/968429).

- [An enterprise hotfix rollup is available for Windows 7 SP1 and Windows Server 2008 R2 SP1](https://support.microsoft.com/help/2775511)

- [List of currently available hotfixes for the File Services technologies in Windows Server 2012 and in Windows Server 2012 R2](https://support.microsoft.com/help/2899011)

- [Performance Tuning for File Servers](/previous-versions//dn567661(v=vs.85)#smbtuningpars)
