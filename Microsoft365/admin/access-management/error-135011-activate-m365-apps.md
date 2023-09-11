---
title: Your organization has disabled this device when trying to activate Microsoft 365 Apps
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 09/04/2020
audience: Admin
ms.topic: troubleshooting
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
description: 'Describes how to resolve the error Your organization has disabled this device when trying to activate Microsoft 365 Apps.'
---

# "Your organization has disabled this device" error when you try to activate Microsoft 365 Apps

## Symptoms

When you try to sign in to or activate Microsoft 365 apps, you receive the following error message: 

> **Something went wrong**  
> Your organization has disabled this device.  
> To fix this, contact your system administrator and provide the error code 135011.  
> More information:  
> `https://wmv.microsoft.com/wamerrors`

:::image type="content" source="media/error-135011-activate-m365-apps/error-135011-message.png" alt-text="Screenshot of error 135011.":::

## Cause

This issue can occur if the device was either deleted or disabled in Azure Active Directory (AD), and the action was not initiated for the device itself. 

## Resolution
 
To resolve the issue, follow the steps: 

- If the device was disabled in Azure AD, an administrator who has sufficient privileges can re-enable it from the Azure AD portal, as follows:

    1. Sign in to the [Azure portal](https://portal.azure.com/).
    2. Select **Azure Active Directory** > **Devices**.
    3. Examine the disabled devices list in **Devices**, by searching on the username or device name. 
    4. Select the device, and then select **Enable**.

    For more information, see [Manage device identities using the Azure portal](/azure/active-directory/devices/device-management-azure-portal#device-management-tasks).

- If the device was deleted in Azure AD, you  have to re-register it manually. For detailed steps to do this, see [Re-enable or re-register the device](/azure/active-directory/devices/faq#q-i-disabled-or-deleted-my-device-in-the-azure-portal-or-by-using-windows-powershell-but-the-local-state-on-the-device-says-its-still-registered-what-should-i-do).


## More information

For more information about how to troubleshoot Microsoft Office client-side sign-in related issues, see the following articles:

- [Disabling ADAL or WAM not recommended for fixing Office sign-in or activation issues](../administration/disabling-adal-wam-not-recommended.md)
- [Connection issues in sign-in after update to Office 2016 build 16.0.7967 on Windows 10](../authentication/connection-issue-when-sign-in-office-2016.md)
- [Reset Microsoft 365 Apps for enterprise activation state](/office/troubleshoot/activation/reset-office-365-proplus-activation-state)
- [Fix authentication issues in Office applications when you try to connect to a Microsoft 365 service](../authentication/automatic-authentication-fails.md)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
