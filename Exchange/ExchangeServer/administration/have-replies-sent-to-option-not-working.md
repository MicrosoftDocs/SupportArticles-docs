---
title: Have replies sent to option not working
description: The Have replies sent to option does not work with autoreply in Exchange Server 2010.
ms.date: 08/05/2020
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: 
appliesto:
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Standard
search.appverid: MET150
---
# The Have replies sent to option does not work when your mailbox has server autoreply configured

This article describes a by design behavior that the **Have replies sent to** option doesn't work as expected if the autoreply is configured in Microsoft Exchange Server 2010.

_Original KB number:_ &nbsp; 2911210

## Symptoms

Assume that you create a server-side rule in Exchange Server 2010. The rule is configured to have replies to a certain account sent to another account by using the **Have replies sent to** option. In this situation, the recipient that you specified in the **Have replies sent to** option is not automatically added in the **To** line when the sender tries to reply to the automated reply.

## Cause

This issue occurs because the email message does not contain the `PR_REPLY_RECIPIENT_NAMES` property.
