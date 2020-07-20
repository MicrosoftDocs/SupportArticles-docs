---
title: Can't install Azure Active Directory Sync tool
description: Describes an issue that triggers an error message when you try to install the Azure Active Directory Sync tool and event ID 0 and 1013 are logged. Provides a resolution.
ms.date: 07/20/2020
ms.prod-support-area-path: 
ms.reviewer: willfid
---
# Error when you try to install Azure Active Directory Sync tool: Microsoft Online Services Sign-in Assistant service installation returned FAIL

_Original product version:_ &nbsp; Office 365 Identity Management, Azure Active Directory, Cloud Services (Web roles/Worker roles), Microsoft Intune  
_Original KB number:_ &nbsp; 3073644

## Symptoms

When you try to install the Azure Active Directory Sync tool, you receive the following error message:

> The Microsoft Online Services Sign-in Assistant service installation returned FAIL. See the event log for more detailed information.
>
> Unable to uninstall the Windows Azure Active Directory Sync tool. Use the Control Panel to remove the Directory Sync tool.

Additionally, the following events are logged in Event Viewer:

> Event ID 0  
> Description: The Microsoft Online Services Sign-in Assistant service installation returned error code 1603.

> Event ID 1013  
> Product: Microsoft Online Services Sign-in Assistant--Newer version already installed.

## Cause

This issue may occur if a version of the Microsoft Online Services Sign-In Assistant is already installed on the computer. This prevents installation of the version of the Microsoft Online Services Sign-In Assistant that's included with the Azure Active Directory Sync tool.

## Resolution

To resolve this issue, follow these steps:

1. Use the **Program and Features** item in Control Panel to uninstall Microsoft Online Services Sign-In Assistant.

     If the Microsoft Online Services Sign-In Assistant isn't listed under **Programs and Features**, uninstall it by running the fix in the following Microsoft Fix it solution: [Fix problems that block program installation or removal](https://support.microsoft.com/help/17588)
2. Reinstall the Azure Active Directory Sync tool.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums/en-US/home?forum=windowsazuread) website.
