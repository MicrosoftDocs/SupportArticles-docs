---
title: Outlook Search Folders show unexpected mail items with empty subject lines
description: Explains why Outlook search folders may include items with a blank subject from the PersonMetadata folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: gbratton
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
ms.date: 10/30/2023
---

# Outlook Search Folders show unexpected mail items with empty subject lines

When you create a Search Folder for all mail items in Microsoft Outlook 2019, Outlook 2016, Outlook 2013, or Outlook for Microsoft 365, the folder may include unexpected items that have an empty subject line. If you point to these items, the following information is displayed:

> In folder: PersonMetadata

The PersonMetadata folder was created and used by [Outlook Customer Manager (OCM)](https://techcommunity.microsoft.com/t5/outlook-customer-manager/faq-frequently-asked-questions-about-outlook-customer-manager/m-p/29680). Although the OCM service was deprecated in June 2020, Outlook still uses this folder. When new items are created in the Contacts folder or the Recipient Cache folder (a hidden folder under the Contacts folder), related items are created in the PersonMetadata folder.

The PersonMetadata folder is usually hidden from other parts of the Outlook user interface. However, mail items from the PersonMetadata folder may be included in Search Folders. You can identify such items by their empty subject line.

The PersonMetadata folder and the items that are created in it will be removed from the service in the future. In the meantime, you can use either of the following workarounds for this issue.

## Workaround 1

To prevent mail items in the PersonMetadata folder from showing up in your Search Folders, follow these steps:

1. Right-click the Search Folder, and select **Customize This Search Folder**.
2. Select **Browse**, and clear the **Search Subfolders** option.
3. Manually select the folders that you want to include.

## Workaround 2

If you receive a "folder item limit" notification that states that the PersonMetadata folder is approaching the 1-million-item limit, use one of the following methods to delete all the items in the folder.

Folder item limit notification:

:::image type="content" source="media/personmetadata-items/personmetadata-limit-notification.png" alt-text="Screenshot of the folder item limit notification.":::

### Method 1: Run MFCMAPI on the affected user's computer

Use this method if only a few users are experiencing the issue. If there many affected users, use [Method 2](#method-2-run-the-ews-script-as-an-administrator).

1. Exit Outlook.
2. Download the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/) tool.
3. Start the MfcMapi.exe program, and select **OK**.
4. On the **Tools** menu, select **Options**, specify the following options, and then select **OK**:

    - **Use the MDB_Online flag when calling OpenMsgStore**
    - **Use the MAPI_NO_CACHE flag when calling OpenEntry**

5. On the **Session** menu, select **Logon**.
6. In the **Profile Name** list, select the profile for the mailbox, and then select **OK**.
7. Double-click the appropriate **Microsoft Exchange Message Store**. Typically, this is the entry that has the **Default Store = True** setting.
8. In the navigation pane, expand **Root Container**, expand **Top of Information Store**, and select **PersonMetadata**.

    > [!NOTE]
    > The text for the **Top of Information Store** node might be localized in another language, depending on the regional settings of the mailbox.
9. Right-click **PersonMetadata** > **Advanced** > **Empty items and subfolders from folder**.
10. In the **Delete Items and Subfolders** dialog box, select **Hard Deletion** and then select **OK**.

Notice that MFCMAPI may seem to stop responding for an extended time while it performs the delete operation. You can monitor its progress by running the Get-MailboxFolderStatistics cmdlet.

### Method 2: Run the EWS script as an administrator

This method requires you to configure a service account to [impersonate the user](/exchange/client-developer/exchange-web-services/impersonation-and-ews-in-exchange). See this [article](/exchange/client-developer/exchange-web-services/how-to-configure-impersonation) to learn how to configure impersonation.

1. [Download and install the EWS Managed API](https://www.nuget.org/packages/Microsoft.Exchange.WebServices/) on the computer where you will run the EWS script.
2. Download the [EWS script](https://github.com/guruxp/CleanPersonMetadata/raw/main/CleanPersonMetadata.zip).
3. Run the following cmdlet as an administrator to install the latest Exchange Online PowerShell management module:

    ```powershell
    Install-Module ExchangeOnlineManagement
    ```

4. Run the following cmdlet to empty the PersonMetadata folder for a unique user:

    ```powershell
    .\CleanPersonMetadata.ps1 -Identity user@contoso.com
    ```

    This cmdlet hard deletes the contents (items are not moved to Deleted Items). If you want to simulate the deletion before you commit to it, use the `-WhatIf` parameter.

    To run the script against several users, create a CSV file that contains an **Identity** column and that has the SMTP addresses of those users. Then, run the following cmdlet:

    ```powershell
    Import-CSV UserList.csv | .\CleanPersonMetadata.ps1 -Confirm:$false
    ```

    **Note**: If you get an error that the module cannot be found, you need to update the script to match the file path to the module. The script currently has the following path:

    `Import-Module "C:\Program Files\WindowsPowerShell\Modules\ExchangeOnlineManagement\<module_version>\Microsoft.IdentityModel.Clients.ActiveDirectory.dll" -force`

    Update the path in the script at line #639 as follows:

    `Import-Module "C:\Program Files\WindowsPowerShell\Modules\ExchangeOnlineManagement\<module_version>\netFramework\Microsoft.IdentityModel.Clients.ActiveDirectory.dll" -force`

5. When you're prompted, enter the credentials of the service account that you configured for impersonation.
