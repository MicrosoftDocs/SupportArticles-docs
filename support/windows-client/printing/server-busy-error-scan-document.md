---
title: (Server Busy) error message when you try to scan a document
description: Provides a resolution for fixing (Server Busy) error when you try to scan a document
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, philipd, match
ms.custom: sap:Print, Fax, and Scan\Windows Fax and Scan (Client), csstroubleshoot
---
# "Server Busy" error message when you try to scan a document  

This article provides a resolution for fixing "Server Busy" error when you try to scan a document.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2971655

## Symptoms

Consider the following scenario:
- You are running a 64-bit (x64) version of Windows 8.1, Windows 8, or Windows 7.
- You are running a 32-bit scanning application.
- You are using a scanner that uses the TWAIN 1.0 default interface.
- You try to scan a document.  

In this scenario, you are prompted by a "What do you want to scan?" message. The message window also displays options to configure the scanner. After several seconds, you receive the following error message:  
>Server Busy

## Cause

This problem occurs because a 32-bit scanning application is running in a 64-bit version of Windows. In this situation, the drivers for the scanner are loaded during a separate Wiawow64.exe process. The "What do you want to scan?" message is part of the Wiawow64 process. The error message is caused by an OLE call from the 32-bit scanning application. This problem occurs because the OLE call has a time-out value that expires while the scanning application is waiting for user input in the "What do you want to scan?" window. 

## Resolution

To resolve this problem, we recommend that you contact the scanning application vendor to have them update the application.

## More information

If you are a developer, see the following information:

When you call the AfxOleInit(); function, the *m_nTimeout*  parameter is set to a default value of 8 seconds. To disable the time-out of the OLE call, you must add the following line after you call the AfxOleInit(); function:
>AfxOleGetMessageFilter()->EnableNotRespondingDialog(FALSE);  

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
