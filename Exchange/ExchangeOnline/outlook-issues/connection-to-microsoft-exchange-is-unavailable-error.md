---
title: Connection to Microsoft Exchange is unavailable error
description: Describes an issue in which a user can't set up Outlook for the Office 365 account because the user has an account at a third-party provider that uses the same email address and password that their Office 365 account uses. Provides a solution.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer:
appliesto:
- Exchange Online
search.appverid: MET150
---
# Connection to Microsoft Exchange is unavailable error when an Office 365 user tries to set up Outlook

_Original KB number:_ &nbsp; 2976203

## Symptoms

When a user tries to set up email for the Office 365 account in Microsoft Outlook, the user receives the following error message:

> The connection to Microsoft Exchange is unavailable. Outlook must be online or connected to complete this action.

## Cause

This issue can occur if the user has an account at a third-party provider that uses the same email address and password that the user's Office 365 account uses.

## Resolution

To resolve this issue, use one of the following methods, as appropriate for your situation.

### Method 1 - Create a new alias for the user in Office 365

Create a new alias for the user in Office 365, and use it to set up Outlook. To do this, follow these steps:

1. Sign in to the Exchange admin center.
2. Select **recipients**, select **mailboxes**, and then double-click the user's mailbox.
3. Select **email address**, select **Add** (![Screenshot of the Add button ](./media/connection-to-microsoft-exchange-is-unavailable-error/add-button.jpg)), select **SMTP**, and then add a new alias that uses the `.onmicrosoft.com` domain. For example, add the `john@contoso.onmicrosoft.com` alias.
4. Use the alias that you created in step 3 instead of the user's email address to set up Outlook. When you're prompted again to enter credentials during the setup process, use the user's actual Office 365 email address.

### Method 2 - Change the user name or password

Change the user name or password of the user's Office 365 account or of the user's third-party account so that it is unique for the user's Office 365 account.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
