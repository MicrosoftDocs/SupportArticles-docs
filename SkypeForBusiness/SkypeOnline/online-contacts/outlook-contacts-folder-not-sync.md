---
title: Outlook SFB Contacts folder doesn't sync with Skype for Business contacts
description: Summarizes an issue in which the Outlook Skype for Business Contacts folder doesn't sync with Skype for Business contacts. Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.reviewer: ramesa, dahans, randw
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# Outlook Skype for Business "Contacts" folder doesn't sync with Skype for Business contacts

## Problem

Consider the following scenarios:

- You add a new Skype for Business contact. But the contact doesn't appear in the Outlook Skype for Business Contacts folder.   
- You remove a contact from Skype for Business. However, the contact isn't removed from the Outlook Skype for Business Contacts folder.   
- The Outlook Skype for Business Contacts folder contains stale contact information (it isn't updating). This stale data may still sync to Skype for Business contacts.   

In these scenarios, the Outlook Skype for Business (formerly Lync) Contacts folder doesn't sync with your Skype for Business contacts as the folder previously did.

## Workaround

To work around this issue, you can remove the contacts in the Outlook Skype for Business Contacts folder (but not the Contacts folder itself). To do this, follow these steps.

> [!NOTE]
> The steps to remove the contacts in the Contacts folder should only be performed by an administrator. After the following steps are performed, the Contacts folder will remain, but the contacts won't. And the contacts will no longer cause stale information to replicate.

1. Download and install MFCMapi from the following Microsoft website: [MFCMAPI](https://mfcmapi.codeplex.com).
2. Close Skype for Business and Microsoft Outlook.   
3. Open MFCMapi. If you're prompted, click **OK** on the usage notes box. 

    ![MFCMapi ](./media/outlook-contacts-folder-not-sync/mfcmapi.jpg)

4. From the **Tools** menu, select **Options** .

    ![Tools menu ](./media/outlook-contacts-folder-not-sync/tools-options.jpg)   
5. In the **Options** dialog box, click to select **Use the MAPI_NO_CACHE flag when calling OpenEntry** and **Use the MDB_ONLINE flag when calling OpenMsgstore**, and then click **OK**.

    ![Options window ](./media/outlook-contacts-folder-not-sync/select-two-options.jpg)   
6. To start a session, select **Logon** from the **Session** menu.

    ![Logon window ](./media/outlook-contacts-folder-not-sync/settion-logon.jpg)   
7. In the **Choose Profile** box, type or click the arrow to select the name of the Outlook profile for the affected user, and then click **OK**.

    ![Choose Profile window ](./media/outlook-contacts-folder-not-sync/choose-profile.jpg)   
8. In the window that opens, right-click the default Exchange mailbox store in the list, and then click **Open store**.

    ![Mailbox store view ](./media/outlook-contacts-folder-not-sync/open-store.jpg)   
9. In the left column, locate and click to expand **Root Container**, expand **Top of Information Store**, and then expand **Contacts**.

   ![Root container view ](./media/outlook-contacts-folder-not-sync/expand-contacts.jpg)   
10. Locate and right-click **Skype for Business Contacts**. Then select **Open contacts table**.

    ![Skype for Business Contacts view ](./media/outlook-contacts-folder-not-sync/open-contacts-table.jpg)   
11. To delete the contacts in the list, hold down the Ctrl key, and then click to select the individual contacts.

    ![Selecting contacts view ](./media/outlook-contacts-folder-not-sync/delete-contacts.jpg)   
12. From the **Actions** menu, select **Delete Messages**.

    ![Actions menu ](./media/outlook-contacts-folder-not-sync/delete-message.jpg)   
13. In the **Delete Item** dialog box, locate the **Deletion style** drop-down list, select **Permanent deleted passing DELETE_HARD_DELETE (unrecoverable)**, and then click **OK**.

     ![Hard delete window ](./media/outlook-contacts-folder-not-sync/deletion-style.jpg)  
14. To close all the windows, select **Exit** from the **Actions** menu.

     ![Action menu ](./media/outlook-contacts-folder-not-sync/exit.jpg)   


## More Information

This behavior is by design. The sync between the Outlook Skype for Business Contacts folder and the Skype for Business contacts is deprecated. 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).