---
title: You can't successfully dismiss calendar reminders in Outlook
description: Describes an issue that prevents you from dismissing calendar reminders in Outlook. Provides a resolution.
author: simonxjx
audience: ITPro
ms.prod: exchange-server-it-pro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
- Outlook 2019
- Outlook 2016
- Outlook 2013
---

# You can't successfully dismiss calendar reminders in Outlook

## Symptoms

When you try to dismiss calendar reminders in Microsoft Outlook, you discover that they can't be dismissed or that they keep reappearing.

## Cause

This issue occurs when the Reminders folder or the reminder view is corrupted.

## Resolution

To resolve this issue, use one or both of the following methods.

### Method 1
 
Run the following command-line switch to delete the item:

```powershell
outlook.exe /cleanreminders 
```

If this method doesn’t resolve the issue, go to Method 2.

### Method 2
 
Delete the Reminders folder by using the Microsoft Exchange Server MAPI Editor (MFCMAPI). To do this, follow these steps: 
 
1. Download **MFCMAPI** from [github](https://github.com/stephenegriffin/mfcmapi) (scroll down and then click **Latest release**).    
2. Exit Outlook.    
3. Open MFCMAPI.    
4. On the **Tools** menu, click **Options**, select both of the following check boxes (if they're not already selected), and then click **OK**:  
   - **Use the MDB_ONLINE flag when calling OpenMsgStore**    
   - **Use the MAPI_NO_CACHE flag when calling OpenEntry**    
     
5. Click **Session**, click **Logon**, select the profile that you want to change, and then click **OK**.    
6. Double-click the mailbox store that you want to open.    
7. Expand **Root Container**.    
8. Right-click the **Reminders** folder, and then click **Delete folder**.

    > [!NOTE]
    > Do not delete the individual items inside the Reminders folder. The Reminders folder is just a view of upcoming events on the calendar. If the items inside the folder are deleted, those items will be removed from the calendar.    
9. Run the **Outlook.exe /cleanreminders** or **Outlook.exe /ResetFolders** command line. (This step re-creates the Reminders folder and adds any valid entries back in.)    
