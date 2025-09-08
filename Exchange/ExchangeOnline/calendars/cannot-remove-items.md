---
title: You can't remove a calendar item or an email message in Outlook in Microsoft 365
description: Describes an issue in which you can't remove a meeting request or an email message in Microsoft Outlook. Provides a resolution.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Microsoft Business Productivity Online Dedicated
  - Microsoft Business Productivity Online Suite Federal
ms.date: 01/24/2024
ms.reviewer: v-six
---
# You can't remove a calendar item or an email message in Outlook in Microsoft 365

## Problem

You can't remove a calendar item such as a meeting request, a reminder, or an email message in Microsoft Outlook in Microsoft 365. Additionally, if you try to remove a meeting request, you may receive an error message that resembles the following message:

> This meeting cannot be removed because you are the meeting organizer.

## Solution

> [!NOTE]
> Before you try the methods in this section, exit all clients (such as Outlook and Outlook on the web) on which the mailbox is set up, start Outlook, and then try to remove the item. If the problem persists, try Method 1 first. If that doesn't fix the problem, try the next method.

To resolve this problem, use one or more of the following methods.

### Recommended method

#### Method 1: Use Outlook on the web

Try to delete the item in Outlook on the web. If you can't delete it in Outlook on the web, go to the next method.

> [!NOTE]
> If you can't complete a task in Outlook but you can complete it in Outlook on the web, this might mean that Outlook has to be updated.

### Additional methods

#### Method 2: Use the Search-Mailbox cmdlet

Use the Search-Mailbox cmdlet to search for and remove the item. For more information, see [Search and delete messages](/microsoft-365/compliance/search-for-and-delete-messages-in-your-organization).

#### Method 3: Run Outlook commands

Depending on the kind of item that you're trying to remove, you can use the following command line switches to remove the item.

Caution Exit Outlook before you run any of these switches.

- Click **Start**, enter outlook /cleanreminders in the search box, and then press Enter.
- Click **Start**, enter outlook /cleandmrecords in the search box, and then press Enter.
After you run the applicable switches, start Outlook, and then try to delete the message again.

For more information about these switches, see [Command-line switches for Outlook for Windows](https://support.office.com/article/command-line-switches-for-outlook-for-windows-079164cd-4ef5-4178-b235-441737deb3a6).

#### Method 4: Delete the message after you edit it

1. In Outlook, double-click the email message.
2. In the **Move** group in the message ribbon, click **Actions**, and then click **Edit Message**.
3. Remove some characters from the message, or add characters to it.
4. Click **File**, and then save the message.
5. Try to delete the message again.

#### Method 5: Empty the Deleted Items folder

In Outlook, delete all items that are in the Deleted Items folder, and then try to delete the meeting request or message.

#### Method 6: Delete the meeting reminders by using the MFCMAPI editor

The following steps show how to remove a meeting reminder that still appears even after the original meeting is removed. This typically occurs if the meeting reminder is corrupted.

> [!NOTE]
> Although the MFCMAPI editor is supported by Exchange Online, use caution when you make changes to mailboxes by using this tool. Using the MFCMAPI editor incorrectly can cause permanent damage to a mailbox. The exact steps may vary, depending on the version of MFCMAPI that you're using.

1. Download **MFCMAPI** from [github](https://github.com/stephenegriffin/mfcmapi/releases/) (scroll down and then click **Latest release**).
2. In Outlook, click the **Send/Receive** tab.
3. In the **Preferences** group, click **Work Offline**, and then exit Outlook.
4. Double-click the MFCMapi.exe file to start the MFCMAPI editor.
5. On the **Session** menu, click **Logon and Display Store Table**.

   :::image type="content" source="media/cannot-remove-items/session.png" alt-text="Screenshot of MFCMAPI x86 Build windows, showing the Session tab and Logon and Display Store Table option.":::

6. Right-click the mail profile that you want to change, and then click **Open Store**.

   :::image type="content" source="media/cannot-remove-items/mail-profiles.png" alt-text="Screenshot of mail profiles.":::

7. Expand **Root-Mailbox**, expand **Finder**, and then double-click **Reminders**.

   :::image type="content" source="media/cannot-remove-items/mailbox.png" alt-text="Screenshot after expanding Root - Mailbox.":::

8. Locate the recurring appointment by sorting the **Subject** column or the **To** column.
9. Right-click the appointment, and then click **Delete Message**.

   :::image type="content" source="media/cannot-remove-items/delete-message.png" alt-text="Screenshot of appointment, showing the Delete Message.":::

10. In the **Delete Item** dialog box, select one of the permanent deletion options, and then click **OK**.
11. Click **Start**, type `outlook.exe /cleanreminders` in the search box, and then press Enter.
12. If you're prompted, select your profile to start Outlook.
  
## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
