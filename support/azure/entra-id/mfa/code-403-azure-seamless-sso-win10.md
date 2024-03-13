---
title: Code 403 (Forbidden) when you use Azure Seamless Single Sign-On on Windows 10
description: Resolves a problem in which you receive Code 403 (Forbidden) when you use Azure Seamless Single Sign-On on Windows 10.
ms.date: 05/22/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: authentication
---
# Code 403 (Forbidden) when you use Azure Seamless Single Sign-On on Windows 10

This article can help you resolve a problem in which you receive Code 403 (Forbidden) when using Azure Seamless Single Sign-On on Windows 10.

_Original product version:_ &nbsp; Microsoft Entra ID, Windows 10  
_Original KB number:_ &nbsp; 4135083

## Symptoms

The Azure Seamless Single Sign-On authentication does not work after you upgrade to Windows 10. When this problem occurs, you may receive the following error message:

> Integrated Windows Authentication failed with status code 403 (Forbidden).

## Resolution

To resolve this problem, follow these steps:

1. Check the following Group Policy object, and make sure that it is set to **not defined**:

    **Network security: Configure encryption types allowed for Kerberos**  

    If you update the Group Policy setting, run `gpupdate /force` to push the changes to the devices.
2. Start Registry Editor, and browse to the following subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\kerberos\parameters`
3. Delete the `supportedencryptiontypes` DWORD entry if it exists.
4. Restart the device.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
