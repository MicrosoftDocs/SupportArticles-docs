---
title: Outlook prompts for credentials
description: After the password for your domain user account is changed, Outlook 2010 and Outlook 2013 may prompt you for your password. This article describes how to remove older saved credentials to make sure that Outlook uses your current Windows desktop credentials.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Network disconnects, password or credentials prompt
  - Outlook for Windows
  - CI 116784
  - CSSTroubleshoot
ms.reviewer: aruiz, gbratton, meshel
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook continues to prompt for credentials after your domain password changes

## Symptoms

After the password for your domain user account is changed, Microsoft Outlook 2010 and Microsoft Outlook 2013 may prompt you for your password. After you enter the new password and then click to enable the **Remember my credentials** option, you are not prompted again during the current Windows session. However, if you log off Windows, log back in, and start Outlook, you are again prompted for your credentials.

## Cause

Before your password changed, you saved your credentials. The stored credentials are not overwritten when Outlook triggers the authentication prompt even if you enable the **Remember my credentials** option.

## Resolution

To resolve this problem, install the latest update for Outlook 2010 or Outlook 2013. For more information about the latest updates for Microsoft Outlook, see [How to install the latest applicable updates for Microsoft Outlook (US English only)](../deployment/install-outlook-latest-updates.md).

## Workaround

If you are unable to install the latest update for Outlook 2010 or Outlook 2013, you can work around this issue by removing all previously saved credentials. To remove stored credentials and force Outlook to use your Windows desktop credentials, follow these steps.

1. Click **Start**, click **Control Panel**, and then click **Credential Manager**.

   > [!NOTE]
   > If **View by** is set to **Category**, click **User Accounts** first, and then click **Credential Manager**.

2. Locate the set of credentials that has **Outlook** in the name.
3. Click the name to expand the set of credentials, and then click **Remove from Vault**.
4. Repeat step 3 for any additional sets of credentials that have the word **Outlook** in the name.

## More Information

If your administrator uses the Microsoft Office Group Policy templates, they may configure Outlook not to save Basic Authentication credentials. If they do this, the **Remember my credentials** option is still available in the password prompt, but has no effect when you enable it. For more information about the effect of this policy setting, see [Policy to prevent Outlook from saving basic authentication credentials seems not to work](prevent-saving-credentials.md).
