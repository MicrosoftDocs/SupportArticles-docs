---
title: Store Commerce app (POS) is suddenly deactivated
description: This article lists the causes and provides resolutions for the issue that the Store Commerce app (POS) is deactivated.
author: bstorie
ms.author: brstor
ms.date: 05/22/2025
ms.custom: sap:Point of sale (POS)\Issues with device and register setup and configuration
---
# Dynamics 365 Commerce Store Commerce app is suddenly deactivated

This article helps you diagnose and resolve issues that may cause the Store Commerce app (POS) to be deactivated.

## Symptoms

After you start the Microsoft Dynamics 365 Commerce [Store Commerce app (POS)](/dynamics365/commerce/dev-itpro/store-commerce), its status always shows **De-activated**. Additionally, the Store Commerce app prompts you to complete the activation process.

## Prerequisites

Ensure you have access to **Commerce HQ** > **Modules** > **Retail and Commerce** > **Channel Setup** > **POS setup** > **Devices**.

## Cause 1: The device token has expired

When the Store Commerce app is activated, a device token is issued and stored in the installation folder. Each time you start the Store Commerce app, the token's issue date is compared to the maximum token lifetime parameter configured in Commerce headquarters.  If the token's age exceeds the configured lifetime, the token is considered invalid, and the Store Commerce app prompts for reactivation.

#### Resolution: Check the device token settings in Commerce headquarters

1. Sign in to **Commerce HQ** > **Modules** > **Retail and Commerce** > **HQ Setup** > **Parameters** > **Commerce Shared Parameters**.
2. Select the **Security** tab.
3. Review the value in the **Device token lifetime** field.

     - By default, this value is set to **365 days**, but it can be increased to a maximum of 5,120 days. This value is the maximum number of days the token is valid after activating a Store Commerce app.
     - If you increase this value, the Store Commerce apps that are currently activated will remain activated until their token lifetime reaches the new value set.

4. Go to **Commerce HQ** > **Modules** > **Retail and Commerce** > **Channel Setup** > **POS setup** > **Devices**.
5. Select the device record that prompts for activation.
6. Review the value in the **Activated date and time** field.

    - If this date is earlier than the number of days set for the device token lifetime, the token for the Store Commerce app has exceeded its lifetime.
    - The value in this field updates automatically each time the Store Commerce app is activated. It's important to check this field before triggering a new activation.

7. If the Store Commerce app's token has expired, you can reactivate the Store Commerce app.

## Cause 2: The configuration file in the user profile folder is modified

By default, the Store Commerce app stores the configuration settings in a file under the path _C:\Windows\users\{User account}\Appdata\local\packages_.

Some Windows updates can inadvertently modify or delete files in this path. In this case, the Store Commerce app configuration file is removed, and the Store Commerce app no longer registers as activated.

#### Resolution 1: Check the Windows update history

Check if the Windows update history lists any updates that were recently applied to your computer.

If this is a reoccurring issue, consider rerunning the Store Commerce app installer together with the `usecommonapplicationdata` flag.

> [!NOTE]
> When the `usecommonapplicationdata` flag is used, the Store Commerce app configuration file will be stored in the _C:\Program Data\_ folder instead.

#### Resolution 2: Check the security software

Check if the security software scanned the `C:\Windows\users\{User account}\Appdata\local\packages\Microsoft` directory and detected any files.

If this is a reoccurring issue, consider rerunning the Store Commerce app installer together with the `usecommonapplicationdata` flag.

> [!NOTE]
> When the `usecommonapplicationdata` flag is used, the Store Commerce app configuration file will be stored in the _C:\Program Data\_ folder instead.

## Cause 3: The browser history is cleared

Store Commerce for web (Cloud POS) is a browser-based access system. It stores the Store Commerce app activation state in the web browser history. If you clear the web browser history, the Store Commerce app will no longer report as activated.

If you activate the Store Commerce app using an InPrivate window in a browser, its activation state will be lost once you close the browser. 

#### Resolution: Check the browser settings and extensions

Check your browser's settings and extensions to make sure they don't clear the browser history when you close the web browser or tab.

## Reference

For more information about the Store Commerce app installation parameters, see [Store Commerce app](/dynamics365/commerce/dev-itpro/store-commerce).
