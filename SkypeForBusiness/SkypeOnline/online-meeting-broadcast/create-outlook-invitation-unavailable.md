---
title: Create Outlook invitation link  isn't available in Skype Meeting Broadcast
description: Discusses an issue in which the Create Outlook invitation link is available only when your browser is configured to use the English (United States) language. Provides a workaround.
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
ms.reviewer: landerl, jasco, corbinm, dougl, lynnroe, cbland, rischwen, leonarwo, msp, romanma, tonyq
appliesto:
- Skype for Business Online
---

# The "Create Outlook invitation" link isn't available in Skype Meeting Broadcast

## Problem

After you schedule a Skype Meeting Broadcast at [https://portal.broadcast.skype.com](https://portal.broadcast.skype.com/), you don't see a link **Create Outlook invitation** on the meeting summary page. 

## Workaround

To work around this issue, use one of the following methods, as appropriate for your situation.

### Method 1: Manually send the meeting request

To manually send a join link to the Skype Meeting Broadcast participants by using an Outlook meeting invitation, follow these steps,  

1. In the [Skype Meeting Broadcast portal](https://portal.broadcast.skype.com/), go to the meeting summary page.   
2. Next to **Join link**, click **Show**.   
3. Click the copy icon to copy the meeting URL.

    ![Screen shot of the copy button for the Join link option in Skype Meeting Broadcast ](./media/create-outlook-invitation-unavailable/meeting-url.png)

4. Open your Outlook calendar, click New Meeting, and then paste the meeting URL into the body of your meeting invitation.   

### Method 2: Manually change the language identifier for the Skype Meeting Broadcast portal

To manually change the language identifier for the Skype Meeting Broadcast portal, follow these steps:

1. In the [Skype Meeting Broadcast portal](https://portal.broadcast.skype.com), browse to the meeting summary page.    
2. In the address bar of your browser, change the language identifier of the URL. For example, if you're using the French language, the URL will be https://portal.broadcast.skype.com/fr-FR. Change this to https://portal.broadcast.skype.com/en-US.   
3. Refresh your browser, and then open your meeting. The **Create Outlook invitation** option should be visible.   

## More Information

This issue occurs when your browser language preferences are set to a language other than **English (United States)**. Localized versions of the Outlook invitation content aren't yet available. 

For more information about how to schedule a Skype Meeting Broadcast, see [Schedule a Skype Meeting Broadcast](https://support.office.com/article/schedule-a-skype-meeting-broadcast-c3995bc9-4d32-4f75-a004-3bc5c477e553).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
