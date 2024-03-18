---
title: Can't join a meeting on iOS 10.0 and later
description: Describes an issue in which you can't join a meeting from outside Lync 2013, Lync 2010, or Skype for Business on iOS 10.0. Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: v-six
ms.reviewer: jaredgo, pmaloo, jasco, rischwen, amitpeer, mirung, corbinm, landerl
appliesto: 
  - Lync 2013 for iPad
  - Lync 2013 for iPhone
  - Skype for Business for iOS
ms.date: 03/31/2022
---

# You can't join a meeting from outside Lync 2013, Lync 2010, or Skype for Business on iOS 10.0 and later

## Symptoms

Consider the following scenario:

- You're using an Apple iPhone or Apple iPad that's running Apple iOS 10.0.   
- You have Microsoft Lync 2013, Lync 2010, or Skype for Business installed on the device.   
- You try to join a meeting from outside the Lync or Skype for Business app. For example, you tap the "Join Meeting" link in an email message or calendar appointment in an app other than Lync or Skype for Business.    

In this scenario, the link tries to start the desktop version of the website instead of the mobile version. The mobile version would try to start the Lync or Skype for Business app and join the meeting, or redirect you to the app store if it cannot join the meeting. The desktop version will not try to start the app. 

## Resolution

To fix this issue, install one of the following updates based on the version of your Microsoft Skype for Business Server or Microsoft Lync Server:

- Install the [November 2016 cumulative update 6.0.9319.272](https://support.microsoft.com/help/3199094) for Skype for Business Server 2015, Web Components Server. 
See [KB3204849](https://support.microsoft.com/help/3204849) for more information.   
- Install the [November 2016 cumulative update 5.0.8308.974](https://support.microsoft.com/help/3200078) for Lync Server 2013, web components server. 
See [KB3204546](https://support.microsoft.com/help/3204546) for more information.   

## Workaround

To work around this issue if you have Lync 2013 for iPhone, Lync 2013 for iPad, or Skype for Business for iOS installed, follow these steps:

1. Tap **Meetings**.   
2. Tap the title of the meeting that you want to join.   
3. Tap **Join Meeting**.   

> [!NOTE]
> This workaround applies only to organizers and attendees who have Lync 2013 for iPhone, Lync 2013 for iPad, or Skype for Business for iOS installed. If you don't have any of these apps installed, if you're on a Lync Server 2010 environment, or if you're a federated or anonymous attendee who is external to the organization, follow these steps to join the meeting:
> 1. Copy the meeting URL from the meeting invitation.    
> 2. Go to https://aka.ms/skypemeetingjoin-ios, and then paste the URL that you copied in step 1 into the text box on that webpage.  
> 3. Tap **Join Meeting**.   

## References

- [3097592 You can't join a meeting from outside Lync 2013, Lync 2010, or Skype for Business on iOS 9 or 9.1 ](https://support.microsoft.com/help/3097592)
- [3126487 You can't join a meeting from outside Lync 2013, Lync 2010, or Skype for Business on iOS 9.2 through later 9.x versions ](https://support.microsoft.com/help/3126487)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
