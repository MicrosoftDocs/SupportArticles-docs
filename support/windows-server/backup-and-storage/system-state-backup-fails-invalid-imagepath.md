---
title: System State Backup fails when an invalid ImagePath is specified for services
description: Describes an issue in which System State Backup fails when an invalid ImagePath is specified for services.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
---
# System State Backup fails when an invalid ImagePath is specified for services

This article describes an issue in which System State Backup fails when an invalid ImagePath is specified for services.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 968247

## Symptom

Windows Server 2008 System State Backup may fail with the following error:

> Summary of backup:  
Backup of system state failed [\<date> \<time>]  
Log of files successfully backed up
'C:\Windows\Logs\WindowsServerBackup\SystemStateBackup \<date> \<time>.log'  
Log of files for which backup failed  
'C:\Windows\Logs\WindowsServerBackup\SystemStateBackup_Error \<date> \<time>.log'  
Enumeration of the files failed.  
The file name, directory name, or volume label syntax is incorrect.  

In the event log, the following errors are logged: 

>Log Name: Application  
Source: Microsoft-Windows-Backup  
Event ID: 517  
Computer: \<computername>  
Description:
Backup started at \<date time> failed with following error code '2155348237' (Enumeration of the files failed.). Please rerun backup once issue is resolved.

>Log Name: Microsoft-Windows-Backup  
Source: Microsoft-Windows-Backup  
Event ID: 5  
Computer: \<computername>  
Description:  
Backup started at \<date time> failed with following error code '2155348237'.

## Cause

The System state backup fails because the ImagePath that is specified by a service cannot be backed up. Closer inspection of the System log shows that a service is failing to start, and you receive an error such as the following.  

>Event Type: Error  
Event Source: Service Control Manager  
Event Category: None  
Event ID: 7000  
Description:  
The \<servicename> service failed to start due to the following error: The system cannot find the path specified.

Reviewing the ImagePath of the failing service reflects an invalid path or file name.

## Resolution

To resolve this issue, follow these steps:

1. Review the System Log to determine the service that will not start.
2. Contact the services software vendor for any known issues and updated installation package that may resolve the incorrect ImagePath.  
3. Select one of the following options:  

    Option 1: 
Uninstall the software related to the problematic service. As soon as it is removed, restart the system state backup.

    Option 2: 
Correct the ImagePath to have a valid path and file name by using regedit. 

> [!NOTE]
> Because each service will have a unique ImagePath, you may have to contact the software vendor if the correct path and file name are not obvious. 

> [!NOTE]
> The following blog posting includes an example script that can be used to identify faulty ImagePath statements. This script is provided as-is and without warrantee:

[https://blogs.technet.com/b/askcore/archive/2010/06/18/ps-script-for-blog-enumeration-of-the-files-failed.aspx](https://blogs.technet.com/b/askcore/archive/2010/06/18/ps-script-for-blog-enumeration-of-the-files-failed.aspx)
