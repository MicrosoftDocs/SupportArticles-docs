---
title: Can't create too large transport rules
description: Fixes an issue in which you receive a The rule can't be created because it is too large error message when you try to create or change an Exchange mail flow rule (transport rule) in Exchange Online or in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: sathyana, v-six
appliesto: 
  - Exchange Online
  - Built-in security features for all cloud mailboxes
search.appverid: MET150
ms.date: 01/24/2024
---
# The rule can't be created because it is too large when you create or change an Exchange mail flow rule

_Original KB number:_ &nbsp; 3003043

## Problem

When you try to create or change an Exchange mail flow rule (also known as a transport rule) in Microsoft 365, you receive an error message that resembles the following:

> The rule cannot be created because it is too large. It has \<X> characters and the maximum number of characters is 8192. Reduce the size.

## Cause

This problem occurs if the size of the mail flow rule is more than 8 kilobytes (KB).

The maximum size of a single mail flow rule is 8 KB. The character limit for all regular expressions that are used in all mail flow rules is 20 KB. This limit applies to the total number of characters that are used by all regular expressions, including keywords.

## Solution

Reduce the number of conditions or actions in the rule so that the rule's size is no more than 8 KB. Or, create multiple rules so that several smaller rules work together to perform the function of one large rule.

## More information

For more info about how to manage transport rules in Microsoft 365, see [Manage mail flow rules in Exchange Online](/exchange/security-and-compliance/mail-flow-rules/manage-mail-flow-rules).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
