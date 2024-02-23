---
title: Connection to Microsoft Exchange is unavailable error
description: Describes an issue in which a user can't set up Outlook for the Microsoft 365 account because the user has an account at a third-party provider that uses the same email address and password that their Microsoft 365 account uses. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Connection to Microsoft Exchange is unavailable error when a Microsoft 365 user tries to set up Outlook

_Original KB number:_ &nbsp; 2976203

## Symptoms

When a user tries to set up email for the Microsoft 365 account in Microsoft Outlook, the user receives the following error message:

> The connection to Microsoft Exchange is unavailable. Outlook must be online or connected to complete this action.

## Cause

This issue can occur if the user has an account at a third-party provider that uses the same email address and password that the user's Microsoft 365 account uses.

## Resolution

To resolve this issue, use one of the following methods, as appropriate for your situation.

### Method 1 - Create a new alias for the user in Microsoft 365

Create a new alias for the user in Microsoft 365, and use it to set up Outlook. To do this, follow these steps:

1. Sign in to the Exchange admin center.
2. Select **recipients**, select **mailboxes**, and then double-click the user's mailbox.
3. Select **email address**, select **Add** (:::image type="icon" source="media/connection-to-microsoft-exchange-is-unavailable-error/add-button.png" border="false":::), select **SMTP**, and then add a new alias that uses the `.onmicrosoft.com` domain. For example, add the `john@contoso.onmicrosoft.com` alias.
4. Use the alias that you created in step 3 instead of the user's email address to set up Outlook. When you're prompted again to enter credentials during the setup process, use the user's actual Microsoft 365 email address.

### Method 2 - Change the user name or password

Change the user name or password of the user's Microsoft 365 account or of the user's third-party account so that it is unique for the user's Microsoft 365 account.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
