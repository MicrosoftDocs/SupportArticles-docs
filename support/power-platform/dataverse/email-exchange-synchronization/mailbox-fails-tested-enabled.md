---
title: Mailbox set up with Gmail fails to be tested and enabled
description: This article provides a resolution for the problem that occurs when a Dynamics 365 mailbox is configured to use server-side synchronization with Gmail.
ms.reviewer: 
ms.date: 04/17/2025
ms.custom: sap:Email and Exchange Synchronization
---
# Troubleshooting server-side synchronization with Gmail

> [!IMPORTANT]
> As documented [here](https://support.google.com/accounts/answer/6010255), starting May 30th of 2022, Gmail is ending support for apps that are configured to only use your username and password. To use server-side synchronization with Gmail, follow the steps in [Connect Gmail accounts by using OAuth 2.0](/power-platform/admin/connect-gmail-oauth2).

This article helps you resolve the problem that occurs when a Dynamics 365 mailbox is configured to use server-side synchronization with Gmail.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4493342

## Symptoms

When you try to [test and enable](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) a mailbox that's configured to use [server-side synchronization with Gmail](/power-platform/admin/connect-gmail-oauth2), the test might fail, or the incoming emails might not be received in Dynamics 365.

## Cause 1：Incorrect port configuration

If your mailbox fails to be tested and enabled, it might be due to incorrect configuration of incoming or outgoing ports. A Gmail email server profile in Dynamics 365 should use port 995 for incoming mail and port 587 for outgoing mail.

To solve this issue, verify that your email server profile is set up with port 995 for incoming emails and port 587 for outgoing emails. Enable settings from [Less secure apps & your Google Account](https://support.google.com/accounts/answer/6010255), if necessary.

## Cause 2: Absence of "recent mode"

If the mailbox is tested and enabled successfully but emails aren't received in Dynamics 365, it might be because "recent mode" isn't used.

Update the Gmail email address within Dynamics 365 by including `recent:` at the beginning of the address. For example, change `example@gmail.com` to `recent:example@gmail.com`. For more information, see [Emails aren't downloading correctly](https://support.google.com/mail/answer/7104828#zippy=%2Cemails-arent-downloading-correctly).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
