---
title: AD replication fails with error 8409
description: AD replication fails with error 8409 after you restore or undelete AD objects in Windows Server 2016.
ms.date: 05/21/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, chrisrob, herbertm
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# Error 8409 and AD replication fails after you restore or undelete AD objects in Windows Server 2016

This article provides a solution to an error 8409 after you restore or undelete AD objects.

_Applies to:_ &nbsp; Supported versions of Windows Server  
_Original KB number:_ &nbsp; 4046675

## Symptoms

Assume that you have a Windows Active Directory Forest, and the Recycle Bin optional feature is not enabled. Assume also that you restore a deleted object through an NTDSUTIL authoritative restore operation, or you undelete it through an LDAP command or a commercial recovery tool.

After the update replicates, the Active Directory replication fails and returns error 8409.

> [!NOTE]
> The failure occurs at every replication attempt for the affected naming context for all inbound partners. However, the failure stops occurring after several hours.

Additionally, the following events are logged in the Windows NT Directory Services (NTDS) event log on the domain controller in Windows Server:

> Log Name: Directory Service 
> Source: Microsoft-Windows-ActiveDirectory_DomainService  
> Event ID: 1481  
> Task Category: Internal Processing  
> Description:  
> Internal error: The operation on the object failed.
> Additional Data  
> Error value:  
> 5 000020D9: SvcErr: DSID-xxxxxxxx, problem 5001 (BUSY), data 0  

> Log Name: Directory Service  
> Source: Microsoft-Windows-ActiveDirectory_DomainService  
> Event ID: 1084  
> Task Category: Replication  
> Description:  
> Internal event: Active Directory Domain Services could not update the following object with changes received from the following source directory service. This is because an error occurred during the application of the changes to Active Directory Domain Services on the directory service.  
> Object:  
> CN=user,OU=users,DC=contoso,DC=com  
> Object GUID: GUID  
> Source directory service:  
> GUID._msdcs.contoso.com  
> Synchronization of the directory service with the source directory service is blocked until this update problem is corrected.  
> This operation will be tried again at the next scheduled replication.  
> User Action  
> Restart the local computer if this condition appears to be related to low system resources (for example, low physical or virtual memory).  
> Additional Data  
> Error value:  
> 8409 A database error has occurred.

> Log Name: Directory Service  
> Source: Microsoft-Windows-ActiveDirectory_DomainService  
> Event ID: 2108  
> Task Category: Replication  
> Description:  
> This event contains REPAIR PROCEDURES for the 1084 event which has previously been logged. This message indicates a specific issue with the consistency of the Active Directory Domain Services database on this replication destination. A database error occurred while applying replicated changes to the following object. The database had unexpected contents, preventing the change from being made.
> Object:  
> CN=user,OU=users,DC=contoso,DC=com  
> Object GUID: GUID  
> Source directory service:  
> GUID._msdcs.contoso.com
> User Action  
> ...  
> Additional Data  
> Primary Error value:  
> 8409 A database error has occurred.  
> Secondary Error value:  
> 0 The operation completed successfully.  

## Cause

When NTDS is started, DS starts an internal task to check all writable NCs for the need to assign a value of **TRUE** to the **IsRecycled** attribute of the deleted objects.

Until this task is completed, the status of the Recycle Bin optional feature is disabled. In this state, the replication engine does not allow undeleting or restoring of Active Directory objects. Therefore, this does not interact with the addition of the **isRecycled** attribute.

This task is completed in a few seconds if the objects already have the attribute value of **TRUE**. The task is deferred during a startup to improve the DS startup time, and it's rescheduled to begin six hours later. Therefore, you can't replicate any AD object restore process for the first six hours of the DS uptime.

[NTDS diagnostics logging for "6. Garbage Collection"](/troubleshoot/windows-server/active-directory/configure-ad-and-lds-event-logging) at level 2 would enable you to see the event ID 2406 that indicates the start of the task and the event ID 2405 that indicates the end of the task.

If the AD replication has the top priority, you can delete the objects again and then restore them again later. Or, you can wait for six hours until the task is completed. If you restart the domain controller, you start another six-hour interval with this issue.

## Resolution

To fix this issue, enable the Recycle Bin optional feature to allow the undelete or restore operations to finish. After you do this, there is no task started that will disable the optional feature.

## More information

When the directory service starts, it tracks the progress of the task through events that are logged in the NTDS event log. The events for managing the disabling of the Recycle Bin optional feature are as follows:

> Log Name: Directory Service  
> Source: Microsoft-Windows-ActiveDirectory_DomainService  
> Event ID: 2121  
> Task Category: Internal Configuration  
> Level: Information  
> Description:  
> This Active Directory Domain Services server is disabling the Recycle Bin. Deleted objects may not be undeleted at this time. 

> Log Name: Directory Service  
> Source: Microsoft-Windows-ActiveDirectory_DomainService  
> Event ID: 2406  
> Task Category: Internal Configuration  
> Level: Information  
> Description: This Active Directory Domain Services server is disabling support for the "Recycle Bin Feature" optional feature.

> Log Name: Directory Service  
> Source: Microsoft-Windows-ActiveDirectory_DomainService  
> Event ID: 2120  
> Task Category: Internal Configuration  
> Level: Information  
> Description: This Active Directory Domain Services server does not support the Recycle Bin. Deleted objects may be undeleted, however, when an object is undeleted, some attributes of that object may be lost. Additionally, attributes of other objects that refer to the object being undeleted may also be lost.

> Log Name: Directory Service  
> Source: Microsoft-Windows-ActiveDirectory_DomainService  
> Event ID: 2405  
> Task Category: Internal Configuration  
> Level: Information  
> Description:  
> This Active Directory Domain Services server does not support the "Recycle Bin Feature" optional feature.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
