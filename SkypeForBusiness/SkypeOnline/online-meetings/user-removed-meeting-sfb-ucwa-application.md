---
title: Users are removed from a meeting while using Skype for Business UCWA applications
description: This article describes an issue where users are removed from a meeting while using Skype for Business UCWA applications.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 117592
  - CSSTroubleshoot
ms.reviewer: gclark
appliesto: 
  - Skype for Business Online
  - Skype for Business 2019
  - Skype for Business 2015
search.appverid: 
  - MET150
ms.date: 3/31/2022
---

# Users are removed from a meeting while using Skype for Business UCWA applications

When using a Skype for Business Unified Communications Web API (UCWA) application, there is a long running HTTP GET request for application events. If the GET request is closed or times out and the client isn't notified, it's unable to renew the request. The UCWA server ends the application and the user is removed from the meeting. For more information about UCWA Event Channel, read [Events in UCWA](/skype-sdk/ucwa/eventsinucwa). 

In most cases, this issue can be managed in the underlying network by setting HTTP or TCP timeouts to at least 15 minutes. When using a privately managed remote network (for example, a home Wi-Fi), the network may end the connection after a long period without event activity. As a result, the user is removed from the meeting, although it may appear to the user that the session is still active and connected.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).