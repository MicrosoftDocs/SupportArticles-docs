---
title: Access denied error when you browse to the site mailbox in SharePoint Online
description: This article describes an issue where Sorry Access denied error when you browse to the site mailbox in SharePoint Online, and provides a solution.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
---

# "Sorry! Access denied" error when you browse to the site mailbox in SharePoint Online

## Problem

Consider the following scenario:

- You're using an Exchange Online user role policy through which the MyTeamMailboxes role is disabled.

- You browse to a SharePoint Online site, click **add an app**, and then click **Site Mailbox**. Or, you browse to **Site settings**, click **Manage site features**, and then click **Activate for the Site Mailbox**.

When you browse to the site mailbox in this situation, you receive the following message:

```adoc
403

Sorry! Access denied :(

You don't have permission to open this page. If you're a new user or were recently assigned credentials, please wait 15 minutes and try again.

You're still signed in. If you want to sign out, use the link below.
```

## Solution

This is a known issue. Although user site mailbox creation was disabled in Exchange Online through a user role policy, the option to create a site mailbox still appears in SharePoint Online. Therefore, when you try to use the UI features that rely on the site mailbox functionality, you receive the error message.

## More information

In this scenario, Global Administrators for an organization in Office 365 can still create site mailboxes. 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
