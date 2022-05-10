---
title: Unable to delete calendar items
description: Users can't delete corrupted calendar items in Outlook and admins also can't delete the items using the MFCMAPI or EWSEditor tool.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 161181
  - CSSTroubleshoot
ms.reviewer: nourdinb
appliesto: 
  - Exchange Server 2013
  - Exchange Server 2016
  - Exchange Server 2019
search.appverid: MET150
ms.date: 5/10/2022
---
# Can't delete calendar items in Outlook

## Symptoms

You're an administrator of an organization that has Microsoft Exchange Server deployed. In the organization, when a user tries to delete a calendar item in Microsoft Outlook online mode, the user receives the following error message:

> The move, copy, or deletion cannot be completed. The items might have been moved or deleted, or you may not have sufficient permission. If the item was sent as a task request or meeting request, the sender might not receive updates.  

If the user tries to delete the item in Outlook cached mode, the item can't be deleted without any error message.

Additionally, you can't delete the item for the affected user by using the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/) or [EWSEditor](https://github.com/dseph/EwsEditor/releases) tool with the following errors:

### Errors in the MFCMAPI tool

When you use the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/) tool to open the affected user's mailbox in online mode, you see that the item has a limited number of MAPI properties. In the following example, there are only 21 properties:

:::image type="content" source="media/cannot-delete-calendar-items/item-in-mfcmapi.png" alt-text="Screenshot of a Calendar item example showing in MFCMAPI, which has 21 MAPI properties.":::

Then, when you right-click the item and select **Permanent deletion (deletes to deleted item retention if supported)**, you receive the following warning message:

> Warning:  
> Code: MAPI_W_PARTIAL_COMPLETION == 0x00040680  
> Function m_IpFolder->DeleteMessages(IpEIDs, IpProgress ? reinterpret_cast\<ULONG_PTR>(m_hWnd) : NULL, IpProgress, uIFlag)  
> File D:\a\1\s\UI\Dialogs\ContentsTable\FolderDlg.cpp  
> Line 678

If you right-click the item and select **Permanent delete passing DELETE_HARD_DELETE (unrecoverable)**, there is no change and the item isn't deleted.  

### Errors in the EWSEditor tool

When you use the [EWSEditor](https://github.com/dseph/EwsEditor/releases) tool to open the affected user's calendar, you receive the following error message:

> ErrorCode: ErrorContentConversionFailed  
> ErrorMessage: Content conversion failed. Content conversion: Body conversion failed.  

If you ignore this error message and select **OK** to proceed, you see that the item has a limited number of properties. In the following example, there is no property for the item.

:::image type="content" source="media/cannot-delete-calendar-items/item-in-ewseditor.png" alt-text="Screenshot of a Calendar item example showing in EWSEditor, which has no properties.":::

When you right-click the item to delete it, you receive the following exception message:

> Exception details:  
> Message: Content conversion failed., Content conversion: Body conversion failed.  
> Type: Microsoft.Exchange.WebServices.Data.ServiceResponseException  
> Source: Microsoft.Exchange.WebServices  
> ErrorCode: ErrorContentConversionFailed  
ErrorMessage: Content conversion failed. Content conversion: Body conversion failed.

## Cause

This issue occurs because the calendar item is corrupted. When a user modifies or deletes a calendar item, Exchange copy-on-write feature is triggered and creates a copy of the item in the Calendar Logging folder, which is also known as CalendarVersionStore. Because of the item corruption, the feature is triggered but can't execute properly. In this scenario, an exception is raised, which will prevent the deletion from succeeding.

## Resolution

To resolve this issue, prevent the calendar change in the affected user's mailbox from being logged and then delete the item.  

1. Run the following cmdlet to set the value of the `CalendarVersionStoreDisabled` parameter to true for the affected user's mailbox.

    ```powershell
    Set-Mailbox <user@contoso.com> -CalendarVersionStoreDisabled $true 
    ```

2. Wait for the database store configuration cache to expire. It's expected to take two hours. If you don't want to wait, use one of the following options:  

    1. Restart the Exchange Information Store service.
    2. Active the affected user's database on another Exchange server.  

    **Note:** The two options will cause service interruptions to the affected users of on the server or database.

3. Delete the calendar item again.

    **Note:** We recommend that you use the MFCMAPI tool to delete the item.

4. Run the following cmdlet to revert the `CalendarVersionStoreDisabled` parameter value to the original state (false).

    ```powershell
    Set-Mailbox <user@contoso.com> -CalendarVersionStoreDisabled $false
    ```
