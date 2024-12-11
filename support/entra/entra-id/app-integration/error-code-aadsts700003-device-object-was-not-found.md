---
title: Error AADSTS700003 - Device object was not found in the tenant '{tenantName}' directory
description: Provides a solution to an issue where a user experiences the AADSTS700003 error when they try to sign in to an Azure app that can be used with Microsoft Entra ID.
ms.service: entra-id
ms.date: 12/01/2024
ms.reviewer: 
ms.custom: sap:Issues Signing In to Applications
---

# Error AADSTS700003 - Device object was not found in the tenant '{tenantName}' directory

This article discusses how to resolve the "AADSTS700003" error that occurs when a user tries to sign in to an application that can be used together with Microsoft Entra ID.

## Symptoms

When users try to sign in to an application that's integrated into Microsoft Entra ID, they receive an "AADSTS700003" error message ("Device object was not found in the tenant '{tenantName}' directory.") or "Your organization has deleted this device."

## Cause

The device object was deleted on the user's home tenant. When a device is deleted, "Delete device" activity type is recorded in [Microsoft Entra audit log](https://learn.microsoft.com/entra/identity/monitoring-health/concept-audit-logs). In Microsoft Entra ID, there are three ways to register or join user devices.

- Microsoft Entra registred
- Microsoft Entra joined
- Microsoft Entra hybrid joined

Device registration or join creates a [device identity](https://learn.microsoft.com/entra/identity/devices/overview) which is used in scenarios like [device-based Conditional Access policies](https://learn.microsoft.com/entra/identity/conditional-access/concept-conditional-access-grant) and [Mobile Device Management with the Microsoft Intune](https://learn.microsoft.com/mem/endpoint-manager-overview). When users get AADSTS700003 error, the device object was not found in the tenant.

## Solution

Engage the home tenant administrators to determine when and why your device object was deleted. Then, take the corresponding action depending on the device registration/join types, as shown in the following table. 

| Device join type | Action |
|--|--|
| Microsoft Entra registered | For Windows 10/11 Microsoft Entra registered devices, open **Settings**, and then select **Accounts**. Select **Access work or school**, and click on your work or school account on the screen. Select **Disconnect** to disconnect the device. Then, register the device to Microsoft Entra ID again.<br/><br/>For iOS and Android, you can use the Microsoft Authenticator application **Settings** > **Device Registration** and select **Unregister device**. Then, register the device to Microsoft Entra ID again.<br/><br/>For macOS, you can use the Microsoft Intune Company Portal application to unenroll the device from management and remove any registration. Then, register the device to Microsoft Entra ID again. |
| Microsoft Entra joined | Open a PowerShell console with administrative right on the Windows device, and run **dsregcmd /forcerecovery** command. Select **Sign in** to sign in with your Microsoft Entra ID account. |
| Microsoft Entra hybrid joined | Open a PowerShell console with administrative right on the Windows device, and run **dsregcmd /leave** command. Reboot the device and sign in to the device with your domain credential. |

## More information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-error-codes).

To investigate individual errors, go to [https://login.microsoftonline.com/error](https://login.microsoftonline.com/error).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
