---
title: This release of Lync cannot be used when join a Skype Meeting Broadcast
description: Describes an issue that triggers a "This release of Lync cannot be used in a Skype Meeting Broadcast" error when you try to join a Skype Meeting Broadcast as an "Event team" member. Provides a solution.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-swei
appliesto:
- Skype for Business Online
---

# "This release of Lync cannot be used in a Skype Meeting Broadcast" error when you join a Skype Meeting Broadcast as an "Event team" member

## Problem 

When you try to join a Skype Meeting Broadcast as an "**Event team"** member, you receive the following error message in the client:  

**This release of Lync cannot be used in a Skype Meeting Broadcast. To join a Skype Meeting Broadcast, you must use a Click-to-Run version of Lync. Please contact your system administrator.**   

## Solution 

If you must have **Producer** controls to start, stop, and record a broadcast, you must uninstall the Skype for Business 2016 client (MSI) and install a supported client. 

If you don't require Producer controls and are joining as an event team member only as a **presenter**, you can ignore the warning message. 

## More information

Joining as an "Event team"** **member **with the broadcast controls** is supported only in the following Skype for Business clients: 
 
- Skype for Business 2015 (build 15.0.4747 and later)    
- Skype for Business 2016 (Click-to-Runbuild 16.0.4227 and later)    
 
Joining as an Event team member **without the broadcast controls** is supported only if another event team clicks **Invite More People** in the Skype for Business meeting and then selects the Skype for Business user. In this situation, the invited user can upload a Microsoft PowerPoint presentation and share audio and video. The following Skype for Business clients are supported when no broadcast controls are displayed: 
 
- Skype for Business 2015 client (Click-to-Run)    
- Skype for Business 2015 client (MSI)    
- Skype for Business 2015 Basic client    
- Skype for Business 2016 client (Click-to-Run)    
- Skype for Business 2016 client (MSI)    
- Skype for Business 2016 Basic client    
 
For more information about Skype Meeting Broadcast, visit the following Microsoft websites: 

- [What is a Skype Meeting Broadcast?](https://support.office.com/article/what-is-a-skype-meeting-broadcast-c472c76b-21f1-4e4b-ab58-329a6c33757d) 
- [Manage a Skype Meeting Broadcast event](https://support.office.com/article/manage-a-skype-meeting-broadcast-event-c7b98cbe-d168-4cf4-b87f-867707b25811) 
- [Install Skype for Business on your PC](https://support.office.com/article/install-skype-for-business-on-your-pc-8a0d4da8-9d58-44f9-9759-5c8f340cb3fb) 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).