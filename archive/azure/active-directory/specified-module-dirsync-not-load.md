---
title: Error (Specified module DirSync was not loaded) when you try to import the module for the Azure Active Directory Sync tool
description: Describes that you receive an error message when you use the Import-Module command to import the module for the Azure Active Directory Sync tool. Provides a resolution.
ms.date: 06/08/2020
ms.prod-support-area-path: 
ms.reviewer: willfid
---
# Error when you try to import the module for the Azure Active Directory Sync tool: Specified module 'DirSync' was not loaded

You may receive an error message when you use the `Import-Module` command to import the module for the Azure Active Directory Sync tool.

_Original product version:_ &nbsp; Office 365 Identity Management, Azure Active Directory, Cloud Services (Web roles/Worker roles), Microsoft Intune, Azure Backup  
_Original KB number:_ &nbsp; 3001140

## Symptoms

When you try to use the `Import-Module` command to import the module for the Microsoft Azure Active Directory Sync tool, you receive the following error message:

> Import-Module: The specified module 'DirSync' was not loaded because no valid module file was found in any module directory.

## Cause

You don't have the version of the Azure Active Directory Sync tool installed that supports the `Import-Module` command.

## Resolution

Install the latest version of the Azure Active Directory Sync tool. To obtain the latest version, see the following Microsoft TechNet topic:

[Install or upgrade the Directory Sync tool](https://technet.microsoft.com/library/jj151800.aspx)

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums) website.
