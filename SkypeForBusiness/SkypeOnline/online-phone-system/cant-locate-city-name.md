---
title: Can't locate city names when you search for emergency locations for PSTN callers
description: Discusses an issue in Skype for Business Online in which you can't find a city to assign an emergency location to for a PSTN user.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: landerl, jasco, corbinm, kristinw, pthota
appliesto:
- Skype for Business Online
---

# You can't locate city names when you search for emergency locations for PSTN callers in Skype for Business Online

## Problem

Consider the following scenario:

- You set up a Skype for Business Online user for public switched telephone network (PSTN) calling.   
- You assign a validated emergency address and location.   
- You open the **Assign number** page, and then you enter the full name of a city in the **Find City** box under **Change emergency address to**. Then, you click **Search**.   

In this scenario, the search fails.

## Solution

When you search for city names, enter only the first letter of the name, and then click the down arrow in the **Select emergency address** field to see the matching results. You can then select the city name from that list.

## More Information

When emergency addresses are validated, the city name is changed to the **Master Address** abbreviation so that the correct location is identifiable to emergency responders. 

For more information about how to assign emergency locations for users, go to the following Microsoft websites:

- [Assign, change, or remove a phone number for a user](https://support.office.com/article/assign-change-or-remove-a-phone-number-for-a-user-91089761-cb87-4119-885b-3713840dd9f7)   
- [Change the emergency location for a user](https://support.office.com/article/change-the-emergency-location-for-a-user-2d5d3c87-af1e-487e-b86c-261f2e5a0661)   
- [What are emergency locations, addresses and call routing?](https://support.office.com/article/what-are-emergency-locations-addresses-and-call-routing-589bf5f5-490a-4215-8588-99bab7d33e31)   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
