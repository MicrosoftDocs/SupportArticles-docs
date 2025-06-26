---
title: Lync 2013 client experiences one-way audio
description: Describes an issue that may occur when a user uses the Hold feature during a call to or from the PSTN.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: seemarah
appliesto: 
  - Lync 2013
ms.date: 03/31/2022
---

# Lync 2013 client experiences one-way audio after a PSTN call is put on hold

## Summary

The Microsoft Lync 2013 client may experience issues with one-way audio when the user applies the Hold feature during a call to or from the public switched telephone network (PSTN). The user of the Lync 2013 client will be unable to use the Resume feature to regain two-way audio functionality for the Voice over IP (VoIP) call.

Additionally, the Lync 2013 client displays the following error notification:

**Call could not be put on hold**

This issue may occur when the following conditions are true:

- The Lync 2013 client was updated to version 15.0.4517.1504 or 15.0.4535.1510.   
- The Media Bypass feature for the Lync Server 2013 Enterprise Voice infrastructure is enabled.   
- The Lync 2013 client's user makes a call and puts a remote PSTN user on hold by using the Lync 2013 Hold feature.   

## Resolution

To resolve this issue, install [Description of the Lync 2013 update 15.0.4551.1005: November 7, 2013](https://support.microsoft.com/help/2825630).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).

