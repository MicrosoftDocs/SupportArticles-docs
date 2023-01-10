---
title: The Voice tab doesn't appear in the Skype for Business Admin Center
description: Discusses an issue in which the Voice tab is not displayed in the Skype for Business Admin Center. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: lyotechreview
ms.custom: CSSTroubleshoot
appliesto: 
  - Skype for Business Online
ms.date: 3/31/2022
---

# The Voice tab doesn't appear in the Skype for Business Admin Center

## Symptoms

When you browse the Skype for Business Admin Center in the Microsoft 365 portal, the **Voice** tab isn't visible even though users are assigned a Cloud PBX license or an Office 365 E5 license. 

## Resolution

A Cloud PBX or an Office 365 E5 license includes the ability to assign enterprise voice capabilities to Microsoft 365 users. This can cause users to expect that a **Voice** tab will appear in the Skype for Business Admin Center. However, management of voice features online depends on which option is selected for PSTN connectivity. Use the following guidelines:

- If you want to use PSTN Calling from Microsoft for a cloud-based solution, you must buy a Voice calling plan. The Voice calling plan options are PSTN Local Calling and PSTN Local and International Calling, depending on your need. For more information, see [Skype for Business add-on licensing](https://support.office.com/article/skype-for-business-online-licensing-overview-3ed752b1-5983-43f9-bcfd-760619ab40a7). 

    > [!NOTE]
    > After one of these plans is applied to your organization, the **Voice** tab appears in the Skype for Business Admin Center.

- If you want to use your existing Skype for Business or Lync Server deployment for PSTN connectivity, an administrator must manage the telephone numbers and the associated Skype for Business features through the Skype Online remote PowerShell, the on-premises Skype for Business PowerShell, or the Skype for Business control panel.

    For more information, see [Enable users for Phone System in Microsoft 365 with on-premises PSTN connectivity in Skype for Business Server](/skypeforbusiness/skype-for-business-hybrid-solutions/plan-your-phone-system-cloud-pbx-solution/enable-users-for-phone-system).   


## More Information

You can connect Cloud PBX to PSTN in the following ways:

- Purchase the PSTN Calling service add-on to Microsoft 365.   
- Use on-premises PSTN connectivity, in which software on-premises connects to your existing telephony infrastructure.    
For more information, go to the following Microsoft websites:

    - [Here's what you get with Phone System in Microsoft 365](https://support.office.com/article/here-s-what-you-get-with-cloud-pbx-bc9756d1-8a2f-42c4-98f6-afb17c29231c)
    - [Which Calling Plan is right for you?](https://support.office.com/article/what-is-pstn-calling-3dc773b9-95e0-4448-b2f1-887c54022429) 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).