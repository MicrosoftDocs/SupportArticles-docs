---
title: Can't add someone to Skype Meeting Broadcast as Event team member or attendee
description: Describes an issue that blocks an organizer from adding certain people as Event team members or attendees to a Skype Meeting Broadcast.
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
ms.reviewer: landerl, jasco, corbinm, kristinw, dougl
appliesto:
- Skype for Business Online
---

# Can't add someone to a Skype Meeting Broadcast as an Event team member or attendee

## Problem

When you're scheduling a Skype Meeting Broadcast at [https://portal.broadcast.skype.com](https://portal.broadcast.skype.com/), you do one of the following:

- In the **Event team** section, you enter a name in the **Members** field.    
- Under **Attendees**, you select **Access = Secure**, and then you enter a name in the **Attendees** field.   

In these scenarios, the name that you entered disappears when you press Enter.

## More Information

There are certain limitations concerning which users can be listed as an Event team member or as an attendee. When you enter a member of the Event team, or when you enter names of attendees for a closed meeting, be aware of the following:


- The creator of the Skype Meeting Broadcast event is automatically a member of the Event team and can't be added again.   
- Users must be members of the same organization as the meeting organizer. External users can't be added at this point.   
- The users must be synchronized by using Azure Active Directory (Azure AD).   
- The accepted formats by which to enter a name are as follows:    
  - Email address   
  - Alias   
  - User principal name (UPN)   
  - Session initiation protocol (SIP) proxy address   

For more information about how to schedule a Skype Meeting Broadcast, see [Schedule a Skype Meeting Broadcast](https://support.office.com/article/schedule-a-skype-meeting-broadcast-c3995bc9-4d32-4f75-a004-3bc5c477e553).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
