---
title: MSExchangeServicesAppPool crashes
description: Describes an issue that triggers a crash in the MSExchangeServicesAppPool process in an Exchange Server 2013 environment. This issue concerns the size of history conversation files in Lync and Skype for Business. A resolution is provided.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
---
# Event ID 4999 is logged and MSExchangeServicesAppPool crashes in Exchange Server 2013

_Original KB number:_ &nbsp; 3145482

## Symptoms

In a Microsoft Exchange Server 2013 environment, MSExchangeServicesAppPool crashes frequently, and you see the following error in the Application log:

```console
Log Name: Application
Source: MSExchange Common
Date: Date and Time
Event ID: 4999
Task Category: General
Level: Error
Keywords: Classic
User: N/A

Description:
Watson report about to be sent for process id: 1124, with parameters: E12, c-RTL-AMD64, 15.00.1104.005, w3wp#MSExchangeServicesAppPool, M.Exchange.Services, M.E.S.W.DispatchByBodyElementOperationSelector.CheckWcfDelayedException, System.NotImplementedException, 66d7, 15.00.1104.003.
```

## Cause

This issue occurs because the size limit of a history conversation file is 1 megabyte (MB). When this limit is reached, Lync 2010 or Lync 2013 (Skype for Business) can't upload the conversion to Exchange Server 2013 through Exchange Web Services (EWS). In this situation, the EWS application pool crashes.

## Resolution

To resolve this issue, make sure that all Lync clients are updated with the [November 10, 2015, security update (KB3101496)](https://support.microsoft.com/help/3101496) for Lync 2013 (Skype for Business). Lync 2010 clients will have to first be upgraded to Lync 2013 and then updated with the November 2015 security update KB3101496.

## More information

Lync 2013 .hist files aren't written to Exchange Server through EWS when the file is larger than 1 MB. Instead, all the files accumulate in the history spooler folder and are never pushed to Outlook.

Users must close conversation windows before this limit is reached. The end user doesn't know when this limit will be reached, but 1 MB does represent a significant volume of data related to the conversation. In any case, users should close the conversation window once per day or whenever they're not actively using the conversation window.
