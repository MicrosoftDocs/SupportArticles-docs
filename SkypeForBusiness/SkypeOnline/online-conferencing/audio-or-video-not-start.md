---
title: Audio or video doesn't start in a peer-to-peer or multiparty conference
description: Describes an issue in which you can't start audio or video in a peer-to-peer or multiparty conference in Skype for Business Online.
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
ms.reviewer: dahans
appliesto:
- Skype for Business Online
---

# Audio or video doesn't start in a peer-to-peer or multiparty conference in Skype for Business Online

## Problem

When you try to start audio or video in a peer-to-peer (P2P) or multiparty conference in Skype for Business Online (formerly Lync Online), you experience one or more of the following symptoms:

- The connection fails.   
- You receive an error message that resembles one of the following:
  - Your webcam is not configured or is in use.   
  - Your audio device is not configured or is in use.   
  - Cannot start audio/video due to network issues.   
  - Network issues are affecting the quality of audio/video.   
   
- Certain audio and video options are unavailable.   

## Solution

To resolve this issue, follow these steps:

1. If audio and video connect, but you experience poor quality, see the following article in the Microsoft Knowledge Base:

    [2386655 ](https://support.microsoft.com/help/2386655) You experience poor audio or video quality in Skype for Business Online   
2. Check the Skype for Business Admin Center to see whether audio/video capabilities are turned off for the whole domain or for the user or users who are experiencing the issue.   
3. Try using a different audio/video device on the same computer and try using the same audio/video device on a different computer. If the issue can be narrowed down to the specific audio/video device, verify that the [USB Peripheral device](https://technet.microsoft.com/lync/gg278173) is certified for use with Skype for Business Online.   
4. Run Windows/Microsoft Updateand install any updates (optional or required) for your audio/video devices.   
5. Open the Control Paneland bring up the Device Manager. Look under Sound, video and game controllers for any devices that have conflicts.   
6. Verify network connections for the best experience. To do this, follow these steps:
      1. Verify that you're connected by a direct wired connection, by a virtual private network (VPN) connection, by a Wi-Fi connection, or by a direct Internet home office connection.   
      2. Determine whether one or both users are roaming from one wireless access point to another wireless access point. In this situation, a delayed presence scenario may occur. In this scenario, the user may appear online but may actually be between two wireless access points.    
      3. Try to reproduce the issue when both users are on a wired connection, on a VPN connection, or on a Wi-Fi connection.   
   
7. Reset the Windows Sockets (Winsock) Catalog. To do this, follow these steps: 
    > [!NOTE]
    > You must be logged on to the computer as an administrator to do the steps. 
      1. On the **Start** screen, type cmd.   
      2. In the search results, right-click **Command Prompt**, and then click **Run as administrator**.   
      3. At the command prompt, type the following command, and then press **Enter**: 
            ```powershell
            netsh winsock reset
            ```
    4. Restart the computer.   
   
8. Reproduce the issue by using one contact or multiple contacts. To do this, follow these steps:
      1. If the issue is reproducible with only one contact, determine whether anyone else can reproduce the issue with the same contact.    
      2. If the issue occurs with multiple contacts, check for commonalities among the group of contacts.   
   
9. Important This step doesn't apply to Office 365 dedicated subscription plans. Don't use this step to troubleshoot this issue if you have an Office 365 dedicated plan.

    Verify that the network meets the requirements for connecting to Skype for Business Online. For more information, go to the following Microsoft Knowledge Base article: 

     [2409256 ](https://support.microsoft.com/help/2409256) You can't connect to Skype for Business Online, or certain features don't work, because an on-premises firewall blocks the connection   

## More Information

This issue occurs if one or more of the following conditions are true: 

- Audio and video capabilities are restricted for the whole domain or for the individual user.   
- A user's audio/video device isn't working or is configured incorrectly.    
- Ports 443, 50000-59999 are blocked. Traffic to meet.lync.com or from meet.lync.com is blocked, or both conditions are true.   
- Network bandwidth is limited or decreased.    
- Audio drivers, video drivers, or webcam drivers are out of date.   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
