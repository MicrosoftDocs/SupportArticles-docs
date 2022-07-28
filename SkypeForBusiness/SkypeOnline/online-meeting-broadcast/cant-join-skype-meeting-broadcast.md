---
title: Can't join a Skype Meeting Broadcast as an Event team member
description: Describes an issue that blocks you from joining a Skype Meeting Broadcast as an Event team member by using a supported Skype for Business client that has Producer controls. Provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: v-six
ms.reviewer: landerl, jasco, corbinm, dougl, lynnroe, cbland, rischwen, leonarwo, msp, romanma, tonyq
appliesto: 
  - Skype for Business Online
ms.date: 3/31/2022
---

# You can't join a Skype Meeting Broadcast as an "Event team" member

## Problem

When you try to join a Skype Meeting Broadcast as an **Event team** member by using a supported Skype for Business client that has **Producer** controls, you experience the following behavior:

- You receive the following message in a yellow banner in the Skype for Business client: 

    ```adoc
    The connection to Skype Meeting Broadcast service was lost. Attempting to reconnect...
    ```
- The **Producer** controls disappear, and you can no longer change the broadcast layout or switch between modalities.

## Solution

To resolve this issue, make sure that the following URLs and domains are configured to travel across all networking devices. They must be excluded from the web proxy solution to make sure that they aren't scanned and are non-proxied destinations.

|URLs|Domains|
|----|---|
|https://broadcast.skype.com|skype.com|
|https://*.broadcast.skype.com|*.skype.com|
|http://*.microsoftonline.com|*.microsoftonline.com|
|https://*.microsoftonline.com|*.microsoftonline.com|
|http://aka.ms|aka.ms|
|https://*.infra.lync.com|*.infra.lync.com |

## More Information

The Skype for Business client uses the Unified Communications Web API (UCWA) for the producer controls when it participates in a Skype Meeting Broadcast as an **Event team** member. Many web content filtering solutions can affect the producer controls by interfering with web traffic from the Skype for Business client to the Skype Meeting Broadcast infrastructure. 

For more information, see the following Microsoft websites:

- [Set up your network for Skype Meeting Broadcast](https://support.office.com/article/set-up-skype-meeting-broadcast-dfa736b9-4920-4f48-b8c0-b5487ec6086f)   
- [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).