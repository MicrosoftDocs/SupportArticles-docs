---
title: Blind transfer from an anonymous response group agent fails
description: Fixes an issue in which a blind transfer from an anonymous response group to another response group fails in Lync Server.
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
ms.reviewer: acorman, miadkins
appliesto: 
  - Lync Server 2010 Enterprise Edition
  - Lync Server 2010 Standard Edition
  - Lync 2013
ms.date: 03/31/2022
---

# Blind transfer from an anonymous response group agent fails in Lync Server

## Symptoms

Consider the following scenario:

- A response group receives an incoming call in Microsoft Lync Server 2010.   
- The workflow for the response group has the **Enable agent anonymity** option selected.   
- An anonymous response group agent accepts the incoming call.   
- The agent transfers the call to another response group.   

In this scenario, the call transfer fails. Additionally, the following notification and error message are received:

```adoc
Cannot complete the transfer
When contacting your support team reference error ID 503 (source ID 239).
```

## Workaround

To work around this issue, follow these steps after the anonymous response group agent accepts the incoming call:

1. Click the Transfer call to another person or device button that is located on the Lync 2010 call window.   
2. In the **Transfer to Others** category, click **Another Person or Number**. 
3. Use the **Transfer Call** dialog to locate and select the response group contact to transfer the call.   
4. Click the down arrow and then click **View more** options.   
5. Click the **Lync Call** feature from the list.   

The anonymous transfer for the call will succeed.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
