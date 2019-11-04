---
title: Telephone numbers of contacts are missing
description: Describes an issue in which telephone numbers of contacts are missing in Lync 2013 or Skype for Business. Occurs for users whose photos are disabled. A workaround is provided.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: premgan
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft Lync 2013
- Lync Basic 2013
- Skype for Business
- Skype for Business Online
---

# Telephone numbers of contacts are missing in Lync 2013 or Skype for Business

## Symptoms 

When you use one of the following methods to call a user in Microsoft Lync 2013 or Microsoft Skype for Business, the telephone number (or numbers) may not be displayed:

- You right-click the contact, as in the following screen shot:

   ![Select Contact card](./media/contacts-telephone-numbers-missing/select-contact.jpg)

- You select the call menu, as in the following screen shot:

   ![Select call menu](./media/contacts-telephone-numbers-missing/select-call-menu.jpg)   


## Cause

This issue may occur in the following scenario: 

- The user is included in the contact list.   
- The user has explicitly blocked his or her photo from being published.   
- You have to scroll down in order to see the affected user.   
- The user has at least one associated phone number.   

### Hotfix or update information

- Microsoft is currently investigating this issue.   

## Workaround

To work around this issue, use one of the following methods as a user with admin permissions:

- Make sure that the **Show my picture** option is enabled for all users, even if they haven't published a photo:

  ![Enable show my picture](./media/contacts-telephone-numbers-missing/enable-show-my-picture.jpg)

- Expand the contact card details before you try to call that particular user, as in the following screen shot:

  ![Expand contact card details](./media/contacts-telephone-numbers-missing/expand-contact-card.jpg)
