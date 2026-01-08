---
title: Email received through Microsoft 365 isn't journaled
description: Provides a resolution for an issue in which internet email that is received through Microsoft 365 is not journaled in a hybrid Exchange Server and Microsoft 365 environment.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Issues with Transport Rules
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jarrettr, davidsan, v-six
appliesto: 
  - Exchange Server
  - Exchange Online
search.appverid: MET150
---

# Internet email received through Microsoft 365 isn't journaled in an Exchange Server hybrid environment

_Original KB number:_ &nbsp; 4344001

## Symptoms

Consider this scenario:

- You deploy on-premises servers that run Exchange Server in a hybrid Exchange and Microsoft 365 environment.
- You enable the journal rules or standard journaling on the servers.
- Your mailbox is located in an on-premises server and you've set up the email address of an on-premises archiving mailbox or a third-party archiving service as the journaling mailbox.
- You don't create journal rules in Microsoft 365.
- Your mail exchanger (MX) record points to Microsoft 365.
- You receive an email message from an Internet source through Microsoft 365.

In this scenario, the messages that are sent from the on-premises Exchange servers are journaled as expected. However, the messages that are received from Microsoft 365 or from the Internet aren't journaled.

## Cause

This issue occurs because the messages that either originate from Microsoft 365 or processed by Microsoft 365 are added by using the following specific internal header:

> `X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent`

This internal header is used to identify messages that were processed by the Exchange Journaling agent. So when the header is included in a message, Exchange Server recognizes that the message has already been processed by the Journaling Agent on a previous Hub Transport server. Therefore, it doesn't journal the message again.

## Resolution

To resolve this issue, navigate to **EAC** > **Compliance Management** > **Journal Rules**, and create the same journal rules that exist on the on-premise servers that run Exchange.

## More information

In a hybrid environment, there's no replication of journal rules between the on-premises Exchange organization and Microsoft 365. Therefore, when you create a rule in Exchange Server, you have to create a matching rule in Microsoft 365.

Rules that you create in Microsoft 365 are stored in the cloud, whereas the rules you create in the on-premises organization are stored locally in Active Directory. When you manage rules in a hybrid environment, you have to keep the two sets of rules synchronized by making all changes in both locations.
