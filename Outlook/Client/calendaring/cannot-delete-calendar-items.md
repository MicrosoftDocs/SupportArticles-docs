---
title: Unable to delete calendar items
description: You can't delete corrupted calendar items in Outlook, even by using the MFCMAPI or EWSEditor tools.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar\Working with meetings or appointments
  - Outlook for Windows
  - CI 161181
  - CSSTroubleshoot
ms.reviewer: nourdinb, tylewis
appliesto:
  - Exchange Server 2013
  - Exchange Server 2016
  - Exchange Server 2019
  - Exchange Online
search.appverid: MET150
ms.date: 01/30/2024
---
# Can't delete calendar items in Outlook

## Symptoms

When you try to delete a calendar item by using Microsoft Outlook in online mode, you receive the following error message:

> The move, copy, or deletion cannot be completed. The items might have been moved or deleted, or you may not have sufficient permission. If the item was sent as a task request or meeting request, the sender might not receive updates.  

If you try to delete the item by using Outlook in Cached Exchange mode, the item is deleted only briefly and then reappears.

Also, you can't delete the item by using the MFCMAPI and EWSEditor tools. For more information, see the [Details](#details) section.

## Cause

This issue occurs because the calendar item is corrupted. When a calendar item in a mailbox is deleted, the change is logged in the Calendar Logging folder. If the item is corrupted, the logging is triggered but doesn't run correctly, and an exception is generated. This prevents the deletion from succeeding.

## Resolution

To resolve this issue, temporarily prevent the change to the calendar item from being logged, and then delete the item:

1. Run the following cmdlet:

    ```powershell
    Set-Mailbox <name_of_affected_mailbox> -CalendarVersionStoreDisabled $true 
    ```

    Wait for the database store configuration cache to expire. This will take about two hours. Then, go to step 3.

1. As an alternative to waiting for the cache to expire, if the affected mailbox is on Microsoft Exchange Server on-premises, you can use one of the following options, and then go to step 3. 

   **Warning:** These options will cause service interruptions.

    - Restart the Exchange Information Store service.
    - Mount the affected user's database on another server that's running Exchange Server.

1. Delete the calendar item. We recommend that you use the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/) tool.

1. After the item is deleted, run the following cmdlet to reverse the change to the value of the `CalendarVersionStoreDisabled` parameter:

    ```powershell
    Set-Mailbox <name_of_affected_mailbox> -CalendarVersionStoreDisabled $false
    ```

## Details

### Trying to delete calendar items by using the MFCMAPI tool

You open the calendar item to delete in [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/), but you see only a limited number of MAPI properties. This condition indicates that the item is corrupted.

In the following screenshot, only 21 properties are displayed for a corrupted calendar item.

:::image type="content" source="media/cannot-delete-calendar-items/mfcmapi.png" alt-text="Screenshot of a Calendar item example showing in MFCMAPI that has 21 MAPI properties." border="false":::

You right-click the item, select **Delete message**, select **Permanent deletion (deletes to deleted item retention if supported)** on the **Deletion style** menu, and then select **OK**, but you receive the following warning message:

> Warning:  
> Code: MAPI_W_PARTIAL_COMPLETION == 0x00040680  
> Function m_IpFolder->DeleteMessages(IpEIDs, IpProgress ? reinterpret_cast\<ULONG_PTR>(m_hWnd) : NULL, IpProgress, uIFlag)  
> File D:\a\1\s\UI\Dialogs\ContentsTable\FolderDlg.cpp  
> Line 678

Alternatively, you select **Permanent delete passing DELETE_HARD_DELETE (unrecoverable)** from the **Deletion style** menu, and then select **OK**, but the tool doesn't respond and the item isn't deleted.

### Trying to delete calendar items by using the EWSEditor tool

You open the calendar item that you want to delete by using the [EWSEditor](https://github.com/dseph/EwsEditor/releases) tool, but you receive the following error message:

> ErrorCode: ErrorContentConversionFailed  
> ErrorMessage: Content conversion failed. Content conversion: Body conversion failed.  

If you select **OK** in the error message, the calendar item is displayed in the tool, but you see either a limited number of properties or no properties for the item, as shown in the following screenshot:

:::image type="content" source="media/cannot-delete-calendar-items/ewseditor.png" alt-text="Screenshot of a Calendar item in EWSEditor that shows no properties.":::

You right-click the item to delete it, but you receive an exception message. The following text is a snippet of the message:

> Exception details:  
> Message: Content conversion failed. Content conversion: Body conversion failed.  
> Type: Microsoft.Exchange.WebServices.Data.ServiceResponseException  
> Source: Microsoft.Exchange.WebServices  
> ErrorCode: ErrorContentConversionFailed  
> ErrorMessage: Content conversion failed. Content conversion: Body conversion failed.

This exception message indicates that the item is corrupted.
