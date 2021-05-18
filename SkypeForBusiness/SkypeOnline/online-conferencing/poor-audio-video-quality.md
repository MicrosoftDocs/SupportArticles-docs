---
title: You experience poor audio or video quality in Skype for Business Online
description: Provides guidelines for troubleshooting issues of poor audio or video quality in Skype for Business Online.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.custom: CSSTroubleshoot
ms.reviewer: dahans
appliesto:
- Skype for Business Online
---

# You experience poor audio or video quality in Skype for Business Online

## Problem

When you try to connect to a Skype for Business Online (formerly Lync Online) conference or make a peer to peer call, the audio or video quality may be choppy, tinny, or delayed. This causes the meeting or call to be unusable.

## Solution

There are tools that you can use to determine the source of the issue.

In Lync 2010 and Lync 2013, you can use voice and video quality indicators to identify how well you're being heard or viewed. New indicators that are displayed in the conversation window tell you when conditions are present that may affect the quality of the voice or video call. These conditions may include poor network connectivity, low-bandwidth network connections, or poor audio quality from a particular device. In scenarios in which you experience poor audio quality, click the indicator to display possible reasons for the audio issue and to link to relevant resources.

### Lync 2010

![Screen shot of the vioce and video quality indicator in Lync 2010 ](./media/poor-audio-video-quality/lync-2010.jpg)

### Lync 2013

![Screen shot of the vioce and video quality indicator in Lync 2013 ](./media/poor-audio-video-quality/lync-2013.jpg)

As a general guideline, to troubleshoot scenarios in which you experience poor audio or video quality in a Skype for Business Online conference, follow these steps: 
1. Determine whether the computer is using a wired or wireless Internet connection. A wired connection can provide more bandwidth and stability in most cases and should be the preferred method of connecting if that kind of connection is available. Additionally, consider turning off any wireless antennas to avoid connecting through a wireless connection.   
2. Make sure that the audio/video device that is being used is approved and certified to work with Lync 2010. For more information, see [Phones and devices qualified for Lync](/SkypeForBusiness/lync-cert/ip-phones). 
3. Select the correct device, and make sure that the recording volume is at the appropriate level. In the upper-right area of the window, click the gear icon, click **Tools**, click **Options**, and then click **Audio Device**. Verify that the appropriate device is selected.

   Adjust the **Microphone** slider to the volume level that you want. Speak at your usual voice level. The indicator should go no higher than the midway point.

## More Information

This issue may occur for many reasons, such as network latency, video or audio driver configuration issues, or device configuration issues. 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).