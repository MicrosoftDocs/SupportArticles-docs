---
title: The request is not supported error for SMB Read Andx requests for files managed by Data Deduplication in Windows Server 2012
description: Fixes errors that occur in SMB Read Andx requests for files managed by Data Deduplication.
ms.date: 07/20/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:deduplication, csstroubleshoot
ms.technology: windows-server-backup-and-storage
---
# SMB Read Andx requests for files managed by Data Deduplication error in Windows Server 2012: The request is not supported

This article helps fix the errors that occur in SMB Read Andx requests for files managed by Data Deduplication.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2817216

## Symptoms

Server: Windows Server 2012 RTM, with volume setting [x] Enable data deduplication  
SMB v1 Clients: Windows XP SP3, third-party CIFS clients (Macintosh, Unix Samba)  

Windows XP clients are unable to open files on Server 2012 shares.

Only deduped files (with the size >32 KB) aren't accessible on the volume, expanded files are accessible.  

Error messages may vary depending on type of access and application accessing file on Server 2012 share with Data Deduplication.

- **Explore: Copy file**

    > An unexpected error is keeping you from copying the file. If you continue to receive this error, you can use the error code to search for help with this problem.  
    >
    > Error 0x80070032: The request is not supported.

    or  

- **Error Copying File or Folder**  

    > Cannot copy \<filename>: Cannot read from the source file or disk.

    or

    > Cannot copy \<filename>: The request is not supported.  

- **Office: Microsoft Excel**'

    > filename.xls' cannot be accessed. The file may be read-only, or you may be trying to access a read-only location. Or, the server the document is stored on may not be responding. 

    or

    > Could not open 'filename.xls'.  

- **Microsoft Word**  

    > Could not open 'filename.doc'.  

- **Adobe**: Open recent file  

    > There was on error opening this document. Access Denied.  

- **Navisworks**

    Autodesk Navisworks Simulate 2011  

    > Couldn't load \<filename.nsd> because the contents are corrupt  

- **Access Denied**

    ERROR_ACCESS_DENIED

    > Access is denied.  

Network **trace** shows STATUS_NOT_SUPPORTED for SMB1 Read Andx requests:

1819 *\<DateTime>* XPclient 2012Srv SMB NT Create AndX Request, FID: 0xc003, Path: \Test-Dedup-file.pdf  
1820 *\<DateTime>* 2012Srv XPclient SMB NT Create AndX Response, FID: 0xc003  
AllocationSize: 0  
EndOfFile: 51362  
1829 *\<DateTime>* XPclient 2012Srv SMB Read AndX Request, FID: 0xc003, 32768 bytes at offset 0  
1830 *\<DateTime>* 2012Srv XPclient SMB Read AndX Response, FID: 0xc003, 0 bytes, Error: STATUS_NOT_SUPPORTED  
NTStatus: 0xC00000BB, Facility = FACILITY_SYSTEM, Severity = STATUS_SEVERITY_ERROR, Code = (187) STATUS_NOT_SUPPORTED  

Error code 0xc00000bb = STATUS_NOT_SUPPORTED  
or 0x80070032 = ERROR_NOT_SUPPORTED = The request is not supported.  

> [!Note]
> Same action on a Windows 7 client with SMBv2 protocol works  
>
> - tested on Windows 7 client with SMB2: OK
> - tested on Windows 7 client with SMB1: failed (SMB2 disabled using info from KB  
[How to detect, enable and disable SMBv1, SMBv2, and SMBv3 in Windows](https://support.microsoft.com/kb/2696547)  

### Workaround

Server 2012 without volume setting [ ] Enable data deduplication

Start-DedupJob E: -Type UnOptimization

### Deduplication Cmdlets in Windows PowerShell  

Windows PowerShell

Copyright (C) 2012 Microsoft Corporation. All rights reserved.  
PS C:\Windows\system32> DedupStatus  

Get-DedupStatus - Returns a DeduplicationStatus object for every volume that has data deduplication metadata.  
Get-DedupSchedule - Returns the DeduplicationJobSchedule objects defined on the system.  
Get-DedupJob - Returns status and information for currently running or queued deduplication jobs.  
Update-DedupStatus - Scans one or more specified volumes to compute fresh data deduplication savings information and returns a DeduplicationStatus object.  
get the latest status of the unoptimization job by running the Get-DedupJob PowerShell command  

Reported on:

[Windows 2012 Deduplication - Access share from Windows XP / 7](https://social.technet.microsoft.com/Forums/en-CA/winserverfiles/thread/c3f370ec-cca3-4af5-90a4-02c2a8901bc8)

## Cause

Interoperability issue of components Dedup, SMB, and Non-Default entry **EnableECP** in Server registry:

 > HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\LanManServer\Parameters  
 EnableAuthenticateUserSharing REG_DWORD 0x0  
 ServiceDllUnloadOnStop REG_DWORD 0x1  
 ServiceDll REG_EXPAND_SZ %SystemRoot%\system32\srvsvc.dll  
 NullSessionPipes REG_MULTI_SZ  
 autodisconnect REG_DWORD 0xf  
 enableforcedlogoff REG_DWORD 0x1  
 enablesecuritysignature REG_DWORD 0x0 //default = 0x1  
 requiresecuritysignature REG_DWORD 0x0  
 restrictnullsessaccess REG_DWORD 0x1  
 Lmannounce REG_DWORD 0x0  
 Size REG_DWORD 0x3  
 AdjustedNullSessionPipes REG_DWORD 0x3  
 ClusterPipes REG_MULTI_SZ FssagentRpc  
 CachedOpenLimit REG_DWORD 0x0 //default = 0x5  
 \>> **enableecp REG_DWORD 0x1** << //default = 0x0 or not set  
 Guid REG_BINARY DEF9D10A080B9241932038A7E77DFC2D  

 > [!Note]
 > This is known to happen after you install **McAfee** ver. 8.8 VirusScan Enterprise + AntiSpyware Enterprise.  
 De-installing this product still leaves **enableecp=1** behind, so you need to delete the registry key **enableecp** manually.  

## Resolution

We believe that the issue is due to interoperability between three components Dedup, SMB, and third party like "VMware vShield Endpoint driver (VSEPFLT.SYS)", if the following registry key had been set manually or by some third party software installation:

`HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\enableecp = 1`

To resolve the Deduplication issue:

Delete the Registry entry "EnableECP"  
and  

1. Reboot  

    or  

2. Restart the Server Service, in elevated CMD window type:  

    `NET STOP SERVER && NET START SERVER`

    > [!Note]
    > it the steps above don't solve the issue: There may be additional application-related issues:
    >
    > when Deduped files are accessed using an application like Adobe over SMB, it may fail.
    >
    > Adobe confirmed a known issue with Adobe Reader in accessing PDF files on a Server 2012 with Deduped files.
    >
    > The issue was fixed by Adobe from 10.3.x. Currently the latest version of Adobe Reader available is 11.0.
    >
    > Here is the article about the PDF files [server 2012 RTM deduplication causing PDF file issues](https://social.technet.microsoft.com/Forums/en-US/winserver8gen/thread/b432494e-d969-46d5-867c-97bfa0fcb710)
    >
    > This issue is fixed in version (10.1.4) of Acrobat Reader.

 **Status** as of March 8: Response from *McAfee* Support: We're actively investigating what the value "enableecp" is used for in our product and what the impact is (if any) of reverting this back to 0 or even removing the value altogether.  

 If the customer relies on data deduplication on server 2012 accessed by XP clients in their environment, the recommendation for now is, to set the key to 0 as per MSFT suggestion to guarantee smooth operation of the environment until such times that we've finished our investigation and come to a conclusion on how to best approach this issue.  

 **KB77623** - is currently in the pipeline and will be published within the next 5-6 working days, the KB will be updated as our investigation progresses and more details become available. It currently contains a general overview of the issue and the workaround described by MSFT.  

 March 19: the KB has been published and should be publicly accessible through the [McAfee Knowledgebase](https://kcm.trellix.com/corporate/index?page=home). Investigation surrounding the value "enableecp" is on-going.  

 [Windows 7 clients can't access shares on Windows Server 2012 when Data Deduplication is enabled](https://kcm.trellix.com/corporate/index?page=content&id=KB77623)  

## More information

Info re. Deduplication on Microsoft Server 2012

[Introduction to Data Deduplication in Windows Server 2012](https://blogs.technet.com/b/filecab/archive/2012/05/21/introduction-to-data-deduplication-in-windows-server-2012.aspx)  

[Data Deduplication Overview](https://technet.microsoft.com/library/hh831602.aspx)  

[Data Deduplication Interoperability](https://technet.microsoft.com/library/hh831454.aspx)  

Info on ECP:

[What's new in driver development](https://msdn.microsoft.com/library/windows/hardware/hh439741%28v=vs.85%29.aspx#_extra_create_parameter__ecp__improvements)  

Extra Create Parameter (ECP) Improvements

Recycling of previously allocated ECPs is new in Windows 8. To avoid the overhead of freeing an ECP on file close and then allocating a new one later, a file system or file system filter driver can reuse an existing ECP.

Server & Tools Blogs > Server & Management Blogs > The Storage Team at Microsoft - File Cabinet

 [Storage at Microsoft](https://blogs.technet.com/b/filecab/archive/2012/05/21/introduction-to-data-deduplication-in-windows-server-2012.aspx)
