---
title: Slow mail delivery in Exchange that has transport rules configured
description: Discusses an issue in which mail delivery is slow in an Exchange environment that has transport rules configured.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: dpaul, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Slow mail delivery in an Exchange environment that has transport rules configured

_Original KB number:_ &nbsp;3145489

## Symptoms

Consider the following scenario:

- You're using an instance of Microsoft Exchange Server that has transport rules configured.
- One or more of the transport rules contains one or more of these conditions:
  - AnyOfRecipientAddressMatchesPatterns
  - ExceptIfAnyOfRecipientAddressMatchesPatterns
  - FromAddressMatchesPatterns
  - RecipientAddressMatchesPatterns
- When you send email messages to a large recipient list, you notice a long delay in the delivery of the message to some users.
- You may see the following event recorded in the Application log on the Hub Transport servers:

    ```console
    Time: DATE TIME
    ID: 1050
    Level: Warning
    Source: MSExchange Extensibility
    Machine: COMPUTER NAME
    Message: The execution time of agent 'Transport Rule Agent' exceeded 90000 milliseconds while handling
    event 'OnRoutedMessage' for message with InternetMessageId: 'Not Available'. This is an unusual amount
    of time for an agent to process a single event. However, Transport will continue processing this message.
    ```

## Cause

This issue occurs because the messages remain for a long time in the Categorizer while they're processed through the transport rules on the server. This situation is caused by the rules that contain the "Matches Patterns" condition. This condition involves a complex and intensive process. You can verify this situation by examining the message tracking logs to verify that the process remains for a long time in the Categorizer Transport Rule agent, as shown in the following example log entry:

```console
MessageLatency : 06:26:14.9940000
MessageLatencyType : EndToEnd
ComponentServerFqdn : COMPUTER NAME
ComponentCode : CATRT-Transport Rule Agent
ComponentName : Categorizer OnRoutedMessage-Transport Rule Agent
ComponentLatency : 00:48:59
ComponentSequenceNumber : 2
```

> [!NOTE]
> Even messages that aren't sent to a large recipient list may remain for a long time in the Categorizer and have a delayed delivery. Therefore, such messages can also cause an issue for users.

## Resolution

To resolve this problem, avoid using the "Matches Patterns" condition. Instead, use "Contains Word" because this condition captures the string of words that you want to find within your transport rule. This significantly reduces the computing power that's required to process messages and also reduces the latency of messages within the environment.
