---
title: Can't join meeting created by a user whose SIP address contains apostrophe
description: Describes an issue in which Lync Server 2010 does not support the use of an apostrophe (') or a dash (-) in the SIP address of a user.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: v-miazha, chtart, anirudd, terrya, lcse, rtcse, uckbprev, acorman
appliesto:
- Lync Server 2010 Enterprise Edition
- Lync Server 2010 Standard Edition
---

# Users cannot join a meeting that is created by a user whose SIP address contains an apostrophe in a Lync Server 2010 environment

Microsoft Lync Server 2010 does not support user SIP addresses that contain an apostrophe (') or a dash (-). 

## More Information

If a user (user A) uses a SIP address that contains an apostrophe (') or a dash (-), user A may encounter the following situation:
- A user (user B) cannot join a Lync Server 2010 meeting that is created by user A.   
- User A misses meetings on a Lync 2010 client.   

This issue has been addressed as part of the Lync Server 2010 Web Conferencing Server cumulative update for June 2012.

[2708616](https://support.microsoft.com/help/2708616) Description of the cumulative update for Lync Server 2010, Web Conferencing Server: June 2012

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).