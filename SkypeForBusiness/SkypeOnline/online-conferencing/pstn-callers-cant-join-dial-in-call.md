---
title: PSTN callers can't join a Skype for Business dial-in conference call
description: Describes an issue that blocks PSTN callers from joining a Skype for Business Online dial-in conference call. Instead, these callers are stuck in the lobby. A solution is provided.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
ms.reviewer: landerl, jasco, corbinm, pthota, nmurav, lynnroe, cbland, rischwen, Leonarwo, msp, romanma
appliesto:
- Skype for Business Online
---

# PSTN callers can't join a Skype for Business dial-in conference call

## Problem

When public switched telephone network (PSTN) callers try to join a Skype for Business Online dial-in conference call, they're put in the lobby and can't join the call.  

## Solution 

To allow PSTN callers to join a Skype for Business Online dial-in conference call, unlock the conference call by selecting any option other than **The meeting organizer** in the **These people don't have to wait in the lobby** list. 

![Screen shot of the ](./media/pstn-callers-cant-join-dial-in-call/unlock-conference-call.png)

## More Information

This issue occurs because the conference call is locked, and the organizer doesn't receive a notification that callers are waiting in the lobby. Conference calls are locked when the **These people don't have to wait in the lobby** option is set to **Only me, the meeting organizer** in the Outlook invite meeting options or to **The meeting organizer **in the Skype meeting options during the meeting.  

For more information about Skype for Business dial-in conferencing, see the following Microsoft websites:

- [Set up Audio Conferencing for Skype for Business](https://support.office.com/article/getting-started-with-dial-in-conferencing-7cc7d3f3-d081-4c0e-b01d-ec1e420669ce)
- [Audio Conferencing troubleshooting and known issues](https://support.office.com/article/dial-in-conferencing-known-issues-72979911-5319-4de2-a275-4dd9a0f44fe6)   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).