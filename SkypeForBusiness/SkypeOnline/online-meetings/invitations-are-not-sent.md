---
title: Invitations are not sent from Outlook when you try to schedule a meeting
description: Describes an issue in which meeting invitations aren't sent to participants of a Skype for Business Online meeting if Outlook isn't connected to an Exchange server. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto: 
  - Skype for Business Online
ms.date: 3/31/2022
---

# Invitations are not sent from Outlook when you try to schedule a meeting in Skype for Business Online

## Problem

When you try to invite participants to a Skype for Business Online (formerly Lync Online) meeting in Outlook, the meeting invitations aren't sent as expected. This issue may occur if Outlook isn't connected to a Exchange Online server. 

## Solution

To resolve this issue, first determine whether Outlook is connected to an Exchange Online server, and then use one or both of the following troubleshooting steps, as necessary:

- If Outlook isn't connected to the Exchange Online server, restart Outlook, and then make sure that Outlook is now connected to the Exchange Online server. You can check the connection status in the status bar at the bottom of the Outlook window.   
- If Outlook is connected to the Exchange Online server, send an email message to test whether a message can be sent.   

If you can successfully send the email message, disable and re-enable the Online Meeting Add-in for Microsoft Lync.

1. Start Outlook, on the **File** menu, click **Options**, and then in the left navigation pane, click **Add-Ins**.   
2. Disable the add-in. To do this, follow these steps:
   1. In the **Manage** box, click **COM Add-ins**, click **Go.**   
   2. In the list of add-ins, clear the check box for the **Online Meeting Add-in for Microsoft Lync**entry, and then click **OK**.   
   3. Exit Outlook, and then exit Lync.   
   
3. Restart Lync, and then restart Outlook.   
4. Enable the add-in. To do this, follow these steps:
   1. In the **Manage** box, click **COM Add-ins**, click **Go.**   
   2. In the list of add-ins, select the check box for the **Online Meeting Add-in for Microsoft Lync**entry, and then click **OK**.   
   3. Exit Outlook, and then exit Lync.   
   
5. Restart Lync, and then sign in.   
6. Restart Outlook, and then confirm that the issue is fixed by sending a meeting invitation.   


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).