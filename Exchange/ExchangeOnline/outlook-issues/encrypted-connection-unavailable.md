---
title: Error when Office 365 F plan users try to set up an Outlook profile for Exchange Online in Office 365.
description: Encrypted connection to your mail server is not available when you try to set up an Outlook profile for Exchange Online in Office 365.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
appliesto:
- Exchange Online
search.appverid: MET150
---
# (Encrypted connection to your mail server is not available) error when Office 365 F plan users try to set up an Outlook profile for Exchange Online in Office 365

_Original KB number:_&nbsp;2826047

## Problem

An Office 365 F plan user tries to set up a mail account for Exchange Online in Microsoft Outlook 2010 or Microsoft Outlook 2013. However, the user's Outlook profile isn't automatically set up. Instead, the user gets the following error message under **Searching for your mail server setting** in Outlook:

> An encrypted connection to your mail server is not available.

Click Next to attempt using an unencrypted connection.

This error message is displayed even though the user entered his or her email address and password correctly on the Auto Account Setup page of the Add New Account Wizard in Outlook.

## Cause

This behavior occurs if the user is trying to connect Outlook to Exchange Online by using Exchange Autodiscover. Office 365 F plans don't support using Outlook to access mail in Exchange Online through an Exchange connection.

## Solution

To work around this behavior, do one of the following:

- Use Outlook Web App to access mail in Exchange Online.
- Set up Outlook to access mail in Exchange Online through a Post Office Protocol (POP3) connection. For more info about how to do this, see [Set up a POP3 or IMAP4 connection to your email in Outlook 2010 or Outlook 2013](https://office.microsoft.com/web-apps-help/redir/ha103785606).

## More Information

For more information about Office 365 F plans, see [Office 365 F1](https://products.office.com/business/office-365-f1?legRedir=true&CorrelationId=b7b7a08f-e568-40de-84d7-fb9d2faaa328).

If Office 365 users who aren't F plan users get this error message, see the following Microsoft Knowledge Base article:

> [2404385](https://support.microsoft.com/help/2404385) Outlook can't set up a new profile by using Exchange Autodiscover for an Exchange Online mailbox in Office 365

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
