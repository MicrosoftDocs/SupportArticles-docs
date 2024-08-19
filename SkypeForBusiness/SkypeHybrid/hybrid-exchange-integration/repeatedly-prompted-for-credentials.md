---
title: You're repeatedly prompted for Exchange credentials after you sign in to Lync
description: Describes an issue in which you are repeatedly prompted for a user name and password when you try to access Skype for Business Online. Resolutions are provided for certain scenarios.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business Online
  - Lync 2010
  - Lync 2013
ms.date: 03/31/2022
---

# You're repeatedly prompted for Exchange credentials after you sign in to Lync

## Problem 

After you successfully sign in to Skype for Business Online (formerly Lync Online) by using Lync 2010 or Lync 2013, you may experience the following issues: 
 
- You receive a message in Lync that says it cannot connect to Exchange.    
- You're repeatedly prompted to provide a user name and a password to connect to Exchange.    
- You may also receive the following message: 
   
    Credentials are required 

    :::image type="content" source="./media/repeatedly-prompted-for-credentials/credentials.png" alt-text="Screenshot that shows the Credentials are required window.":::

> [!NOTE]
> The message that you receive may vary, depending on which service Lync is trying to connect to. You may be prompted for credentials when Lync tries to connect to any of the following services:
> - Calendar and Free/Busy information from Outlook    
> - Exchange Web Services (EWS)    
> - Response Group Service    
> - Address Book Service    
  
## Solution 

This issue occurs for multiple reasons, and in certain scenarios, it is the expected behavior. Lync generally prompts you for credentials only after you're signed in and when it must connect to an external service such as the Microsoft Exchange Free/Busy service or the Exchange Calendar service. If Lync continues to prompt you for credentials after it has done this several times, there's probably an issue with Outlook or with the Exchange services.  

### Solutions for Lync users

If a firewall or a proxy is blocking Lync from connecting to EWS, you may experience symptoms such as repeated credential requests, stale Address Book Service (ABS), and intermittent Free/Busy presence issues. To resolve this problem, verify that the user has the correct proxy configured in Internet Explorer. To do this, follow these steps:

1. Start Internet Explorer.   
2. On the **Tools** menu, click **Internet Options**, click **Connections**, and then click **LAN Settings**.   
3. Make sure that the **Automatically detect settings** option is selected. If your organization requires you to enter specific information for the proxy server or an automatic configuration script, contact your network administrator.   
4. Restart both Internet Explorer and Lync to check whether the problem is resolved. If the problem persists, go on to the next section.   

#### Lync can't connect to Outlook or EWS

If Lync doesn't integrate automatically with Outlook, Lync prompts you for credentials before it lets you connect to Outlook to retrieve Calendar and Free/Busy information. If you are prompted repeatedly after you enter your credentials, see the following Microsoft Knowledge Base article: 

[2436962](https://support.microsoft.com/help/2436962) "There was a problem connecting to Microsoft Office Outlook" error when you sign in to Skype for Business Online 

If Lync doesn't automatically connect to EWS, Lync prompts you for credentials before it lets you access the EWS URLs. If you are still prompted after you enter your credentials, see the following Microsoft Knowledge Base article:

[2787614](https://support.microsoft.com/help/2787614) Conversation history, contact cards, Free/Busy, and Out of Office information are unavailable when Lync fails to connect to Exchange 

If you're repeatedly prompted to enter your credentials or receive the "Access Denied" error message, see the following Microsoft Knowledge Base article:

[2630976](https://support.microsoft.com/help/2630976) "Access Denied" error, or user is repeatedly prompted for credentials when trying to connect to Microsoft 365 by using a rich client application

### Solutions for Lync administrators

#### Lync can't connect to Outlook or EWS

If the Exchange server or EWS is unavailable, this causes Lync to continuously prompt for credentials because it can't contact Exchange for authentication. To resolve this issue, verify that Outlook has connectivity to the mailbox. If Outlook can't connect to Exchange, troubleshoot the issue as an Exchange connectivity issue. For more information, see the following Microsoft Knowledge Base article:

[2787614](https://support.microsoft.com/help/2787614) Conversation history, contact cards, Free/Busy, and Out of Office information are unavailable when Lync fails to connect to Exchange

If a firewall or a proxy is preventing Lync from connecting to EWS, you may experience symptoms such as repeated credential requests, stale ABS, and intermittent Free/Busy presence issues.

Ports 443, 5060, and 5061 must be open on the firewall and on proxy servers to let traffic pass freely. For more information about firewall or proxy issues in a Microsoft 365 environment, see the following Microsoft Knowledge Base article: 

[2409256](https://support.microsoft.com/help/2409256) You can't connect to Skype for Business Online, or certain features don't work, because an on-premises firewall blocks the connection 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
