---
title: Error occurs when sending sharing invitation
description: Describes an issue in Outlook in which some internal recipients receive an Internet Connection Sharing file instead of a Calendar Sharing message or you receive a Policy does not allow granting permissions error.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft 365 Apps for enterprise
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# Internet Connection Sharing file instead of a Calendar Sharing or Policy does not allow granting permissions error

_Original KB number:_ &nbsp; 983062

## Symptoms

Consider the following scenario:

- In Microsoft Outlook, you right-click an Exchange calendar, point to **Share**, and then select **Share Calendar**.
- You add recipients to the **To** field of the message by typing the recipients' aliases and then accepting the autocomplete suggestions that are provided by Outlook.
- You send the sharing invitation.

In this scenario, you experience one of the following symptoms:

- You receive the following error message:

  > Policy does not allow granting permissions at this level to one or more of the recipient(s). please select another permission level and send the sharing invite again.

- You receive the following prompting message:

  > The Calendar was shared with some of the recipients. However, calendar sharing is not available with the following entries because of permission settings on your network:  
  > **Contact name \<Contact address>**  
  > Do you want to send them a copy of this calendar in an e-mail message instead?  
  > **Yes** **No**  

  Some contacts that are listed are internal to your intranet and to your Exchange servers. However, these contacts are listed together with their external address and not with their internal account name.

  If you select **Yes**, you receive the following prompting message:

  > Send a Calendar via E-mail  
  Specify the calendar information you want to include.  
  Calendar: **Selected_Calendar**  
  Date Range: **Date_Range**  
  Detail: **Availability_Information**  
  Advanced:  
  **OK** **Cancel**

  If you select **OK**, an email Calendar Sharing message is created that contains an Internet Connection Sharing attachment that contains the calendar data. However, the Internet Connection Sharing file does not let internal recipients share your calendar through the Exchange server. The Connection Sharing file provides only a copy of your calendar's information.

## Cause

This issue occurs when an internal recipient is also in your Contacts list in Outlook. When you add this recipient to a Calendar Sharing message, the autocomplete feature of Outlook adds the recipient to the recipient list by using the recipient's external email address.

For example, a recipient has the Exchange alias **User1**. When you add them as a recipient to the Calendar Sharing message, their address is displayed as **User_name** (**User1**@**contoso**) and not as **User_name**.

## Workaround

To work around this issue, select internal recipients directly from the global address list. To do this, follow these steps:

1. In the Sharing invitation, select the **To** button. The **Select names** window opens.
2. In the **Address**, select **Global Address List**.
3. In the **Search** box, type the recipient's name.
4. Select the recipient to whom you want to send the invitation, and then select **To**.
5. Repeat steps 3 and 4 for each internal Exchange recipient to whom you want to send the invitation.
6. Select **OK**, and then select **Send**.
