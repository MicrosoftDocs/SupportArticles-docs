---
title: Audio or video connections are of poor quality or fail in Lync Mobile 2013
description: Describes the conditions under which you experience poor quality audio or video connections in Lync Mobile 2013. This includes situations in which you can't connect at all.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: dahans
appliesto: 
  - Skype for Business Online
ms.date: 3/31/2022
---

# Audio or video connections are of poor quality or fail completely in Lync Mobile 2013

## Problem

> [!NOTE]
> This article discusses how to troubleshoot Voice over IP (VoIP) and video connections through Lync Mobile 2013. It does not cover issues that occur when you're using Skype for Business Online (formerly Lync Online) together with a Lync to Phone partner to dial out to your designated mobile number (also known as Call via Work, or CVW).

Users who are logged in to Lync Mobile 2013 may experience issues when they try to make VoIP or video calls over Wi-Fi or mobile data connections. Tapping **Retry** repeatedly does not resolve the problem, and the connection attempt is unsuccessful.

## Solution

In most cases, audio and video connection issues can be resolved by following these steps:

1. If a Wi-Fi connection is available, switch to that connection, and make sure that only the **Require Wi-Fi for VoIP and video connections** setting is selected.
   - If you're using a corporate Wi-Fi connection that uses a proxy, you may have to configure the **HTTP Proxy** details in the Lync Mobile 2013 settings. 

     :::image type="content" source="./media/audio-or-video-connections-fail/http-proxy.png" alt-text="Screenshot that shows the HTTP Proxy configuration page.":::

   - Skype for Business Online administrators should also make sure that the corporate firewall is configured correctly to allow necessary traffic in and out of the corporate network. For more information, see [You can't connect to Skype for Business Online, or certain features do not work, because an on-premises firewall blocks the connection](https://support.microsoft.com/help/2409256).   

2. If you're using the mobile data connection, make sure that your bandwidth isn't limited and that other data-intensive applications work without any problems. Try using a web browser to make sure that you can access other websites.   
3. Skype for Business Online administrators should make sure that the Skype for Business Online users involved are allowed to make audio or video calls in the Lync Administration Center. Also, check the kind of contact that the Lync user is trying to communicate with. If the contact is from another Lync organization or if it is logged in through Skype, audio or video conversations may be disabled. For more information, see [Admins: Configure Skype for Business settings for individual users](/skypeforbusiness/set-up-skype-for-business-online/configure-skype-for-business-settings-for-individual-users).

## More Information

There are many potential causes of audio and video connection issues. These include the following:

- There are network connectivity or bandwidth issues.   
- There are mobile carrier limitations if you're using a mobile data connection.   
- The Lync user or external contact doesn't support audio or video conversations.   

If audio and video connections continue to fail, collect logs from the mobile device, and then contact Skype for Business Online Technical Support.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).