---
title: Unable to install Azure Active Directory module for Windows PowerShell
description: Describes an issue in which you can't install Azure Active Directory module for Windows PowerShell. Provides a resolution.
ms.date: 05/22/2020
ms.reviewer: willfid
ms.service: entra-id
ms.subservice: users
ms.custom:
---
# Error when you try to install Azure Active Directory module for Windows PowerShell: You must have Windows PowerShell 2.0 or greater installed

This article describes an issue in which you can't install Azure Active Directory module for Windows PowerShell. It provides a resolution.

_Original product version:_ &nbsp; Microsoft Entra ID, Office 365 User and Domain Management, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2913017

## Symptoms

When you try to install Azure Active Directory module for Windows PowerShell, you receive the following error message:

> In order to install Windows Azure Active Directory module for PowerShell, you must have Windows PowerShell 2.0 or greater installed on this computer.

## Resolution

To resolve this issue, try one of the following methods. If one doesn't work for you, try another one.

### Method 1: Install Azure Active Directory module for Windows PowerShell when you log on as local admin

1. Log on as a local admin. (Just logging on as a domain admin may not work.)
2. Install [Azure Active Directory module for PowerShell](/previous-versions/azure/jj151815(v=azure.100)?redirectedfrom=MSDN#install-the-azure-ad-module).

### Method 2: Make sure that Windows PowerShell 2.0 is enabled

1. Log on as a local admin. (Just logging on as a domain admin may not work.)
2. In Control Panel, select **Programs and Features**, or select **Uninstall a program** under **Programs**.
3. Select **Turn Window features on or off**.
4. In the Windows Feature window, make sure that the **Windows PowerShell 2.0** checkbox is selected, and then select **OK**.
5. Install [Azure Active Directory module for PowerShell](/previous-versions/azure/jj151815(v=azure.100)?redirectedfrom=MSDN#install-the-azure-ad-module).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
