---
title: A Yammer user is displayed as "Former member" when you use Office 365 sign in for Yammer
description: Describes an issue in which a Yammer user is displayed as "Former member" when you use Office 365 sign in for Yammer.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
---

# A Yammer user is displayed as "Former member" when you use Office 365 sign in

## Problem

Assume that you recently started to use the Office 365 sign-in process for Yammer so that you can sign in to Yammer by using your Office 365 credentials. When you sign in, the following occurs:

- You're redirected to an account that is in your name and that isn't associated with your messages and groups.

- Another account for your user name in Yammer is displayed as **Former member**.

For example, Lea Terry uses lterry@contoso.com as the principal name (UPN) to sign in to her computer. She uses lea.terry@contoso.com to receive email messages. Until today, Lea used to sign in to Yammer by using lea.terry@contoso.com. Although she wasn't using it, there was additional user account for her in Yammer under lterry@contoso.com.

Today, after she signs in to Yammer by using her Office 365 credentials, Lea is redirected to the Yammer account that has the lterry@contoso.com email address instead of the account that has the lea.terry@contoso.com email address. The lea.terry@contoso.com account now is displayed as **Former Member**. That account is not associated with her messages and groups.

## Solution

To resolve the issue, a verified administrator must associate your Office 365 account with the desired Yammer account. To do this, the administrator must follow these steps:

1. Sign in to Yammer by using the verified admin account.

2. Click the ellipsis button (…), and then select **Network Admin** on the menu.

3. On the **Users** menu, click **Remove User**.

4. Suspend the active account that's not being used. To do this, type the user’s name in the **Remove or deactivate an existing user from the network** section, and then make sure that you select **Deactivate this user (you can reactivate their account at any time)**.

   **Important** If you select any other option, you'll delete the user account instead of suspending it.

5. After the active account is suspended, you can reactivate the suspended account. Locate the desired account in the **Deactivated Users** section, and then click **Reactivate**.

6. Ask the user to sign out of Yammer, and then sign in again. The user should now be redirected to the correct account.

## More information

This issue occurs when the Office 365 account is associated with an incorrect account in Yammer.

To enable Yammer users to sign in by using their Office 365 credentials, Yammer creates an association (or mapping) between the Office 365 user and the Yammer user. The mapping is based on all the user’s email addresses in Office 365. This includes UPN and proxy addresses.

In some cases, one Office 365 user has multiple accounts in Yammer under different email addresses. In this situation, Yammer tries to associate the Office 365 user with the most relevant user in Yammer. This process associates the Office 365 user with the relevant Yammer user and suspends the additional Yammer users who are associated with the Office 365 user. If the user is associated incorrectly, verified administrators can suspend the active user (the user who was mapped incorrectly) and activate the desired suspended account.

**NOTE** The suspended account will be automatically deleted after 90 days.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
