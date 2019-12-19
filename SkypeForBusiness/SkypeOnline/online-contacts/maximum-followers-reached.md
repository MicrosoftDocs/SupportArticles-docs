---
title: Maximum Followers Reached message in contact card or presence is not displayed
description: Discusses that you receive a Maximum Followers Reached message in the Microsoft Lync contact card or the Lync presence isn't displayed. Provides a link to a Microsoft Office Help topic.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.reviewer: romanma, dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# "Maximum Followers Reached" message in the Lync contact card or the Lync presence is not displayed

## Problem

You may experience one of the following problems in Skype for Business Online (formerly Lync Online): 

- The Lync contact card includes a "Maximum Followers Reached" message.   
- A Lync contact displays no presence.   

## More Information

This problem occurs when a Lync user (User A) adds a contact for another Lync user (User B), and User B reaches or exceeds the maximum number of followers that are specified by the Microsoft Lync Server presence policy.

This limit on the number of followers can't be increased in Skype for Business Online. However, users should review the following Microsoft Office Help topic for best practices and guidelines about how to manage contact lists: 

[Manage your contacts and Contacts list](https://office.microsoft.com/redir/ha101835254.aspx)

When User A adds User B as a contact, User A subscribes to five categories of information about User B. Updates for these categories of information are automatically sent to User A. The user model assumes a default of 1,000 category subscriptions per Lync user. This means that a Lync user can be a contact of as many as 200 other Lync users.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
