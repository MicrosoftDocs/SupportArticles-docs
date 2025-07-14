---
title: Email received via EOP not journaled
description: Discusses that Internet email that is received through EOP is not journaled in an Exchange Server-Microsoft 365 hybrid environment.
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

# Internet email received through EOP is not journaled in an Exchange Server hybrid environment

_Original KB number:_ &nbsp; 4344001

## Symptoms

Consider this scenario:

- You deploy on-premises servers that are running Exchange Server in a hybrid Exchange and Microsoft 365 environment.
- You enable the journal rules or standard journaling on the servers.
- Your mailbox is located in the on premise and set up the email address of an on-premises archiving mailbox or a third-party archiving service as the journaling mailbox.
- You do not create journal rules in Microsoft 365.
- Your mail exchanger (MX) record points to Microsoft 365 Exchange Online Protection (EOP).
- You receive an email message from an Internet source through EOP.

In this scenario, the messages that are sent from the on-premises servers that are running Exchange are journaled as expected. However, the messages that are received from Microsoft 365 or from the Internet are not journaled.

## Cause

This issue occurs because the message that originates from Microsoft 365 or that is processed by EOP is added by having the following specific internal header:

> X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

This header identifies messages that have been processed by the Exchange Journaling agent. If the header is included in a message, Exchange Server recognizes that the message has already been processed by the Journaling Agent on a previous Hub Transport server. Therefore, it does not journal the message again.

## Resolution

To resolve this issue, go to Microsoft 365, navigate to **EAC** > **Compliance Management** > **Journal Rules**, and then create the same journal rules as exist on the on-premise servers that are running Exchange.

## More information

In a hybrid environment, there's no replication of journal rules between your on-premises Exchange organization and Microsoft 365. Therefore, when you create a rule in Exchange Server, you have to create a matching rule in Microsoft 365.

Rules that you create in Microsoft 365 are stored in the cloud, whereas the rules you create in your on-premises organization are stored locally in Active Directory. When you manage rules in a hybrid environment, you have to keep the two sets of rules synchronized by making any changes in both locations.
