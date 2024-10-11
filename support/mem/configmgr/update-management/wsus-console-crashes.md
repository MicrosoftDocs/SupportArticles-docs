---
title: The Windows Server Update Services console crashes
description: Fixes an issue where the Windows Server Update Services (WSUS) console crashes because of the corrupted application cache.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Software Update Management (SUM)\WSUS Performance or Crashes
---
# The Windows Server Update Services console crashes when browsing for updates

This article helps you fix an issue where the Windows Server Update Services (WSUS) console crashes because of the corrupted application cache.

_Original product version:_ &nbsp; Windows Server Update Services  
_Original KB number:_ &nbsp; 2761925

## Symptoms

The WSUS console crashes when browsing for updates and displays the following error message:

> An unexpected error occurred.  
> click reset server node to try to connect to the server again

> Event Type: Error  
> Event Source: Windows Server Update Services  
> Event Category: None  
> Event ID: 7053  
> Date:  
> Time:  
> User: N/A  
> Computer:  
> Description: The WSUS administration console has encountered an unexpected error. This may be a transient error; try restarting the administration console.

## Cause

This can occur if the application cache is corrupted.

## Resolution

To resolve this issue, delete the WSUS application cache from the location below:

`C:\Documents and Settings\<user profile>\application data\microsoft\mmc`

where \<user profile> is the currently logged in user profile.
