---
title: Folder names are incorrect or displayed in an incorrect language in Outlook
description: Fixes an issue in which folder names are displayed in an incorrect language or folder functionality is incorrect in Outlook.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook 2013
- Outlook 2010
- Microsoft Office Outlook 2007
- Exchange Online
- Microsoft Exchange Online Dedicated
---

# Folder names are incorrect or displayed in an incorrect language in Outlook

## Symptoms

You experience the following issues that affect folder names in Microsoft Outlook: 

- Folder names appear in a language other than the default language.

    > [!NOTE]
    > This issue occurs if a mobile device or a third-party server application synchronizes the Exchange Server mailbox. To resolve this issue, try Method 1 first. If that doesn't work, try Method 2 or 3.    
- Folder names are changed unexpectedly (for example, the **Inbox **folder and the **Outbox **folder are switched).

    > [!NOTE]
    > This issue may occur after Exchange Server mailbox maintenance. To resolve this issue, try Method 1 first. If that doesn't work, try Method 2 or 3.

    Or, the default **Inbox** folder is changed unexpectedly to **Archive** in Exchange Online. To resolve this issue, try Method 4.     
- Folder names are no longer correct after you run the **Outlook.exe /ResetFolderNames** command to reset the default folder names.

    > [!NOTE]
    > To resolve this issue, try Method 2 or 3.    
For more information, see [Command-line switches for Outlook for Windows](https://support.office.com/article/Command-line-switches-for-Outlook-for-Windows-079164CD-4EF5-4178-B235-441737DEB3A6).  

## Resolution

To fix the issues, use one or more of the following methods. 

### Method 1
 
Use the **/resetfolders** switch to restore missing folders at the default delivery location. To do this, follow these steps:

1. Exit Outlook.    
2. Open the **Run** dialog box:  
   - In Windows 10, Windows 8.1, and Windows 8, press Windows logo key + R.    
   - In Windows 7 and Windows Vista, click **Start** > **All Programs** > **Accessories** > **Run**.    
     
3. In the **Run** dialog box, enter the following command, and then click **OK**:    
 
    ```powershell
    Outlook.exe /resetfolders
    ```
### Method 2
 
Use Outlook Web App to reset the default folder names:

1. Exit Outlook.    
2. Log on to [Outlook Web App](https://support.office.com/article/Sign-in-to-Outlook-Web-App-e08eb8ac-ac27-49f4-a400-a47311e1ee7e) by using your credentials.    
3. Select **Settings** (the gear icon on the right) > **Options **> **General** (expand the list in the navigation pane) > **Region and time zone**.
4. On the **Regional and time zone settings** page, change the language, select the date and time format that you want to use, select the **Rename default folders so their names match the specified language** option, and then select **Save**.    
5. Exit Outlook Web App.

    > [!NOTE]
    > If your preferred language is already selected, you may have to select any other language, save the setting, reset the setting to your preferred language, and then save the setting again.    
6. Restart Outlook.

 
### Method 3
 
If you are an administrator, run the following cmdlet to reset the default folder names for the user:   

```powershell
set-MailboxRegionalConfiguration -id <**alias**> -LocalizeDefaultFolderName:$true -Language <**Language_code_to_switch_to**> -DateFormat <**your_preferred_DateFormat**>
```
   
For more information about the possible language codes and the **Set-MailboxRegionalConfiguration** cmdlet, see the following MSDN websites: 
 
- [Language Codes](https://msdn.microsoft.com/library/ms533052%28v=vs.85%29.aspx)
- [Set-MailboxRegionalConfiguration](https://msdn.microsoft.com/subscriptions/dd351103%28v=exchg.141%29.aspx)

### Method 4

**Option 1 (preferred)** 

Use Outlook to select a new Archive folder. To do this, follow these steps:  
 
1. Right-click the mailbox name at the top of the folder hierarchy in Outlook, select **New Folder**, and then create a folder that’s named **Archive01**.    
2. On the **File** menu, select **Tools** > **Set Archive Folder**, and then select the new Archive01 folder.    
3. Run the **Outlook.exe /resetfoldernames** command.    
 
If this option is not available or does not work, use Option 2.

**Option 2** 

Follow these steps:  
 
1. Right-click the mailbox name at the top of the folder hierarchy in Outlook, select **New Folder**, and then create a folder that’s named **Archive01**.    
2. Start MFCMapi in Online mode. To make sure that MFCMapi is in Online mode, select **Tools** > **Options**, and then make sure that the **Use the MDB_ONLINE flag** and **Use the MAPI_NO_CACHE** check boxes are selected.    
3. Expand **Root Container**, and then expand **Top of Information Store**.    
4. Select the new Archive01 folder, and then find the property that's named **PR_ENTRYID**.  
5. Double-click to open the **PR_ENTRYID** property, and then copy the property value.    
6. Select the Archive folder (this should be the Inbox folder), and then double-click to open the **0x35FF0102 **property tag. This is the Archive Entry ID.    
7. Paste the value of the Entry ID of the Archive01 folder that you copied in step 5.    
8. Run **Outlook.exe /resetfolders**.    
9. Run **Outlook.exe /resetfoldernames**.    
