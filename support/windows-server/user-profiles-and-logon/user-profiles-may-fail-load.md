---
title: User profiles may fail to load
description: Describes an issue in which user profiles may fail to load after you install the Windows RT 8.1, Windows 8.1, or Windows Server 2012 R2 update that is dated April 2014.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, AJAYPS
ms.custom: sap:user-logon-fails, csstroubleshoot
---
# User profiles may fail to load after you install the Windows 8.1, or Windows Server 2012 R2 April 2014 update

This article provides a solution to an issue where user profiles may fail to load after you install the Windows RT 8.1, Windows 8.1, or Windows Server 2012 R2 update that is dated April 2014.

_Applies to:_ &nbsp; Windows 8.1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2985344

## Symptoms

Consider the following situations:

- You have Windows 8.1 computers in your domain.
- You configure users to use Roaming User Profiles when they sign in to the Windows 8.1 computers.
- You install the Windows RT 8.1, Windows 8.1, or Windows Server 2012 R2 [update](https://support.microsoft.com/help/2919355) that is dated April 2014 on the Windows 8.1 computers.

In this scenario, after the update is installed, any user who tries to sign in for the first time to any of the Windows 8.1 computers can't do so. Additionally, the user will receive the following error:

> The User Profile Service failed the logon. User profile cannot be loaded.

In addition, you may notice the following errors in the event log:

> Log Name: Application  
Source:        Microsoft-Windows-User Profiles General  
Date:          *\<DateTime>*  
Event ID:      1509  
Task Category: None  
Level:         Warning  
Keywords:  
User:          Contoso\\User1  
Computer:      Computer.Contoso.com  
Description:  
Windows cannot copy file \\\\?\\UNC\\contoso.com\\Users\\Profiles\\User1.V4\\AppData\\Roaming\\ApplicationName\\Program Settings\\0000.ex to location \\\\?\\C:\\Users\\User1\\AppData\\Roaming\\ApplicationName\\Program Settings\\0000.ex. This error may be caused by network problems or insufficient security rights.  
>
> DETAIL - The process cannot access the file because it is being used by another process.

> Log Name:      Application  
Source:        Microsoft-Windows-User Profiles Service  
Date:          *\<DateTime>*  
Event ID:      1500  
Task Category: None  
Level:         Error  
Keywords:  
User:          Contoso\\User1  
Computer:      Computer.contoso.com  
Description:  
Windows cannot log you on because your profile cannot be loaded. Check that you are connected to the network, and that your network is functioning correctly.  
>
> DETAIL - Unspecified error

## Cause

This issue may occur if you have Microsoft Application Virtualization 5.0 Service Pack 2 installed.

## Resolution

Install the [Hotfix Package 5 for Microsoft Application Virtualization 5.0 Service Pack 2](https://support.microsoft.com/help/2963211) detailed here on all computers where you're facing the issue.
