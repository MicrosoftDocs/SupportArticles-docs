---
title: Redirecting the user's Documents folder to their home directory fails when Grant the user exclusive rights to Documents is selected
description: Fixes an issue where you can't redirect the user's Documents folder to their home directory.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kimnich, kaushika
ms.custom: sap:Network Connectivity and File Sharing\Offline Files and Folders (CSC), csstroubleshoot
---
# Redirecting the user's Documents folder to their home directory fails when Grant the user exclusive rights to Documents is selected

This article helps fix an issue where you can't redirect the user's Documents folder to their home directory when "Grant the user exclusive rights to Documents" is selected.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2493506

## Symptoms

Using Folder Redirection policy to redirect the user's Documents folder to their home directory, when "Grant the user exclusive rights to Documents" is selected, fails to create the Synchronization Partnership and fails to copy the Documents data to the home directory.

The following error is logged in the Application Event Log:

> Log Name: Application  
Source: Microsoft-Windows-Folder Redirection  
Date: \<DateTime>  
Event ID: 502  
Task Category: None  
Level: Error  
Keywords:  
User: `contoso.com\jim`  
Computer: `Win7-1.contoso.com`  
Description:  
Failed to apply policy and redirect folder "Documents" to "\\\\`contoso.com`\\home\\jim\\".  
Redirection options=0x1211.  
The following error occurred: "Can not create folder "\\\\`contoso.com`\\home\\jim".  
 Error details: "This security ID may not be assigned as the owner of this object."  

## Cause

1. You have a computer running Vista SP1 or Windows 7
2. Folder Redirection Policy is configured to redirect the Documents folder to the user's home directory
3. "Grant the user exclusive rights to Documents" - enabled
4. "Also apply redirection policy to Windows 2000, Windows 200 Server, Windows XP, and Windows Server 2003 operating systems" - disabled

In this configuration, the Synchronization Partnership isn't created and therefore the documents in the home directory and local profile aren't merged.

## Resolution

Do one of the following:

1. Enable both "Grant the user exclusive rights to Documents" and "Also apply redirection policy to Windows 2000, Windows 200 Server, Windows XP, and Windows Server 2003 operating systems". When both are enabled, then the Synchronization Partnership is successfully created and documents are synchronized between the local profile and the home directory.

    -- OR --

2. Disable both "Grant the user exclusive rights to Documents" and "Also apply redirection policy to Windows 2000, Windows 200 Server, Windows XP, and Windows Server 2003 operating systems". When both are disabled, then the Synchronization Partnership is successfully created and documents are synchronized between the local profile and the home directory.
