---
title: Desktop or Application sharing can't connect in a conference
description: Resolves a problem in which participants can't connect to a desktop-sharing or application-sharing session in Skype for Business Online.
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
appliesto:
- Skype for Business Online
---

# Desktop or Application sharing can't connect in a Skype for Business Online conference

## Problem 

A user shares the user's desktop or an application with other participants through Skype for Business Online (formerly Lync Online). However, the participants in the conversation can't connect to the desktop sharing session. The user receives the following error message in Lync 2010 or Lync 2013:

**Cannot start Desktop/Application Sharing due to network issues.**

A message that resembles the following entry is recorded in the Lync UCCP logs:

```AsciiDoc
ms-client-diagnostics: 23; reason="Call failed to establish due to a media connectivity failure when one endpoint is internal and the other is remote";CallerMediaDebug="application-sharing:ICEWarn=0x4000320,LocalSite=207.46.5.9:20702, LocalMR=207.46.5.63:54829,RemoteSite=11.1.111.11:62198, RemoteMR=65.55.127.64:51184, PortRange=1025:65000,LocalMRTCPPort=54829, RemoteMRTCPPort=51184,LocalLocation=1, RemoteLocation=2,FederationType=0"
```

## Solution 

To resolve this issue, follow these steps: 
 
1. Try to reproduce the issue by using one contact or multiple contacts. If the issue occurs for only one contact, determine whether anyone else can reproduce the issue with the same contact. If the issue occurs for multiple contacts, check for commonalities among the group of contacts.    
2. > [!IMPORTANT]
   > This step applies only to the Office 365 for enterprises and the Office 365 for professionals and businesses plans. This step doesn't apply to Office 365 dedicated subscription plans. Don't use this step to troubleshoot this issue if you have an Office 365 dedicated plan.

   Make sure that your network meets all the requirements for the best experience with Skype for Business Online. For more information, go to the following Microsoft Knowledge Base article:

   [2409256](https://support.microsoft.com/help/2409256) You can't connect to Skype for Business Online, or certain features don't work, because an on-premises firewall blocks the connection     
3. Verify that the video drivers are up to date and are working correctly.    
  
## More information

This issue usually occurs because one or more of the following conditions are true:

- Port 443 or ports 50040-50059 are blocked.   
- Traffic to or from meet.lync.com is blocked.   

If the error message in the "Symptoms" section is present in the UCCP client logs for Lync, there's likely a communication error between two Lync edge servers. This means that two users who try to connect are connected through different edge servers that can't communicate with one another.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).