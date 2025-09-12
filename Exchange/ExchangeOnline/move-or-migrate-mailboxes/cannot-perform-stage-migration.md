---
title: Mailboxes can't be migrated because they contain errors
description: Fixes an issue in which you receive an error message when you perform a staged Exchange migration to migrate on-premises mailboxes to Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Azure Active Directory
search.appverid: MET150
ms.date: 01/24/2024
---
# Mailboxes listed in the following table can't be migrated when you perform a staged Exchange migration

_Original KB number:_ &nbsp; 2845956

## Problem

Consider the following scenario:

- You want to set up single sign-on (SSO).
- You have an on-premises Microsoft Exchange Server environment but don't want a full hybrid deployment with Microsoft Exchange Online in Microsoft 365.
- To implement SSO, you deploy Active Directory Federation Services (AD FS) 2.0 and then use Active Directory synchronization to sync user accounts from your on-premises Active Directory directory service to Microsoft Entra ID.

In this scenario, when you perform a staged Exchange migration to migrate mailboxes from your on-premises environment to Exchange Online, you receive the following error message:

> The mailboxes listed in the following table can't be migrated because they contain errors.
Learn more...

Additionally, when you click **Learn more**, you receive an error message that resembles the following:

> Errors: Mailboxes -1
>
> joe@contoso.com
> A Windows Live error occurred while provisioning for "joe@contoso.com". An internal error occurred while talking to Windows Live. Additional details: "0x800482101033This action is currently blocked for the API. CH1IDOPRTI03 2011.09.07.15.30.48".

## Cause

Microsoft 365 can't change attributes of federated users. In this scenario, Microsoft 365 can't change the value of the `ForceChangePassword` field from **True** to **False** in the CSV file that you created for the migration.

## Solution

To resolve this issue, edit the CSV file to set the `ForceChangePassword` field to **False** for federated users. For example, the CSV file will resemble the following:

|EmailAddress|Password|ForceChangePassword|
|---|---|---|
|joe@contoso.com|<*Password*>|False|

## More information

It's also important to make sure that the user who is accessing the mailboxes that are to be migrated has the necessary permissions. For more information, see [What you need to know about a staged email migration](/Exchange/mailbox-migration/what-to-know-about-a-staged-migration).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
