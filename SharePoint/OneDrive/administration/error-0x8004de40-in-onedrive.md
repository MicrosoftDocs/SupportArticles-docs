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

> OneDrive Can't sign in. Error 0x8004de40
>
> Login was either interrupted or unsuccessful. Please try logging in again. (Error Code: 0x8004de40) 

Error Code 0x8004de40 indicates OneDrive is having trouble connecting to the cloud.  

## Resolution

First, verify that you are connected to the internet. If the affected device is not connected, see [Fix Wi-Fi connection issues in Windows](https://go.microsoft.com/fwlink/?linkid=871051).

Ensure you have carefully reviewed information about [TLS deprecation](https://docs.microsoft.com/en-us/microsoft-365/compliance/tls-1.0-and-1.1-deprecation-for-office-365?view=o365-worldwide) which may also cause this error. 

 > [!NOTE]
 > Special Notice: Even after upgrading to TLS 1.2, it is important to make sure cipher suites match AFD support because M365 and AFD have a slight difference cipher suite support. 
>
> For TLS1.2 the following cipher suites are supported by AFD:
> TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
> TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
> TLS_DHE_RSA_WITH_AES_256_GCM_SHA384
> TLS_DHE_RSA_WITH_AES_128_GCM_SHA256
> [What are the current cipher suites supported by Azure Front Door?](https://docs.microsoft.com/en-us/azure/frontdoor/front-door-faq#what-are-the-current-cipher-suites-supported-by-azure-front-door-)

If the device is connected to the internet and TLS has been updated, continue to the following steps based on the version of Windows that the device is running.

### Windows 10

If you're using Windows 10, restart the device while it’s connected to your Azure Active Directory (Azure AD) domain. If that doesn’t fix the problem, unjoin your device from Azure AD and rejoin it, by using the following steps.

> [!IMPORTANT]
> You must be connected to your organization’s network when you do these steps. Don’t do these steps if you aren’t connected to your organization’s infrastructure (for example, while traveling).

1. Open an elevated Command Prompt window. To do so, select **Start**, right-click **Command Prompt**, and then select **Run as administrator**.
1. Enter *`dsregcmd /leave`*, and press **Enter**.
1. After the command runs, type *`dsregcmd /join`*, and press **Enter**.
1. After the command runs, close the Command Prompt window.
1. Restart the computer, and log in to OneDrive.

Consider checking TLS Protocols on the machine.

1. Press Windows key + R on your keyboard to open the RUN program.
2. Now, type inetcpl.cpl and press Enter.
3. Go to the Advanced tab > Enable all three TLS protocols by check-marking the box for TLS 1.0, TLS 1.1, and TLS 1.2 options.
4. 	Click on Apply and then OK to save changes.

### Windows 8 or Windows 7

If you are using Windows 8 or Windows 7, see the following pages:

- [Update to enable TLS 1.1 and TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392)
- [Authentication errors when connecting to SharePoint or OneDrive from Windows 8 or 7](../../SharePointOnline/administration/authentication-errors-windows7.md)

## All Machines

If all above steps have been completed please consider a [Reset of OneDrive](https://support.microsoft.com/en-us/office/reset-onedrive-34701e00-bf7b-42db-b960-84905399050c)

## References

- [TLS cipher suites supported by Office 365](/microsoft-365/compliance/technical-reference-details-about-encryption?view=o365-worldwide#tls-cipher-suites-supported-by-office-365&preserve-view=true)
- [Preparing for TLS 1.2 in Office 365 and Office 365 GCC](/microsoft-365/compliance/prepare-tls-1.2-in-office-365?view=o365-worldwide&preserve-view=true)
