---
title: There are multiple recipients matching the identity error
description: Discusses that you receive an error when you try to create an inbox rule in Outlook on the web (formerly known as Outlook Web App (OWA)) or by using the Exchange Management Shell.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: amyluu, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
  - Exchange Server 2010
search.appverid: MET150
ms.date: 01/24/2024
---
# There are multiple recipients matching the identity error when creating inbox rules in OWA or EMS

_Original KB number:_ &nbsp; 3001960

## Symptoms

When you try to create an inbox rule by using Outlook on the web (formerly known as Outlook Web App (OWA)) or by using the Exchange Management Shell, you receive the following error message:

> There are multiple recipients matching the identity "\<User>". Please specify a unique value

## Cause

This problem occurs if multiple mailboxes or mail contacts have the same display name. Exchange examines the **Display name** field or the `displayName` attribute when it creates a rule.

## Resolution

Change the display name in the Exchange admin center or in **Active Directory Users and Computers** so that the name doesn't conflict with an existing mailbox or mail contact.

## More information

To avoid this problem, use the user's Simple Mail Transfer Protocol (SMTP) address instead of the display name when you create rules using the Exchange Management Shell.
