---
title: Issue when the Lync Server File Store share is in an unsupported configuration
description: Describes the issues that occur when a Lync Server 2010 File Store share has an unsupported configuration. Includes detailed info about the events that are logged. Resolutions are provided.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server 2010 Enterprise Edition
  - Lync Server 2010 Standard Edition
  - Lync Server 2013
ms.date: 03/31/2022
---

# Issues when the Lync Server File Store share is in an unsupported configuration

## Symptoms

When the shared Lync File Store is hosted in an incorrect or unsupported configuration, you may encounter one or more of the following issues:


- Slow Lync meeting joins   
- Lync Server Central Management Store replication failures   
- Lync Server Backup Service logged errors or warnings events   
- Lync Server Address Book Server access issues   
- Lync Server Web Conferencing access issues   
- Lync Mobility client sign-in failures   

Additionally you may see one or more of the following error or warning events in the Lync Server log in Windows Server Event Viewer.

> [!NOTE]
> For detailed information about using the Lync Server log, see the "Event Viewer" section of following TechNet article:
> 
> [Client-side logging and diagnostics](/previous-versions/office/skype-server-2010/gg195661(v=ocs.14))

```AsciiDoc
Log Name: Lync Server
Source: LS Data MCU
Date: Date
Event ID: 41027
Task Category: LS Data MCU
Level: Error
Keywords: Classic
User: N/A
Computer: filesharehost.contoso.com
Description:
The content file store is full or unavailable, and no more data can be written to it.
Content file store location: \\filesharehost.contoso.com\fileshare$\1-WebServices-2\CollabMetadata\{87589B2B-A3E1-4F42-9082-19090EDAB3F9}\WYTPJ3SW
Reason: The process cannot access the file '\\filesharehost.contoso.com\fileshare$\1-WebServices-2\CollabMetadata\{87589B2B-A3E1-4F42-9082-
19090EDAB3F9}\WYTPJ3SW\Meeting.Active' because it is being used by another process.
Cause: The file store either has run out of space or is unavailable.
Resolution:
Verify write access to the file store or make more space available on it. 
Note that this event is logged only once. When the problem is fixed a success event ID=41028 will be logged.

Time: Date
ID: 62010
Level: Error
Source: LS Address Book and Distribution List Expansion Web Service
Machine: lyncfe01.contoso.com
Message: Address Book Request web service encountered an exception
Access to the path '\\filesharehost.contoso.com\system\LyncStore\1-WebServices-12\ABFiles\00000000-0000-0000-0000-000000000000\00000000-0000-0000-0000-000000000000\27d5d45dd7344b89970ab32f9cf54d57.photo' is denied.
Exception type: UnauthorizedAccessException
Cause: Unexpected exception occurred while processing a HTTP file request.
Resolution:
Examine exception details in event to determine the resolution.

Time: Date
ID: 62010
Level: Error
Source: LS Address Book and Distribution List Expansion Web Service
Machine: lyncfe01.contoso.com
Message: Address Book Request web service encountered an exception
Could not find file '\\filesharehost.contoso.com\system\LyncStore\1-WebServices-12\ABFiles\00000000-0000-0000-0000-000000000000\00000000-0000-0000-0000-000000000000\79db474bb18e4faab81efbd5ddbc3c37.photo'.
Exception type: FileNotFoundException
Cause: Unexpected exception occurred while processing a HTTP file request.
Resolution:
Examine exception details in event to determine the resolution.

Log Name: Lync Server
Source: LS Address Book and Distribution List Expansion Web Service
Date: Date
Event ID: 62031
Task Category: LS Address Book and Distribution List Expansion Web Service
Level: Error
Keywords: Classic
User: N/A
Computer: lyncfe01.contoso.com
Description:
The remote share is experiencing very high latency. In order to preserve resources that may affect other services running on the machine further 
requests will be rejected.
Share: \\lyncfe01.contoso.com\fileshare$\1-WebServices-2\ABFiles\00000000-0000-0000-0000-000000000000\00000000-0000-0000-0000-000000000000
Cause: A network or file issue is causing extremely high latency for the share.
Resolution:
Fix the issue causing high latency with the file share.

Log Name: Lync Server
Source: LS Master Replicator Agent Service
Date: 2/9/2015 9:24:07 PM
Event ID: 2020
Task Category: LS Master Replicator Agent Service
Level: Error
Keywords: Classic
User: N/A
Computer: lyncfe01.contoso.com
Description:
File transfer failed for some replica machines. Microsoft Lync Server 2013, Master Replicator Agent will continuously attempt to replicate with these 
machines.
While this condition persists, configuration changes will not be delivered to these replica machines.
Replica file transfer failures:
lyncfe01.contoso.com: Access failed. (Can't watch \\filesharehost.contoso.com\LyncPool01\1-CentralMgmt-1\CMSFileStore\xds-master\replicas
\lyncfe01.contoso.com\from-replica.)lyncfe05.contoso.com: Access failed. (Can't watch \\filesharehost.contoso.com\LncPool01\1-CentralMgmt-
1\CMSFileStore\xds-master\replicas\lyncfe05.contoso.com\from-replica.)
Cause: Possible issues with writing files to the file shares listed above.
Resolution:
Check the accessibility of the file shares listed above.

Log Name: Lync Server
Source: LS Web Components Server
Date: 2/10/2015 11:48:32 AM
Event ID: 4106
Task Category: LS Web Components Server
Level: Error
Keywords: Classic
User: N/A
Computer: lyncfe01.contoso.com
Description:
The server selected for next hop could not be reached, or did not reply.
A server selected as a proxy target for HTTP traffic could not be reached or did not reply: lyncfe02.contoso.com. 
Performance Counter Instance: LM_W3SVC_34577_ROOT_Ucwa 
Failure occurrences: 1, since dd/mm/yyy hh:mm:ss AM|PM 
Failure Details: WebException: The remote server returned an error: (504) Gateway Timeout.
Cause: The remote server may be experiencing problems or the network is not available between these servers.
Resolution:
Examine the event logs on the indicated server to determine the cause of the problem.

Log Name: Lync Server
Source: LS Backup Service
Date: mm/dd/yyyy hh:mm:ss AM|PM
Event ID: 4042
Task Category: (4000)
Level: Error
Keywords: Classic
User: N/A
Computer: lyncfe01.contoso.com
Description:
Microsoft Lync Server 2013, Backup Service data content backup module failed to complete export operation.
Configurations: 
Backup Module Identity:ConfServices.DataConf
Working Directory path:\\filesharehost.contoso.com\LyncPool01\2-BackupService-6\BackupStore\Temp
Local File Store Unc path:\\filesharehost.contoso.com\LyncPool01\2-BackupService-6\BackupStore
Remote File Store Unc path:\\filesharehost.contoso.com\LyncPool01\1-BackupService-36\BackupStore
Additional Message: 
Exception: System.IO.IOException: An unexpected network error occurred.
Cause: Either network or permission issues. Please look through the exception details for more information.
```

## Cause

This Lync server file store problem occurs because of configuration issues that involve the supported Windows file server share, the Windows file server DFS share, or the supported Server Access Network (SAN) device.

Note Network Access Storage (NAS) devices are not supported in Lync Server 2010 or Lync Server 2013 deployments. This support limitation is caused by the variable design of NAS devices that have to provide file system adaptability to the Windows Server-based computer that accesses the devices' shared file system.

## Resolution

To resolve this issue, make sure that the Lync Server deployment hosts its shared information by using a supported file storage infrastructure. 

For information about supported Lync Server 2013 file storage configurations, see the following TechNet article:

[File storage support in Lync Server 2013](/previous-versions/office/lync-server-2013/lync-server-2013-file-storage-support)

For step by step information about configuring Lync Server 2013 file storage, see the following TechNet article:

[Configure file storage for Lync Server 2013](/previous-versions/office/lync-server-2013/lync-server-2013-configure-dfs-file-storage)

For step by step information about moving Lync Server 2013 file storage, see the following TechNet blog post:

[Change the file store location for Lync Server 2013 pool](https://social.technet.microsoft.com/wiki/contents/articles/15374.change-the-file-store-location-for-lync-server-2013-pool.aspx)

For step by step information about moving Lync Server 2010 file storage, see the following TechNet articles:

- [Move the file store for Lync Server 2010 pool](/previous-versions/office/skype-server-2010/gg195761(v=ocs.14))
- [Reassign a server to a different file store](/previous-versions/office/skype-server-2010/gg195633(v=ocs.14))

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).