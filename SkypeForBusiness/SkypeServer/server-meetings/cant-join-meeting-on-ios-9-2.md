---
title: Can't join a meeting on iOS 9.2 and later
description: Describes an issue in which you can't join a meeting from outside Lync 2013, Lync 2010, or Skype for Business on iOS 9.2. Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
ms.reviewer: jaredgo, pmaloo, jasco, rischwen, amitpeer, mirung, corbinm, landerl 
appliesto:
- Lync 2013 for iPhone
- Lync 2013 for iPad
- Skype for Business for iOS
---

# You can't join a meeting from outside Lync 2013, Lync 2010, or Skype for Business on iOS 9.2 and later

## Symptoms

Consider the following scenario:

- You're using an Apple iPhone or Apple iPad that's running Apple iOS 9.2 through later 9.x versions.
- You have Microsoft Lync 2013, Lync 2010, or Skype for Business installed on the device.
- You try to join a meeting from outside the Lync or Skype for Business app. For example, you tap the "Join Meeting" link in an email message or calendar appointment in an app other than Lync or Skype for Business.

In this scenario, you're redirected to a "Join Launcher" webpage in the Safari web browser. The webpage contains a link to install the Lync 2013, Lync 2010, or Skype for Business app. However, the page does not contain a link that points to the meeting within the respective app.

## Resolution

To fix this issue if you have a Lync Server 2010 environment, install [April 2016 cumulative update 4.0.7577.728 for Lync Server 2010, Web Components Server](https://support.microsoft.com/help/3148802/april-2016-cumulative-update-4-0-7577-728-for-lync-server-2010-web-com).

To fix this issue if you have a Lync Server 2013 environment, install [January 2016 cumulative update 5.0.8308.945 for Lync Server 2013 web components server](https://support.microsoft.com/help/3126638/january-2016-cumulative-update-5-0-8308-945-for-lync-server-2013-web-c).

To fix this issue if you have a Skype for Business Server 2015 environment, install [March 2016 cumulative update 6.0.9319.235 for Skype for Business Server 2015, Web Components Server](https://support.microsoft.com/help/3134262/march-2016-cumulative-update-6-0-9319-235-for-skype-for-business-serve).

## Workaround

To work around this issue if you have Lync 2013 for iPhone, Lync 2013 for iPad, or Skype for Business for iOS installed, follow these steps:

1. Tap **Meetings**.   
2. Tap the title of the meeting that you want to join.   
3. Tap **Join Meeting**.   

> [!NOTE]
> This workaround applies only to organizers and attendees who have Lync 2013 for iPhone, Lync 2013 for iPad, or Skype for Business for iOS installed. If you don't have any of these apps installed, if you're on a Lync Server 2010 environment, or if you're a federated or anonymous attendee who is external to the organization, follow these steps to join the meeting:
> 1. Copy the meeting URL from the meeting invitation.    
> 2. Go to https://aka.ms/skypemeetingjoin-ios, and then paste the URL that you copied in step 1 into the text box on that webpage.
>3. Tap **Join Meeting**.   

## Status

Microsoft is researching this issue and will update this article when more information becomes available.

## References

- [3097592 You can't join a meeting from outside Lync 2013, Lync 2010, or Skype for Business on iOS 9 or 9.1 ](https://support.microsoft.com/help/3097592)
- [3193474 You can't join a meeting from outside Lync 2013, Lync 2010, or Skype for Business on iOS 10.0 and later ](https://support.microsoft.com/help/3193474/you-can-t-join-a-meeting-from-outside-lync-2013-lync-2010-or-skype-for)

**Third-party information disclaimer**

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
