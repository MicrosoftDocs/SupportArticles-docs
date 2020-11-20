---
title: Invalid Product Key error when activating Hybrid Edition
description: Describes an issue that triggers an error when you try to activate the Hybrid Edition of a server that's running Exchange 2013 and Cumulative Update 3 for Exchange 2013.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Hybrid
- CSSTroubleshoot
ms.reviewer: timothyh
appliesto:
- Exchange Online
search.appverid: MET150
---
# Invalid Product Key error when you try to activate the Hybrid Edition of Exchange Server 2013

_Original KB number:_ &nbsp; 2916187

## Symptoms

You install Exchange Server 2013 and Cumulative Update 3 (CU3) for Exchange 2013 in order to set up a hybrid deployment between your on-premises environment and Exchange Online. Then, you contact Microsoft Support to obtain the free product key for the Hybrid Edition. However, when you enter the product key to activate the product, you receive the following error message:

> error
>
> Invalid Product Key.

## Cause

This issue occurs because of a regression in Cumulative Update 3 for Exchange Server 2013. This regression causes the product to be mistakenly recognized as invalid.

## Workaround

You can safely ignore the product activation error message. Until this issue is resolved in the near future, there are no adverse effects from leaving the server unlicensed.

## Status

This is a known issue that's scheduled to be addressed in a future release.

## More information

If you already deployed the product key for the Hybrid Edition on a server and then later upgraded the server to Exchange 2013 CU3, the server will remain licensed, and the license will be displayed as valid. The issue that's described in the Symptoms section occurs only when you try to enter the product key on an Exchange 2013 server that has CU3 installed.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
