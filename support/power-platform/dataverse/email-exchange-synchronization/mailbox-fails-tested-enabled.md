---
title: Mailbox fails to be tested and enabled
description: This article provides a resolution for the problem that occurs when a Dynamics 365 mailbox is configured to use Server-Side Synchronization with Gmail.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Troubleshooting Server-Side Synchronization with Gmail

> [!IMPORTANT]
> As documented [here](https://support.google.com/accounts/answer/6010255), starting May 30th of 2022, Gmail is ending support for apps that are configured to only use your username and password. To use server-side synchronization with Gmail, follow the steps in [Connect Gmail accounts by using OAuth 2.0](/power-platform/admin/connect-gmail-oauth2).

This article helps you resolve the problem that occurs when a Dynamics 365 mailbox is configured to use Server-Side Synchronization with Gmail.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4493342

## Symptoms

When a Dynamics 365 mailbox is configured to use Server-Side Synchronization with Gmail, the mailbox may fail to be tested and enabled successfully or incoming emails are not received in Dynamics 365.

## Cause

If the mailbox fails to be tested and enabled, this can be caused by the incoming or outgoing ports not being configured correctly. A Dynamics 365 email server profile for Gmail should be configured to use port 995 for incoming and port 587 for outgoing.
If the mailbox was tested and enabled successfully but emails are not being created in Dynamics 365, this can occur if you are not using **recent mode**.

## Resolution

Verify the email server profile is configured to use port 995 for incoming and port 587 for outgoing. You may also need to enable the following setting:

[Less secure apps & your Google Account](https://support.google.com/accounts/answer/6010255)

If the mailbox is tested and enabled successfully but incoming email is not created in Dynamics 365, try using **recent mode**. Refer to the following article and expand the section: **Emails aren't downloading correctly**.

[Read Gmail messages on other email clients using POP](https://support.google.com/mail/answer/7104828)

You can follow the steps mentioned in the article above to update the Gmail email address in Dynamics 365 to include `recent:` at the beginning. Example: `recent:example@gmail.com`.
