---
title: Outlook for Mac repeatedly prompts for credentials
description: Describes an issue in which you're repeatedly prompted for your credentials in Outlook for Mac version 15.21 when you use a federated account and modern authentication is enabled. Provides a resolution.
ms.author: meerak
author: cloud-writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: sercast, tasitae
ms.custom: 
  - sap:Connectivity
  - Outlook for Mac
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Outlook 2016 for Mac
ms.date: 01/30/2024
---
# You're repeatedly prompted for credentials when using modern authentication in Outlook 2016 for Mac

_Original KB number:_ &nbsp; 3156719

## Symptoms

You're using Outlook 2016 for Mac version 15.20 or later versions to connect to an Exchange Online mailbox through a federated account, and modern authentication is enabled.

When you try to connect to the Exchange Online mailbox, your provider's Active Directory Federation Services (AD FS) authentication dialog box is displayed, and you enter your credentials. However, you're repeatedly prompted for your credentials after you've already entered them.

## Cause

This issue occurs if the following conditions are true:

- Your email address differs from your user principal name (UPN).
- You entered your email address in the **User name** field of the **Accounts** dialog box in Outlook 2016 for Mac.

In this situation, you have to manually enter your UPN in the Username field in the AD FS dialog box of your provider.

## Resolution

Enter your UPN in the User name field of the **Accounts** dialog box, and then quit and restart Outlook 2016 for Mac.

:::image type="content" source="./media/prompted-for-credentials-modern-authentication/enter-upn.png" alt-text="Screenshot of the Outlook 2016 for Mac Accounts dialog box." border="false":::

## More information

If you don't know your UPN, contact your administrator.

For more information about UPNs, see [User name formats](/windows/win32/secauthn/user-name-formats).
