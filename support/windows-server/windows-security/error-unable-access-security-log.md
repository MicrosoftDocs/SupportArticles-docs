---
title: Unable to Access the security log
description: Helps to fix the error where we are unable to Access the security log.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:permissions-access-control-and-auditing, csstroubleshoot
---
# We are seeing an error where we are unable to access the security log

This article helps to fix the error where we are unable to access the security log.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2751670

## Symptoms

We are seeing the following error
 "Event viewer cannot open the event log or custom view. Verify that the event log service is running or query is too long. Access is denied" when we try to open the security logs on some of the domain controllers with the domain admin account.

## Cause

We didn't have the right security permissions defined for the eventlog account in the registry

## Resolution

You can follow below steps for fixing the error.

- Checked NTFS permissions for C:\Windows\System32\winevt\Logs - Eventlog User has full control  
- Checked HKLM\SYSTEM\CurrentControlSet\Services\EventLog\Security - Eventlog has no permissions there.  
- Granted "NT service\EventLog" read permissions in `HKLM\SYSTEM\CurrentControlSet\Services\EventLog\Security`. (You have to do it by selecting the local computer account by clicking on "locations".  
- Reopened Event Viewer and confirmed that we can now read the security logs.
