---
title: LastActive attribute gives wrong user status info in Skype for Business Online
description: Describes a problem in which the LastActive attribute gives wrong user status info in Skype for Business Online. An update resolves the issue.
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
appliesto:
- Skype for Business Online
---

# LastActive attribute gives wrong user status info in Skype for Business Online

## Symptoms

In Skype for Business Online, the **LastActive** attribute occasionally shows outdated information (for example, a user may see a colleague who was online yesterday as "Offline 88 days"). This behavior may occur even when the **LastActive** attribute is disabled. A user whose **LastActive** attribute is incorrect can resolve the inaccurate time stamp by signing out and in or by manually changing their presence. 

## Status

This issue is known to occur in rare scenarios in Skype for Business Online.  Due to the highly available architecture of Skype for Business Online, in some rare occasions due to internal failovers that are transparent to users of the service, the **LastActive** state may not be replicated and some user accounts could end up in this state.  This issue impacts a small percentage of Skype for Business Online users, and typically self-corrects when those users sign out and sign back into the service.  

## Resolution

To resolve inaccurate **LastActive** data for a given user, have them sign out and sign back into Skype for Business Online.

## Workarounds

You may want to consider removing the **LastActive** attribute from the aggregation state category in your Skype for Business Online tenant to avoid this issue entirely. See the following article for instructions about how to do that:

[How to remove the LastActive attribute from the aggregation state category in Lync Server 2010, Lync Server 2013, Skype for Business Server 2015, and Skype for Business Online](https://support.microsoft.com/help/2684128)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).