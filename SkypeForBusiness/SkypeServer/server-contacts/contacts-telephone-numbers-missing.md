---
title: Telephone numbers of contacts are missing
description: Describes an issue in which telephone numbers of contacts are missing in Lync 2013 or Skype for Business. Occurs for users whose photos are disabled. A workaround is provided.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: premgan
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft Lync 2013
  - Lync Basic 2013
  - Skype for Business
  - Skype for Business Online
ms.date: 03/31/2022
---

# Telephone numbers of contacts are missing in Lync 2013 or Skype for Business

## Symptoms 

When you use one of the following methods to call a user in Microsoft Lync 2013 or Microsoft Skype for Business, the telephone number (or numbers) may not be displayed:

- You right-click the contact, as in the following screenshot:

   :::image type="content" source="./media/contacts-telephone-numbers-missing/select-contact.png" alt-text="Screenshot that shows contact options appear without phone number after right-clicking a contact.":::

- You select the call menu, as in the following screenshot:

   :::image type="content" source="./media/contacts-telephone-numbers-missing/select-call-menu.png" alt-text="Screenshot that shows phone number not showing when selecting the call menu.":::


## Cause

This issue may occur in the following scenario: 

- The users are included in the contact list.   
- The users have explicitly blocked their photo from being published.   
- You have to scroll down in order to see the affected users.   
- The users have at least one associated phone number.   

### Hotfix or update information

- Microsoft is currently investigating this issue.   

## Workaround

To work around this issue, use one of the following methods as a user with admin permissions:

- Make sure that the **Show my picture** option is enabled for all users, even if they haven't published a photo:

  :::image type="content" source="./media/contacts-telephone-numbers-missing/enable-show-my-picture.png" alt-text="Screenshot that shows the Show my picture option enabled for in the options window.":::

- Expand the contact card details before you try to call that particular user, as in the following screenshot:

  :::image type="content" source="./media/contacts-telephone-numbers-missing/expand-contact-card.png" alt-text="Screenshot that shows the Call Work number in the expanded contact card details":::

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
