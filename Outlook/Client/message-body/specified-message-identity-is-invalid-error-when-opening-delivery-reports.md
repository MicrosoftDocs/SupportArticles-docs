---
title: Specified Message Identity is Invalid error
description: Fixes an issue that prevents the delivery report tool from working in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: luche, genli
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Specified Message Identity is Invalid error when you open delivery reports in Outlook

_Original KB number:_ &nbsp; 4013793

## Symptoms

When you open a delivery report (**File** > **Open Delivery Report**) to track a sent email message in Microsoft Outlook, you receive one of the following error messages:

> The Specified Message Identity is Invalid

> The operation couldn't be performed because '{MailboxGUID}' couldn't be found.

## Cause

This issue occurs if the delivery report has a corrupted or incorrect URL, or if the URL has an incorrect [mailbox GUID](/previous-versions/tn-archive/aa996437(v=exchg.65)). Here's an example of the URL of a delivery report:

> `https://outlook.office365.com/owa/options/ecp/PersonalSettings/DeliveryReport.aspx?rfr=olk&exsvurl=1&IsOWA=N&MsgID=xxxx&Mbx=%<MailboxGUID>`

> [!NOTE]
> The *\<MailboxGUID>* placeholder represents the mailbox GUID. You can check whether the GUID in the URL matches the GUID in the error message or on the Exchange server.

## Resolution Method 1 - Clear the value of the UseRWHlinkNavigation registry entry

1. Exit all Microsoft Office applications.
2. Start Registry Editor:
   - In Windows 10, go to **Start**, enter *regedit* in the **Search** box, and then select **regedit.exe** in the search results.
   - In Windows 7, select **Start**, enter *regedit* in the **Search programs and files** box, and then select **regedit.exe** in the search results.
   - In Windows 8 and Windows 8.1, move your mouse pointer to the upper-right corner, select **Search**, type *regedit* in the search box, and then select **regedit.exe** in the search results.

3. Locate and right-click the following registry entry:

   `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\x.0\Common\Internet\`

    > [!NOTE]
    > The *x.0* placeholder represents the version number (Outlook 2010 is 14.0, Outlook 2013 is 15.0, Outlook 2016, Outlook for Microsoft 365 and Outlook 2019 is 16.0).

4. In the **Details** pane, select and hold (or right-click) **UseRWHlinkNavigation**, and then select **Modify**.
5. In the **Value data** box, clear the value, and then select **OK**.
6. Exit Registry Editor.
7. Try to open the delivery report again.

## Resolution Method 2 -Refresh the value of the UseRWHlinkNavigation registry entry

1. Open another link in an email message in Outlook.
2. Check whether the value in the following registry entry is updated to the opened link URL.

   `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\x.0\Common\Internet\UseRWHlinkNavigation`

    > [!NOTE]
    > When you open a delivery report or any link in Outlook, the value of the following registry entry will be updated to the URL of the delivery report or the link.

3. If the value is updated to the opened link URL, try to open the delivery report again.

## More information

Delivery Reports is a message-tracking tool for checking whether an email message has been delivered to its recipients. You can check delivery reports through the Exchange admin center (EAC), Exchange Control Panel (ECP), or Outlook. When you open the delivery report of a sent email message in Outlook, you are redirected to an ECP tracking webpage that's specified for the email message. For more information, see [Track messages with delivery reports](/Exchange/mail-flow/transport-logs/track-messages-with-delivery-reports).
