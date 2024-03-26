---
title: Event 32263 error 0xC3E93C2F on Front-End servers in Skype for Business Server
description: Event 32263 SIPPROXY_E_UNKNOWN_USER_OR_EPID is logged on Front-End servers in Skype for Business Server 2015, Lync Server 2013, and Lync Server 2010.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync 2010
  - Lync 2013
  - Skype for Business Server 2015
ms.date: 03/31/2022
---

# Event 32263 error 0xC3E93C2F on Front-End servers in Skype for Business Server

## Symptoms

You find the following event log entry logged on Front-End servers in Microsoft Skype for Business Server 2015, Microsoft Lync Server 2013, and Microsoft Lync Server 2010:  

```AsciiDoc
Event ID: 32263
Error code: 0xC3E93C2F(SIPPROXY_E_UNKNOWN_USER_OR_EPID), Error identifier: NotifySingle.Notify
Cause: Possible issues with the other front end or with this front end.
Resolution:
Ensure the front end is functioning correctly.  
```

## Cause

This issue occurs because client sessions sometimes don't disconnect cleanly from the Front-End server. This causes stale subscriptions to remain on the server. When a notification is generated for one of these subscriptions, the server doesn't find a valid user for that subscription. Therefore, it logs the event entry that is mentioned in the "Symptoms" section.  

## More Information

This issue can be safely ignored because it's caused by client behavior. This issue is not an indication of a server or environmental problem.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
