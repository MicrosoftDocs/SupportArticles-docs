---
title: Assertion Failed when you edit a transport rule in Exchange Server 2013
description: Works around an issue in which you can't edit a transport rule in an Exchange Server 2013 environment. When this issue occurs, you receive an Assertion Failed (The datetime of the DateTimePicker should not be an invalid date) warning message.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Need Help with Configuring Mailflow, Mail routing (Connectors, Domains)
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: aleli, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Assertion Failed warning message when you try to edit a transport rule in an Exchange Server 2013 environment

_Original KB number:_ &nbsp;2769337

## Symptoms

Consider the following scenario:

- You open the Exchange Administration Center (EAC) in a Microsoft Exchange Server 2013 environment.
- You configure the EAC to use a locale (language) that uses the "dd/mm/yyyy" date format.
- You create a transport rule, and then you set the activation date or the deactivation date by using the "mm/dd/yyyy" date format. For example, you set the activation date to "09/14/2012."
- You try to edit the transport rule.

In this scenario, you receive the following warning message:
> Assertion Failed: The datetime of the DateTimePicker should not be an invalid date!

> [!NOTE]
> This issue prevents you editing the transport rule in the EAC. However, the operation of the transport rule isn't affected by this issue.

## Workaround

To work around this issue, follow these steps:

1. Select **OK** in the warning message to ignore the warning and open the transport rule.
2. Clear the activation date and deactivation date options, and then save the rule.
3. Open the transport rule, and then change the activation date or the deactivation date to a correctly formatted date.
