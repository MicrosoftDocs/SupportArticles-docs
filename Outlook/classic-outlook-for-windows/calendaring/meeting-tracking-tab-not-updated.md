---
title: The Outlook meeting tracking tab is not updated
description: In Outlook, the meeting tracking tab for a meeting that you organized is not updated with the attendees' responses. And, the responses may unexpectedly remain in the Inbox, even though the option is enabled to delete meeting responses that were processed.
author: cloud-writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Calendar\Tracking information incorrect
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Microsoft Office Outlook 2007
  - Exchange Online
  - Microsoft Business Productivity Online Dedicated
  - Microsoft Business Productivity Online Suite Federal
ms.date: 01/30/2024
---

# The Outlook meeting tracking tab is not updated

## Symptoms

Consider the following scenario: 

1. You use Microsoft Outlook to schedule a meeting and invite attendees.    
2. The attendees accept or decline the meeting and send their meeting responses.    
3. You see the meeting responses in the Inbox folder in Outlook.    

In this scenario, when you open the meeting that you scheduled from the Calendar folder, you notice that the **Tracking** page does not show updated values in the **Response** column.

Additionally, if you enabled the **Update tracking information, and then delete responses** option in Outlook, the meeting responses are not deleted as expected.

## Cause

The meeting responses are being processed by another client, device, or third-party application. These may include, but are not limited to, the following.

- Outlook add-ins   
- Mail archiving program   
- Devices that use Collaboration Data Objects (CDO) to synchronize with your Microsoft Exchange mailbox or calendar   
- Devices that use Microsoft Exchange ActiveSync (EAS) to synchronize with your mailbox or calendar   
> [!NOTE]
> If the attendees accept the meeting and choose to not send a response, it is expected that the tracking tab is not updated with their response.

## Resolution

To determine whether Outlook add-ins caused the meeting response to be processed, disable Outlook add-ins temporarily, and then try to reproduce the problem. If the problem does not occur when the add-ins are disabled, additional investigation of the add-ins may be necessary.

For more information about how to disable add-ins in Outlook, see [View, manage, and install add-ins in Office programs](https://support.office.com/article/view-manage-and-install-add-ins-in-office-programs-16278816-1948-4028-91e5-76dca5380f8d).

To determine whether a mobile device caused the meeting response to be processed, determine whether you have any mobile devices that are regularly used to sync against the Exchange calendar. Make sure that you upgrade to the newest operating system of your mobile device to avoid known issues that are already resolved. Temporarily disable access to the mobile device, and then try to reproduce the behavior. If the behavior does not occur, additional investigation of the mobile device may be necessary.

You can also investigate the cause of the behavior by using MFCMapi to review the calendar item. MFCMapi is a Messaging API (MAPI) client that exposes additional information about folders and items in an Exchange mailbox. Download **MFCMAPI** from [github](https://github.com/stephenegriffin/mfcmapi/releases/) (scroll down and then click **Latest release**).

To determine whether the meeting response was processed by something other than Outlook, follow these steps: 
 
1. On your Outlook client computer, create a meeting, and then send a meeting invitation to an attendee.    
2. Exit Outlook.    
3. Have the attendee accept the meeting invitation, and then have them send a response back to the organizer.    
4. On your client computer, keep Outlook closed.    
5. Use MFCMapi to examine the meeting response that the attendee sent. To do this, follow these steps:  
   1. Run MFCMAPI.exe.    
   2. Click the **Session** menu, and then click **Logon**.    
   3. If you are prompted for a profile, select your profile name, and then click **OK**.    
   4. In the top pane, locate the line that corresponds to your mailbox, and double-click it.    
   5. In the navigation pane (left-side pane), expand **Root Container**, and then expand **IPM_SUBTREE**.

      > [!NOTE]
      > If the profile that you chose in step 5C connects to your Exchange mailbox in Online mode, expand **Top of Information Store** instead of **IPM_SUBTREE**.    
   6. Double-click the **Inbox** folder to open a new window that displays its contents.    
   7. Find the meeting response item that the attendee sent to you, and then select it. Do not double-click to open it.    
   8. In the bottom pane, locate the **PR_PROCESSED** property in the **Property name(s)** column.

      - If the meeting response has a PR_PROCESSED property, and if the property is set to **True**, the meeting response was processed by another client, device, or third-party application. Therefore, when you start Outlook, it considers that this item was already processed and does not update the tracking on the calendar item.    
      - If the meeting response does not have the PR_PROCESSED property, the meeting response has not been processed.         
     
6. Use MFCMapi to locate the attendee meeting response. To do this, follow these steps:  
   1. Open the Calendar folder, and then locate the item.    
   2. In **Property Name** column, locate the PR_RECIPIENT_TRACKSTATUS property, and then look at the **Smart View** column. Possible values are as follows: 
      - Flags: respNone
      - Flags: respAccepted
      - Flags: respDeclined
      - Flags: respTentative
