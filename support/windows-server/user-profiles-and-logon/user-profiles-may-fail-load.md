---
title: User profiles may fail to load
description: Describes an issue in which user profiles may fail to load after you install the Windows RT 8.1, Windows 8.1, or Windows Server 2012 R2 update that is dated April 2014.
ms.date: 10/23/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, AJAYPS
ms.prod-support-area-path: User Logon fails
ms.technology: UserProfilesAndLogon
---
# User profiles may fail to load after you install the Windows 8.1, or Windows Server 2012 R2 April 2014 update

This article provides a solution to an issue where user profiles may fail to load after you install the Windows RT 8.1, Windows 8.1, or Windows Server 2012 R2 update that is dated April 2014.

_Original product version:_ &nbsp; Windows 8.1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2985344

## Symptoms

Consider the following situations:

- You have Windows 8.1 computers in your domain.
- You configure users to use Roaming User Profiles when they sign in to the Windows 8.1 computers.
- You install the Windows RT 8.1, Windows 8.1, or Windows Server 2012 R2 [update](https://support.microsoft.com/help/2919355) that is dated April 2014 on the Windows 8.1 computers.

In this scenario, after the update is installed, any user who tries to sign in for the first time to any of the Windows 8.1 computers can't do so. Additionally, the user will receive the following error:

> The User Profile Service failed the logon. User profile cannot be loaded.

In addition, you may notice the following errors in the event log.

## Cause

This issue may occur if you have Microsoft Application Virtualization 5.0 Service Pack 2 installed.

## Resolution

Install the [Hotfix Package 5 for Microsoft Application Virtualization 5.0 Service Pack 2](https://support.microsoft.com/help/2963211) detailed here on all computers where you're facing the issue.
