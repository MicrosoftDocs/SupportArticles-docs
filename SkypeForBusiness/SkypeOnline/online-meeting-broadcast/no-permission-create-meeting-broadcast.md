---
title: Sorry, you don't have permission to create meeting
description: Describes an issue that may occur when you create a Skype Meeting Broadcast by using the Skype Meeting Broadcast portal in Skype for Business Online. Provides a solution.
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
ms.reviewer: landerl, jasco, corbinm, dougl, lynnroe, cbland, rischwen, leonarwo, msp, romanma, tonyq
appliesto:
- Skype for Business Online
---

# "Sorry, you don't have permission to create meeting" error when you try to create a Skype Meeting Broadcast in Skype for Business Online

## Problem

When you try to create a new Skype Meeting Broadcast by using the [Skype Meeting Broadcast portal](https://portal.broadcast.skype.com/) in Skype for Business Online, you receive the following error message: 

"Sorry, you don't have permission to create meeting."

![Screen shot of the error message in Skype Meeting Broadcast ](./media/no-permission-create-meeting-broadcast/error-message.png)

> [!NOTE]
> Skype Meeting Broadcast isn't currently available for nonprofit, educational (.edu), and government (.gov) plans. When customers who have one of these plans click **New Meeting** in the Skype Meeting Broadcast portal, they see this error message. However, because Skype Meeting Broadcast isn’t currently available for these plans, the steps in the "Solution" section won’t correct this issue.

## Solution

To fix this issue, use one of the following methods, as appropriate for your situation.

### Method 1: Prepare your organization and network for Skype Meeting Broadcast

To enable your organization and set up your network for Skype Meeting Broadcast, go to the following Microsoft website: 

[Set up Skype for Business Online for Skype Meeting Broadcast](https://support.office.com/article/set-up-skype-for-business-online-for-skype-meeting-broadcast-dfa736b9-4920-4f48-b8c0-b5487ec6086f)

### Method 2: Assign the appropriate license to the meeting organizer

Assign one of the following Office 365 licenses to the meeting organizer, as appropriate:

- Office 365 Enterprise E1   
- Office 365 Enterprise E3   
- Office 365 Enterprise E5   
- Skype for Business Online Standalone Plan 2

    > [!NOTE]
    > Skype for Business Online Standalone Plan 3 doesn’t include Skype Meeting Broadcast.   

For more information about how to assign licenses, see [Assign licenses to users](https://support.office.com/article/assign-or-unassign-licenses-for-office-365-for-business-997596b5-4173-4627-b915-36abac6786dc).

## More Information

This error message can be caused by one of the following conditions: 

- The Office 365 organization isn't enabled for Skype Meeting Broadcast.   
- The user doesn't have an assigned Skype for Business Online plan that grants this capability.    

For more information about Skype Meeting Broadcast, go to the following Microsoft websites:

- [What is a Skype Meeting Broadcast?](https://support.office.com/article/what-is-a-skype-meeting-broadcast-c472c76b-21f1-4e4b-ab58-329a6c33757d)   
- [Enable Skype Meeting Broadcast](https://support.office.com/article/enable-your-organization-for-skype-meeting-broadcast-5299cce0-850e-42dc-b6ae-2d0ee775c4a9)   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
