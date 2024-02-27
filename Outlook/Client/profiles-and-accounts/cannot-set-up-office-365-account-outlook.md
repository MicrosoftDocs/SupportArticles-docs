---
title: Can't set up Microsoft 365 account in Outlook
description: Fixes an issue in which a user can't set up a Microsoft 365 account in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: aruiz
ms.custom: 
  - Outlook for Windows
  - CI 119623
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
ms.date: 01/30/2024
---
# You can't set up a Microsoft 365 account in Outlook

_Original KB number:_ &nbsp; 4493666

## Symptoms

You can't successfully set up a Microsoft 365 Exchange Online email account in Outlook.

## Cause

This issue might occur if your Exchange administrator enables multi-factor authentication (MFA) for your account, but doesn't enable modern authentication for the Exchange tenant organization.

When this issue occurs, the server returns an HTTP 456 authentication error.

## Resolution

To fix this issue, disable MFA for the account in the Microsoft 365 admin center. To do this, follow these steps.

> [!NOTE]
> You might have to contact your Exchange administrator to disable the MFA .

1. Browse to the [Microsoft 365 portal](https://portal.office.com), and sign in to your Microsoft 365 subscription by using your Global Administrator account.
2. On the main portal page, select **Admin**.
3. In the navigation pane, select **Users** > **Active users**.
4. In the **Active users** pane, select **More** > **Multi-factor authentication setup**.
5. Select the check box next to the affected user.
6. Under **quick steps**, select **Disable**.

## More information

To enable MFA for organizations, Exchange administrators must enable modern authentication in Exchange Online. By default, newer Exchange Online tenants have modern authentication enabled.

You can enable modern authentication for tenants as necessary. Before you enable modern authentication for your Exchange organization, take compatibilities into account. Consider that the user experience will change if MFA is enabled in your organization.

For more information, see the following websites:

- [Enable or disable modern authentication for Outlook in Exchange Online](/Exchange/clients-and-mobile-in-exchange-online/enable-or-disable-modern-authentication-in-exchange-online)

- [Info about AllowAdalForNonLyncIndependentOfLync setting in Skype for Business, Lync 2013, and Exchange Online](/SkypeForBusiness/troubleshoot/hybrid-exchange-integration/allowadalfornonlyncindependentoflync-setting)
