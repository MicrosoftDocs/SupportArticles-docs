---
title: Error when you dial out to a telephone number from a PSTN Conferencing meeting
description: Discusses an issue that limits PSTN Conferencing users to dialing out only to the countries where this service is sold. If a user dials a country that's not in the list, they receive a generic error message and may hear a fast busy signal.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.custom: CSSTroubleshoot
ms.reviewer: landerl, jasco, corbinm, kristinw, oscarr, nmurav, lynnroe, cbland, rischwen, leonarwo
appliesto:
- Skype for Business Online
---

# "Cannot be reached" when you dial out to a telephone number from a PSTN Conferencing meeting in Skype for Business Online

## Problem

Consider the following scenario:

- You're enabled for Skype for Business public switched telephone network (PSTN) conferencing with Microsoft as the dial-in conferencing provider.   
- While you're connected to a Skype for Business meeting through PSTN conferencing, you try to dial-out to a telephone number so that you can add another person to the meeting.   
- The telephone number that you're dialing is in a country that's not in the following list:
  - Belgium   
  - Canada   
  - Denmark   
  - Finland   
  - France   
  - Germany   
  - Italy   
  - Netherlands   
  - Norway   
  - South Africa   
  - Spain   
  - Sweden   
  - Switzerland   
  - United Kingdom   
  - United States   
   
When you do this, you receive the following error message: 

```adoc
<number> cannot be reached.
```

## Solution

To resolve this issue, have the user whom you're calling join the Skype for Business meeting by using a Skype for Business client or by calling directly into the dial-in conference. For more information about how to join or call in to a Skype for Business meeting, see the following Microsoft websites:

- [Joining a Skype for Business (Lync) Meeting](https://support.office.com/article/joining-a-skype-for-business-lync-meeting-538716dc-f4f2-48c2-af96-587c62387b87)
- [Call into a Skype for Business (Lync) Meeting](https://support.office.com/article/call-into-a-skype-for-business-lync-meeting-3eba526a-667c-4a53-927d-329737fc202b)   

## More Information

The dial-out functionality is supported only for countries where PSTN Conferencing from Microsoft is sold. If you are dialing out to a telephone number that's not on this list, the call won't be successful.

For more information about where you can obtain PSTN conferencing, see the following Microsoft website:

[Country and region availability for Audio Conferencing and Calling Plans](https://support.office.com/article/where-can-you-get-pstn-conferencing-1096d81e-7e14-488c-95d8-b8322e39c059)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).