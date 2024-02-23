---
title: Can't validate an outbound connector
description: Discusses an error message that you receive when you try to validate a connector in the Exchange admin center in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: jeknight, v-six
appliesto: 
  - Exchange Online
  - Exchange Online Protection
search.appverid: MET150
ms.date: 01/24/2024
---
# The domain of the recipient is not configured as part of connector when you validate a connector

_Original KB number:_ &nbsp; 3179588

## Problem

When you try to validate an outbound connector in the Exchange admin center in Microsoft 365, the test email message isn't delivered, and you receive the following error message:

> The domain of the recipient is not configured as part of connector.

You receive this message even though the domain was added to the accepted domains list.

## Cause

The outbound connector was saved without having the option enabled to turn on the connector after it's saved.

## Solution

On the New Connector page, select the **Turn it on** check box to turn on the connector after it's saved, save the connector, and then validate it.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
