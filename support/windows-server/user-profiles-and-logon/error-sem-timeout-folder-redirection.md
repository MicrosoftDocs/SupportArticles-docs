---
title: Folder Redirection fails with the error ERROR_SEM_TIMEOUT or the semaphore timeout period has expired
description: Helps fix an ERROR_SEM_TIMEOUT error that occurs when you find out the Folder Redirection policy isn't working on the client machine.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, tonnyp
ms.custom: sap:folder-redirection, csstroubleshoot
ms.subservice: user-profiles
---
# Folder Redirection fails with the error ERROR_SEM_TIMEOUT or the semaphore timeout period has expired

This article helps fix an ERROR_SEM_TIMEOUT error that occurs when you find out the Folder Redirection policy isn't working on the client machine.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2570355

## Symptoms

You have a computer running Windows Vista or Windows 7 in a domain. You find out the Folder Redirection policy is not working on the client machine. When you look at the event log, you see the following event logged:

> Log Name: Application  
Source: Microsoft-Windows-Folder Redirection  
Date: \<Date & Time>  
Event ID: 502  
Task Category: None  
Level: Error  
Keywords:  
User: \<User Name>  
Computer: \<Computer Name>  
Description:  
Failed to apply policy and redirect folder "Documents" to "\<a network share>".  
Redirection options=0x1219.  
The following error occurred: "Failed to copy files from "C:\\Users\\\<UserName>\\Documents" to "\<a network share>".  
Error details: "The semaphore timeout period has expired".

## Cause

This issue is caused by a file name or path name containing more than 259 characters.

## Resolution

Use the Process Monitor tool to identify the problematic file with long path name, and then delete it or reduce its path name.

## More information

Process Monitor is an advanced monitoring tool for Windows that shows real-time file system, Registry, and process/thread activity. Refer to the following web page for more information about this tool:

[Process Monitor v3.60](/sysinternals/downloads/procmon)

The following two errors share the same error number, and this is the reason why the error message "The semaphore timeout period has expired" is displayed.

> Error Number - Error Code - Meaning  
0x79 - ERROR_SEM_TIMEOUT - The semaphore timeout period has expired.  
0x79 - DE_PATHTOODEEP - The source or destination path exceeded or would exceed MAX_PATH.

Refer to the following web pages for more information about the two errors:

- [System Error Codes (0-499)](/windows/win32/debug/system-error-codes--0-499-)
- [SHFileOperationA function (shellapi.h)](/windows/win32/api/shellapi/nf-shellapi-shfileoperationa)
