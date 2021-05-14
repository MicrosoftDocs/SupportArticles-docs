---
title: Error Code 0x8004de40 when signing in to OneDrive 
description: Describes how to resolve an issue when unable to sign in to OneDrive
author: salarson
ms.author: v-matham
manager: dcscontentpm
localization_priority: Normal
ms.date: 05/11/2021
audience: Admin
ms.topic: article
ms.service: one-drive
ms.custom: 
- CSSTroubleshoot
- CI 149475
search.appverid:
- SPO160
- MET150
ms.assetid: 
appliesto:
- OneDrive for Business
---

# Error Code 0x8004de40 when signing in to OneDrive

## Symptoms

When you sign in to Microsoft OneDrive, you receive the following error message:  

> There was a problem signing you in.
>
> Login was either interrupted or unsuccessful. Please try logging in again. (Error Code: 0x8004de40) 

Error Code 0x8004de40 indicates OneDrive is having trouble connecting to the cloud.  

## Resolution

First, verify that you are connected to the internet. If the affected device is not connected, see [Fix Wi-Fi connection issues in Windows](https://go.microsoft.com/fwlink/?linkid=871051).

If the device is connected to the internet, continue to the following steps based on the version of Windows that the device is running.

**Windows 10**

If you are using Windows 10, restart the device while it’s connected to your Azure Active Directory (Azure AD) domain. If that doesn’t fix the problem, unjoin your device from Azure AD and rejoin it, by using the following steps.

> **Important**
>
> You must be connected to your organization’s network when you do these steps. Don’t do these steps if you aren’t connected to your organization’s infrastructure (for example, while traveling).

1. Open an elevated Command Prompt window. To do this, select **Start**, right-click **Command Prompt**, and then select **Run as administrator**.

1. Enter *dsregcmd /leave*, and press **Enter**.

1. After the command runs, type *dsregcmd /join*, and press **Enter**.

1. After the command runs, close the Command Prompt window.

1. Restart the computer, and log in to OneDrive.

**Windows 8 or Windows 7**

If you are using Windows 8 or Windows 7, see the following pages:

- [Update to enable TLS 1.1 and TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392)

- [Authentication errors when connecting to SharePoint or OneDrive from Windows 8 or 7](../../SharePointOnline/administration/authentication-errors-windows7.md)
