---
title: Microsoft-Windows-AppReadiness event ID 215 error
description: Describes a Microsoft-Windows-AppReadiness event ID 215 error that occurs in Windows.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Desktop and Shell Experience\Modern, Inbox and Microsoft Store Apps, csstroubleshoot
---
# Microsoft-Windows-AppReadiness event ID 215 error after a user first logs on

This article explains the Microsoft-Windows-AppReadiness event ID 215 error that occurs after a user first logs on.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2916750

## Symptoms

When a local user logs onto a Windows 8.1 or Windows Server 2012 R2-based computer, a Microsoft-Windows-AppReadiness event ID 215 error is received.

> [!NOTE]
> The event log varies slightly, depending on the operating system.

For example, the following event log is received if the computer is running Windows Server 2012 R2:

> Log Name: Microsoft-Windows-AppReadiness/Admin  
Source: Microsoft-Windows-AppReadiness  
Date: **date**  
Event ID: 215  
Task Category: (1)  
Level: Error  
Keywords: (2)  
User: SYSTEM  
Computer: **computer**  
Description:
'ART:ResolveStoreCategories' failed for Administrator. Error: 'Class not registered' (0.015623 second)

The following event log is received if the computer is running Windows 8.1:

> Log Name: Microsoft-Windows-AppReadiness/Admin  
Source: Microsoft-Windows-AppReadiness  
Date: **date**  
Event ID: 215  
Task Category: (1)  
Level: Error  
Keywords: (2)  
User: SYSTEM  
Computer: **computer**  
Description:
'ART:ResolveStoreCategories' failed for Local_Users. Error: 'The network location cannot be reached. For information about network troubleshooting, see Windows Help.' (0.2968801 second)

## Cause

The issue occurs because the AppReadiness service queries the Microsoft Store for the category names that are associated with the Microsoft Store Apps installed on the computer when a user logs on for the first time.

The AppReadiness service generates the event logs if the task that obtains the category names fails. A local user account does not have an associated Microsoft account to be used to connect to the Microsoft Store to retrieve the requested data. Therefore, when a local user logs on, the issue that is described in the Symptoms section occurs.

> [!NOTE]
> The category name is used when you sort Apps by category in the All Apps view of the Start screen. The All Apps view is opened when you click the down arrow button near the bottom of the Start screen.

## Resolution

This error can be safely ignored.
