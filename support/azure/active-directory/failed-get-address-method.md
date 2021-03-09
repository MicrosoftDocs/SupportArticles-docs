---
title: Error (Failed to get address for method) when you run the Azure Active Directory Sync tool configuration wizard
description: Describes an error message that you receive when you run the Azure Active Directory Sync tool configuration wizard. Provides a resolution.
ms.date: 07/06/2020
ms.prod-support-area-path: 
ms.reviewer: aconkle
---
# Error when you run the Azure Active Directory Sync tool configuration wizard: Failed to get address for method: CreateIdentityHandle2

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Azure Active Directory, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 3037953

## Symptoms

When you run the Microsoft Azure Active Directory Sync tool configuration wizard, you receive the following error message:

> Failed to get address for method: CreateIdentityHandle2 from library C:\Program Files\Common Files\Microsoft Shared\Microsoft Online Services\msoidcli.dll. GetLastError code: 127

## Cause

This problem occurs if you're running an earlier version of the Microsoft Online Services Sign-in Assistant.

## Resolution

To resolve this issue, follow these steps:

1. Uninstall any versions of the Microsoft Online Services Sign-in Assistant that are currently installed on the directory synchronization computer.
2. Install the latest version of the Microsoft Online Services Sign-In Assistant from [Microsoft Online Services Sign-In Assistant for IT Professionals RTW](https://www.microsoft.com/download/details.aspx?id=28177).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums/en-US/home?forum=windowsazuread) website.
