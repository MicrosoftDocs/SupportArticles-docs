---
title: Cannot create items on behalf of delegates
description: Resolves an Exchange Server 2013 issue in which you cannot create items on behalf of a delegate.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jasonjoh, jmartin, genli, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# Creating an item on behalf of a delegate fails in Exchange Server 2013 Cumulative Update 5

_Original KB number:_ &nbsp; 2986658

## Symptoms

Assume that you have two users (user A and user B) on different Mailbox server in an Exchange Server 2013 [Cumulative Update 5](https://support.microsoft.com/help/2936880) environment. User A on behalf of user B creates a new email message or other item by using an Exchange Web Services (EWS)-based application. In this situation, the email message or item cannot be created.

## Cause

This issue occurs because an exception occurs when the EWS request has an `X-AnchorMailbox` header set to user B's email address.

## Workaround

To work around this issue, make the following change in the Web.config file on the Client Access server:

Add the following line of code under the \<appSettings> section in the Web.config file:

```console
<add key="SendXBEServerExceptionHeaderToCafe" value="false" />
```

> [!NOTE]
> The Web.Config file is located in the path: **Drive**\Program Files\Microsoft\Exchange Server\V15\ClientAccess\exchweb\ews.

## More information

For more information about the `X-AnchorMailbox` header, see [General information about the X-AnchorMailbox header](/exchange/client-developer/exchange-web-services/how-to-maintain-affinity-between-group-of-subscriptions-and-mailbox-server).
