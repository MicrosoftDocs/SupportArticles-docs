---
title: Error 135011 when trying to activate Microsoft 365 Apps
ms.author: v-todmc
author: mccoybot
manager: dcscontentpm
ms.date: 9/4/2020
audience: Admin
ms.topic: article
ms.prod: microsoft-365
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft 365 Apps
ms.custom: 
- CI 122959
- CSSTroubleshoot 
ms.reviewer: vikkarti
description: Describes how to resolve error 135011 when trying to activate Microsoft 365 Apps.
---

# Error code 135011 when activating Microsoft 365 Apps

## Symptoms

You see the following error when trying to sign-in or activate Microsoft 365 Apps:

> Something went wrong
> 
> Your organization has disabled this device.
> 
> To fix this, contact your system administrator and provide the error code 135011. 
> 
> More information: <br />
> https://wmv.microsoft.com/wamerrors
 
## Cause

This issue can occur if the device was either deleted or disabled in Azure Active Directory (AD) and the action to delete or disable was not initiated by the device. 

## Resolution
 
To resolve the issue, follow the steps below, depending on your situation: 

- If the device was disabled in Azure AD, an administrator with sufficient privileges can enable it from the Azure AD portal:

    1. Sign-in to the [Azure portal](https://portal.azure.com/).
    2. Select **Azure Active Directory** > **Devices**.
    3. In **Devices**, search for a username or device name in the list of disabled devices. 
    4. Select the device, and then select **Enable**.

    For more information, see [Manage device identities using the Azure portal](https://docs.microsoft.com/azure/active-directory/devices/device-management-azure-portal#device-management-tasks).

- If the device was deleted in Azure AD, you will have to manually re-register the device. For detailed steps, see [Re-enable or re-register the device](https://docs.microsoft.com/azure/active-directory/devices/faq#q-i-disabled-or-deleted-my-device-in-the-azure-portal-or-by-using-windows-powershell-but-the-local-state-on-the-device-says-its-still-registered-what-should-i-do).


## More information

For more information on troubleshooting Office client-side sign-in related issues, see the following articles:

- [Disabling ADAL or WAM not recommended for fixing Office sign-in or activation issues](https://docs.microsoft.com/office365/troubleshoot/administration/disabling-adal-wam-not-recommended)
- [Connection issues in sign-in after update to Office 2016 build 16.0.7967 on Windows 10](https://docs.microsoft.com/office365/troubleshoot/authentication/connection-issue-when-sign-in-office-2016)
- [Reset Microsoft 365 Apps for enterprise activation state](https://docs.microsoft.com/office/troubleshoot/activation/reset-office-365-proplus-activation-state)
- [Fix authentication issues in Office applications when you try to connect to an Office 365 service](https://docs.microsoft.com/office365/troubleshoot/authentication/automatic-authentication-fails)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).