---
title: Slow refresh in meetings when join conference in non-VbSS client
description: Describes an issue in which slow refresh or blurry desktop occurs when a user joins an online meeting on a non-video based screen sharing-capable client. Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business 2016
ms.date: 03/31/2022
---

# Slow refresh or blurry desktop in Skype Meetings when a user joins the conference on a non-VbSS client

## Symptoms

When a user shares a desktop in a Skype meeting, the screen refresh rate drops or the desktop is blurry for other users.

## Cause

This issue can occur when a user joins a meeting through a Lync client, Skype for Business 2015 client, Skype Web App, iOS client earlier than version 6.7, Android client earlier than version 6.7.0.7, or a Skype for Business 2016 client that is not correctly updated for Video-based Screen Sharing (VbSS) in a meeting that's hosted by VbSS-capable clients. 

The earlier client builds of Lync 2010, Lync for Mac, Lync 2013 and Skype for Business 2015 cannot register with VbSS. Therefore, they always force the entire meeting to fall back to Remote Desktop Protocol (RDP), along with someone joining the meeting from the Skype Web App. Earlier builds of the Android SfB client and iOS SfB client also experience this issue if they are not up-to-date. Although all Skype for Business 2016 clients can register with VbSS, clients that are not up-to-date can cause single users to experience this issue.

This issue can also occur for users in a Skype meeting that includes VbSS-capable clients if someone gives control of their screen. This is because screen sharing always uses RDP.

## Preferred approach 

During the migration phase-out of Office 2013 to Office 2016, we recommend that you follow the method in the "Workaround" section on computers that use Office 2016. This is because you can expect other attendees to join the meeting by using other builds of the Lync or Skype client. VbSS provides an optimal meeting experience because it significantly improves the resolution and refresh rate over a standard meeting session by a 6:1 ratio. (See the "References" section for more information.)

To make sure that all Office 2016 Skype for Business clients are updated correctly, see the following Office article:

[Video-based screen sharing in Skype for Business](https://support.office.com/article/video-based-screen-sharing-in-skype-for-business-071affc5-5482-4be1-930e-744fad71b73d?ui=en-us&rs=en-us&ad=us)

If there are networking issues that severely hinder the use of Skype for Business traffic in your environment, it's likely that you will not be able to use VbSS or RDP correctly without first addressing the networking issues. For all required Skype for Business Online Traffic and Port information, see the following document:

[Microsoft 365 URLs and IP address ranges](https://support.office.com/article/office-365-urls-and-ip-address-ranges-8548a211-3fe7-47cb-abb1-355ea5aa88a2?ui=en-us&rs=en-us&ad=us#bkmk_lyo)

If you have investigated all other possible causes of this issue, also make sure that your video drivers are as up-to-date as possible when you use this service.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

To work around this issue, disable VBSS for Skype Meetings, and then enable Microsoft Remote Desktop Protocol (RDP)-based screen sharing. To do this, make the following change in the registry:

1. In Registry Editor, locate and then select the following registry subkey: 

    **HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Lync**
1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.   
1. Type EnableConferenceScreenSharingOverVideo, and then press Enter.   
1. In the **Details** pane, right-click **EnableConferenceScreenSharingOverVideo**, and then click **Modify**.   
1. In the **Value data** box, type 0, and then click **OK**.   

Additionally, if you use the 32-bit version of Skype for Business 2016 on a 64-bit operating system, add the registry entry by following these steps:

1. In Registry Editor, locate and then select the following registry subkey:

    **HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\16.0\Lync**
1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.   
1. Type EnableConferenceScreenSharingOverVideo, and then press Enter.   
1. In the **Details** pane, right-click **EnableConferenceScreenSharingOverVideo**, and then click **Modify**.   
1. In the **Value data** box, type 00000000 and then click **OK**.   

## References

If users experience this issue in a peer-to-peer scenario without any involvement of the AVMCU, see the following Knowledge Base article: 

[Black or frozen screen when you share your screen in Skype for Business 2016](https://support.microsoft.com/help/3150900)

For more information about how to judge the value of VbSS, see the "Planning" section of the following TechNet topic:

[Video based Screen Sharing for Skype for Business Server 2015](/skypeforbusiness/manage/video-based-screen-sharing)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).