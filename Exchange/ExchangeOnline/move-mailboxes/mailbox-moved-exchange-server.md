---
title: Your mailbox has been temporarily moved to Microsoft Exchange server
description: Describes an issue that triggers a 'Your mailbox has been temporarily moved to Microsoft Exchange server" message when an Office 365 user opens Outlook. Provides workarounds.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: v-six
---

# "Your mailbox has been temporarily moved to Microsoft Exchange server" message when an Office 365 user opens Outlook

## Problem 

When an Office 365 user opens Microsoft Outlook, the user receives the following message:

**Your mailbox has been temporarily moved to Microsoft Exchange server.**
 
**A temporary mailbox exists, but might not have all of your previous data.** 

**You can connect to the temporary mailbox or work offline with all of your old data.** 

**If you choose to work with your old data, you cannot send or receive e-mail messages.**

> [!IMPORTANT]
> Do notchoose to connect to the temporary mailbox. This may cause data loss.

## Workaround 

To work around this issue, use one of the following methods. Try Method 1 first. If that doesn't resolve the issue, go to Method 2. 

Important When you remove a profile in Outlook, the data files for the accounts in the profile will also be removed. Make sure that you back up the information unless the data is stored on the server or you're completely sure that you don't need the data that's in the file.

### Before you begin

If the user has a profile that connects though POP or IMAP or has any .pst files, back up those data files before you follow the steps in this article. 
For more information, see [Export or back up email, contacts, and calendar to an Outlook .pst file](https://support.office.com/article/export-or-backup-email-contacts-and-calendar-to-an-outlook-pst-file-14252b52-3075-4e9b-be4e-ff9ef1068f91?).

### Method 1: Remove all Outlook profiles except the user's primary profile

1. Exit Outlook.    
2. In Control Panel, click or double-click **Mail**. 

    > [!NOTE]
    > To locate the Mail item, open Control Panel, and then in the search box at the top of window, type Mail.    
3. Click **Show Profiles**.   
4. In the **Mail** dialog box, select the profile that you want to remove, and then click **Remove**. 
5. The following warning message is displayed:

    **Careful, if you remove this profile, offline cached contents for its accounts will be deleted. Learn how to make a backup of the offline .ost files for the accounts.**
    
    **Do you want to continue?**

    Here's a screen shot of the warning message: 
    
    ![Screen shot of warning message ](https://support.microsoft.com/Library/Images/3205046.jpg)
    
    After you read the warning and back up the .ost files, click **Yes** to continue.   
6. Repeat step 4 and step 5 for all other Outlook profiles except the user's primary profile.   
7. After you remove all other Outlook profiles except the user's primary profile, click **OK **in the **Mail** dialog box to close it.   
8. Start Outlook.    
If these steps don't resolve the issue, go to Method 2.

### Method 2: Create a new Outlook profile and then remove the user's original Outlook profile

1. Exit Outlook.    
2. In Control Panel, click or double-click **Mail**. 

    To locate the Mail item, open Control Panel, and then in the search box at the top of window, type Mail.    
3. Create a new Outlook profile, and then remove the user's original profile. To do this, follow these steps:
   1. Click **Show Profiles**, and then click **Add**.   
   2. Specify a name for the profile, and then click **OK**.   
   3. Follow the steps in the Add Account wizard to add the user's email account. When you're finished, click **Finish.**   
   4. In the **Mail** dialog box, select the user's original Outlook profile that you want to remove, and then click **Remove**.   
   5. The following warning message is displayed:

    **Careful, if you remove this profile, offline cached contents for its accounts will be deleted. Learn how to make a backup of the offline .ost files for the accounts.**
    
    **Do you want to continue?**
    
    Here's a screen shot of the warning message: 
    
    ![Screen shot of warning message ](https://support.microsoft.com/Library/Images/3205046.jpg)
    
    After you read the warning and back up the .ost files, click **Yes** to continue.   
   
4. In the **Mail** dialog box, make sure that the **Always use this profile option** is selected, select the new Outlook profile that you created, and then click **OK**.

    ![Screen shot of the Mail dialog box, showing the Always use this profile option with the new profile selected ](https://support.microsoft.com/Library/Images/3205047.jpg)   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).