---
title: Error AADSTS700003 - Device Object Was Not Found in the Tenant Directory
description: Provides a solution to an issue where you experience the AADSTS700003 error when you try to sign in to an Azure application that can be used with Microsoft Entra ID.
ms.service: entra-id
ms.date: 02/14/2025
ms.reviewer: jutakata, willfid, bachoang, joaos, modawud, v-weizhu
ms.custom: sap:Issues Signing In to Applications
---

# Error AADSTS700003 - Device object was not found in the tenant '\<TenantName\>' directory

This article discusses how to resolve the "AADSTS700003" error that occurs when you try to sign in to an application that's integrated into Microsoft Entra ID.

## Symptoms

When your try to sign in to an application that's integrated into Microsoft Entra ID, you receive an "AADSTS700003" error with one of the following error messages:

- Device object was not found in the tenant '\<TenantName\>' directory.
- Your organization has deleted this device.

## Cause

This issue occurs because the device object is deleted on your home tenant. When a device is deleted, the "Delete device" activity type is recorded in the [Microsoft Entra audit log](/entra/identity/monitoring-health/concept-audit-logs). In Microsoft Entra ID, there are three ways to register or join user devices:

- Microsoft Entra registered
- Microsoft Entra joined
- Microsoft Entra hybrid joined

Device registration or join creates a [device identity](/entra/identity/devices/overview). This device identity is used in scenarios such as [device-based Conditional Access policies](/entra/identity/conditional-access/concept-conditional-access-grant) and [Mobile Device Management with Microsoft Intune](/mem/endpoint-manager-overview). When you receive the AADSTS700003 error, the device object isn't found in the tenant.

## Solution

Engage the home tenant administrators to determine when and why your device object is deleted. Then, take the corresponding action depending on the device registration/join type, as shown in the following table: 

| Device join type | Action |
|--|--|
| Microsoft Entra registered | For Windows 10/11 Microsoft Entra registered devices, go to **Settings** > **Accounts** > **Access Work or School**. Select your work or school account on the screen. Select **Disconnect** to disconnect the device. Then, register the device to Microsoft Entra ID again.<br/><br/>For iOS and Android, you can use the Microsoft Authenticator application and select **Settings** > **Device Registration** > **Unregister device**. Then, register the device to Microsoft Entra ID again.<br/><br/>For macOS, you can use the Microsoft Intune Company Portal application to unenroll the device from management and remove any registration. Then, register the device to Microsoft Entra ID again.<br/><br/> For more information, see [Microsoft Entra register FAQ](/entra/identity/devices/faq#how-do-i-remove-a-microsoft-entra-registered-state-for-a-device-locally).|
| Microsoft Entra joined | Open a PowerShell console with the administrative right on the Windows device, and run the `dsregcmd /forcerecovery` command. Select **Sign in** to sign in with your Microsoft Entra ID account. |
| Microsoft Entra hybrid joined | Open a PowerShell console with the administrative right on the Windows device, and run the `dsregcmd /leave` command. Then, reboot the device and sign in to the device with your domain credential. |

## More information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-error-codes).

To investigate individual errors, go to [https://login.microsoftonline.com/error](https://login.microsoftonline.com/error).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]