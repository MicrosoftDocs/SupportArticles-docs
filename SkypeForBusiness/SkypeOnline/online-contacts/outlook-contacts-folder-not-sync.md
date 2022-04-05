---
title: Outlook SFB Contacts folder doesn't sync with Skype for Business contacts
description: Summarizes an issue in which the Outlook Skype for Business Contacts folder doesn't sync with Skype for Business contacts. Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: ramesa, dahans, randw
ms.custom: CSSTroubleshoot
appliesto: 
  - Skype for Business Online
ms.date: 3/31/2022
---

# Outlook Skype for Business "Contacts" folder doesn't sync with Skype for Business contacts

## Problem

Consider the following scenarios:

- You add a new Skype for Business contact. But the contact doesn't appear in the Outlook Skype for Business Contacts folder.   
- You remove a contact from Skype for Business. However, the contact isn't removed from the Outlook Skype for Business Contacts folder.   
- The Outlook Skype for Business Contacts folder contains stale contact information (it isn't updating). This stale data may still sync to Skype for Business contacts.   

In these scenarios, the Outlook Skype for Business (formerly Lync) Contacts folder doesn't sync with your Skype for Business contacts as the folder previously did.

## Workaround

To work around this issue, you can remove the contacts in the Outlook Skype for Business Contacts folder (but not the Contacts folder itself). To do this, follow these steps.

> [!NOTE]
> The steps to remove the contacts in the Contacts folder should only be performed by an administrator. After the following steps are performed, the Contacts folder will remain, but the contacts won't. And the contacts will no longer cause stale information to replicate.

1. Download and install MFCMapi from the following Microsoft website: [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/).
2. Close Skype for Business and Microsoft Outlook.   
3. Open MFCMapi. If you're prompted, click **OK** on the usage notes box. 

    :::image type="content" source="./media/outlook-contacts-folder-not-sync/mfc-mapi-notes-box.png" alt-text="Screenshot that shows the M F C Mapi usage notes box.":::

4. From the **Tools** menu, select **Options** .

    :::image type="content" source="./media/outlook-contacts-folder-not-sync/tools-options.png" alt-text="Screenshot that shows the Options selected under the Tools menu.":::
5. In the **Options** dialog box, click to select **Use the MAPI_NO_CACHE flag when calling OpenEntry** and **Use the MDB_ONLINE flag when calling OpenMsgstore**, and then click **OK**.

    :::image type="content" source="./media/outlook-contacts-folder-not-sync/select-two-options.png" alt-text="Screenshot that shows two target options selected in the Options dialog box.":::

6. To start a session, select **Logon** from the **Session** menu.

    :::image type="content" source="./media/outlook-contacts-folder-not-sync/session-logon.png" alt-text="Screenshot that shows the logon tab selected on the Session menu.":::

7. In the **Choose Profile** box, type or click the arrow to select the name of the Outlook profile for the affected user, and then click **OK**.

    :::image type="content" source="./media/outlook-contacts-folder-not-sync/choose-profile.png" alt-text="Screenshot that shows the Choose Profile window.":::
8. In the window that opens, right-click the default Exchange mailbox store in the list, and then click **Open store**.

    :::image type="content" source="./media/outlook-contacts-folder-not-sync/open-store.png" alt-text="Screenshot that shows the Open store tab selected in the list.":::
9. In the left column, locate and click to expand **Root Container**, expand **Top of Information Store**, and then expand **Contacts**.

   :::image type="content" source="./media/outlook-contacts-folder-not-sync/expand-contacts.png" alt-text="Screenshot that shows Root Container selected to expand Contacts.":::
10. Locate and right-click **Skype for Business Contacts**. Then select **Open contacts table**.

    :::image type="content" source="./media/outlook-contacts-folder-not-sync/open-contacts-table.png" alt-text="Screenshot that shows the Open contacts table option selected after right-clicking Skype for Business Contacts.":::
11. To delete the contacts in the list, hold down the Ctrl key, and then click to select the individual contacts.

    :::image type="content" source="./media/outlook-contacts-folder-not-sync/delete-contacts.png" alt-text="Screenshot that shows the target contacts selected in the list.":::
12. From the **Actions** menu, select **Delete Messages**.

    :::image type="content" source="./media/outlook-contacts-folder-not-sync/delete-message.png" alt-text="Screenshot that shows the Delete Messages option selected from the Actions menu.":::
13. In the **Delete Item** dialog box, locate the **Deletion style** drop-down list, select **Permanent deleted passing DELETE_HARD_DELETE (unrecoverable)**, and then click **OK**.

     :::image type="content" source="./media/outlook-contacts-folder-not-sync/deletion-style.png" alt-text="Screenshot that shows the Permanent deleted option selected in the Delete Item dialog box.":::
14. To close all the windows, select **Exit** from the **Actions** menu.
 
     ![Action menu ](./media/outlook contacts-folder-n t-sync/exit jpg)   

     :::image type="content" source="./media/outlook-contacts-folder-not-sync/exit.png" alt-text="Screenshot that shows the Exit option selected from the Actions menu":::


## More Information

This behavior is by design. The sync between the Outlook Skype for Business Contacts folder and the Skype for Business contacts is deprecated. 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com). 