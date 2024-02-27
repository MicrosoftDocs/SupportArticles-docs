---
title: How to manage .pst files in Microsoft Outlook
description: Describes how to back up Outlook data. This includes how to back up, export, import personal folders (.pst) file data. Also describes how to back up Personal Address Books, Outlook Settings Files and data on an Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz
appliesto: 
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 01/30/2024
---
# How to manage .pst files in Microsoft Outlook

_Original KB number:_ &nbsp; 287070

## Summary

This article describes how to use personal storage folders, also known as .pst files, to back up data that you created in Microsoft Outlook 2010, Microsoft Office Outlook 2007, Microsoft Office Outlook 2003, and Microsoft Office Outlook 2002. You can back up messages, contacts, appointments, tasks, notes, and journal entries in .pst files.

> [!NOTE]
>
> - If you use a different email program, such as Microsoft Outlook Express or Outlook.com, or if you have problems with the functionality of your email program, this article is not intended for you. See the "References" section for links to other articles and suggestions for solutions.
> - For versions of Outlook newer than Outlook 2010, see [Find and transfer Outlook data files from one computer to another](https://support.microsoft.com/office/find-and-transfer-outlook-data-files-from-one-computer-to-another-0996ece3-57c6-49bc-977b-0d1892e2aacc).
> - Moving a .pst file to a network share is not supported. For more information, see [Limits to using personal folders files over LAN and WAN links](limits-using-pst-files-over-lan-wan.md).

Microsoft Outlook automatically stores messages, contacts, appointments, tasks, notes, and journal entries in one of the following two locations:

- In a personal storage folder, also known as a .pst file, on your computer.
- In a mailbox that is located on the server. Your mailbox is located on a server if you use Outlook with Microsoft Exchange Server.

You can use a backup of your .pst file to restore or move your Outlook data if you experience a hardware failure, lose data unexpectedly, have to transfer data from one computer to another computer, or have to transfer data from one hard disk drive to another hard disk drive.

## Managing your .pst file

Select an action from the following list:

### How to locate a .pst file

If you do not know where an old or existing .pst file resides on your computer or you want to add a .pst file to your Outlook profile, use the following steps:

1. To search for the .pst files:
   - Windows 10 or Windows 7: Select the icon labeled **Type here to search** in the taskbar.
   - Windows 2000 or Microsoft Windows Millennium Edition: Select **Start**, point to **Search**, and then select **For Files or Folders**.
   - Windows Vista: Select **Start**, and then select **Computer**. Locate the search window in the upper-right corner.
   - Windows XP: Select **Start**, and then select **Search**.
   - Windows 95 or Windows 98: Select **Start**, point to **Find**, and then select **Files or Folders**.
2. Type **.pst*, and then press Enter or select **Find Now**. Locate the desired .pst file that you want to add to Outlook. Record the location of the .pst file.
3. Close the search window and start Outlook.
   - If you are running Outlook 2010, select the **File** tab, and then select **Account Settings** in the **Info** category. Select **Account Settings** again, and then select the **Data Files** tab in the window that appears.
   - If you are running Outlook 2007 or earlier, select the **File** menu, and then select **Data File Management**.
4. Select the **Add** button, and then select the correct kind of .pst file to add:
   - If your .pst file was created in Outlook 2007, select **Office Outlook Personal Folders File (.pst)**.
   - If your .pst file was created in an older version of Outlook, such as Outlook 97, 2000, or XP, select **Outlook 97-2002 Personal Folders File (.pst)**.
5. Locate the desired .pst file that you found during your search. Select the .pst file, and then select **OK**.
6. Type a custom name for the .pst file or accept the default name. Select **OK**. Select **Close** to exit the active window.

Outlook now displays that .pst file in the Outlook folder list.

### How to make a backup copy of a .pst file

If you do not use Outlook with Microsoft Exchange Server, Outlook stores all its data in a .pst file. You can use the backup copy to restore your Outlook data if the original .pst file is damaged or lost. This section explains how to create a copy of your whole .pst file, with all the default items in the file.
Follow these steps to back up the whole .pst file:

1. Close any messaging programs such as Outlook, Microsoft Exchange, or Microsoft Windows Messaging.
2. Select **Start**, and then select **Run**. Type *control panel* in the **Open** box, and then press Enter to open **Control Panel**.

    > [!NOTE]
    > If you see the **Pick a category** screen, click **User Accounts**, and then continue to step 3 .

3. Double-click the **Mail** icon.
4. Select **Show Profiles**.
5. Select the appropriate profile, and then select **Properties**.
6. Select **Data Files**.
7. Under **Name**, select the **Personal Folders Service** that you want to back up. By default, this service is called **Personal Folders**. However, it may be named something else.

    > [!NOTE]
    >
    > - If you have more than one Personal Folders Service in your profile, you must back up each set of .pst files separately.
    > - If there are no entries called **Personal Folders** and you have not yet stored any information such as messages, contacts, or appointments in Outlook, you probably have not yet enabled the Personal Folders Service. Move to the "References" section for information about how to create a .pst file.
    > - If you have no **Personal Folders Services** in your profile and you can store information such as messages, contacts, or appointments in Outlook, your information is probably being stored in a mailbox on an Exchange Server. Try using the instructions in the [How to back up .pst file data that is located on a Microsoft Exchange Server](#how-to-back-up-pst-file-data-that-is-located-on-a-microsoft-exchange-server) section.

8. Select **Settings**, and then note the path and file name that appears.

    > [!NOTE]
    > Because the .pst file contains all data that is stored in the MAPI folders that Outlook uses, the file can be very large. To reduce the size of the .pst file, select **Compact Now** in the **Settings** window .

9. Close all the **Properties** windows.

10. Use **Windows Explorer** or **My Computer** to copy the file that you noted in step 8. You can copy the file to another location on the hard disk drive or to any kind of removable storage media, such as a floppy disk, a CD-ROM, a portable hard disk drive, a magnetic tape cassette, or any other storage device.

### How to back up .pst file data that is located on a Microsoft Exchange Server

If you use Outlook with a Microsoft Exchange Server, you must know where the data is stored in order to back it up. The default delivery and storage location for Outlook data is the Exchange Server mailbox. The Exchange Server administrator typically handles backups of the mailboxes on the server. However, some Exchange Server administrators store Outlook data in a .pst file on your computer.

Follow these steps to find where Outlook is currently storing your data:

**In Outlook 2010:**

1. Select the **File** tab on the Outlook ribbon.
2. In the **Info** category, select the **Account Settings** button, and then select **AccountSettings**.
3. In the **Account Settings** window, select the **Data Files** tab.

> [!NOTE]
>
> - If the **Location** field contains the word **Online** or a path to a file that has the file name extension .ost, Outlook stores data in folders on the Exchange Server. Contact the Exchange Server administrator for more information about how backups are handled.
> - If the **Location** field contains a path to a file that has the file name extension .pst, Outlook stores new messages, contacts, appointments, and other data in a .pst file on your hard disk. To back up the data, see the [How to make a backup copy of a .pst file](#how-to-make-a-backup-copy-of-a-pst-file) section.

**In Outlook 2007:**  

1. On the **Tools** menu, select **Options**, select the **Mail Setup** tab, and then select **Email Accounts**.
2. In the **Account Settings** window, select the **Data Files** tab.

> [!NOTE]
>
> - If the **Name** field contains the word "Mailbox" followed by an email name, Outlook stores data in folders on the Exchange Server. Contact the Exchange Server administrator for more information about how backups are handled.
> - If the field contains the words "Personal Folder" or the name of a set of personal folders or .pst files, Outlook stores new messages, contacts, appointments, and other data in a .pst file on your hard disk. To back up the data, go to the "How to make a backup copy of a .pst file" section.

**In an earlier version of Outlook:**

1. On the **Tools** menu, select **Email Accounts**.

    > [!NOTE]
    > This option might be unavailable on some networks. The network administrator might have removed this option to protect the account information. If you do not see the Email Accounts option, contact the network administrator for help.

2. Select **View or Change Existing Email Accounts**, and then select **Next**.

3. Look at the Deliver new email to the following location option. If the option contains the word **Mailbox** followed by an email name, Outlook stores data in folders on the Exchange Server. Contact the Exchange Server administrator for more information about how backups are handled.

> [!NOTE]
> If the field contains the words **Personal Folder** or the name of a set of personal folders or .pst files, Outlook stores new messages, contacts, appointments, and other data in a .pst file on your hard disk. To back up the data, go to the [How to make a backup copy of a .pst file](#how-to-make-a-backup-copy-of-a-pst-file) section.  

### How to export .pst file data

If you want to back up only a part of your Outlook data, you can create a new backup .pst file of only the data that you want to save. This is also known as exporting .pst file data. For example, you might want to use this section if you have important information in only some folders and you have other, less important items in much larger folders. You can export only the important folders or contacts and omit folders such as Sent Mail.

**In Outlook 2010:**

Use the following steps to export a specific folder:

1. Select the **File** tab.
2. In the **Outlook Options** window, select **Advanced**.
3. Select **Export**.
4. In the **Import and Export Wizard**, select **Export to a file**, and then select **Next**.
5. Select **Outlook Data File (.pst)**, and then select **Next**.
6. Select the folder to export, and then select **Next**.
7. Select **Browse**, and then select the location where you want the new .pst file to be saved.
8. In the **File Name** box, type the name that you want to use for the new .pst file, and then select **OK**.
9. Select **Finish**.

**In an earlier version of Outlook:**

1. Open Outlook.
2. On the **File** menu, select **Import And Export**. If the command is not available, move your pointer over the chevrons at the bottom of the menu, and then select **Import and Export**.
3. Select **Export To File**, and then select **Next**.
4. Select **Personal Folder File (.pst)**, and then select **Next**.
5. Select the folder where you want to export the .pst file and then select **Next**.
6. Select **Browse**, and then select the location where you want the new .pst file to be saved.
7. In the **File Name** box, type the name that you want to use for the new .pst file, and then select **OK**.
8. Select **Finish**.

> [!NOTE]
> Folder design properties include permissions, filters, description, forms, and views. If you export items from one .pst file to another, no folder design properties are maintained.

### How to import .pst file data into Outlook

You can use the backup copy of your .pst file to restore your Outlook data if the original .pst file is damaged or lost. Everything that is saved in the .pst file is returned to Outlook.

**In Outlook 2010:**

Use the following steps to restore, or import, your data into Outlook:

1. Select the **File** tab.
2. In the **Open** category, select **Import**.
3. In the **Import and Export Wizard**, select **Import from another program or file**, and then select **Next**.
4. Select **Outlook Data File (.pst)**, and then select **Next**.
5. Type the path and the name of the .pst file that you want to import, or select **Browse** to select the file to import.

    > [!NOTE]
    > Under **Options**, we recommended that you select **Do not import duplicates**, unless you want the imported information to replace or duplicate items that are already in Outlook .

6. Select **Next**.
7. Select the folder that you want to import. To import everything in the .pst file, select the top of the hierarchy.

    > [!NOTE]
    > The top folder (usually **Personal Folders**, **Outlook Data File**, or your email address) is selected automatically. **Include subfolders** is selected by default. All folders under the folder selected will be imported.

8. Select **Finish**.

**In earlier versions of Outlook:**

Follow these steps to restore, or import, your data into Outlook:

1. If the .pst file that you want to import is stored on a removable device, such as a floppy disk, a portable hard disk drive, a CD-ROM, a magnetic tape cassette, or any other storage medium, insert or connect the storage device, and then copy the .pst file to the hard disk drive of the computer.

   When you copy the .pst file, make sure that the **Read-Only** attribute is not selected. If this attribute is selected, you might receive the following error message:

    > The specified device, file, or path could not be accessed. It may have been deleted, it may be in use, you may be experiencing network problems, or you may not have sufficient permission to access it. Close any application that uses this file and try again.

    If you receive this error message, clear the Read-Only attribute, and then copy the file again.

2. Open Outlook.
3. On the **File** menu, select **Import And Export**. If the command is not available, move the pointer over the chevrons at the bottom of the menu, and then select **Import and Export**.

4. Select **Import from another program or file**, and then select **Next**.
5. Select **Personal Folder File (.pst)**, and then select **Next**.
6. Type the path and the name of the .pst file that you want to import, and then select **Next**.
7. Select the folder that you want to import. To import everything in the .pst file, select the top of the hierarchy.
8. Select **Finish**.  

### How to transfer Outlook data from one computer to another computer

You cannot share or synchronize .pst files between one computer and another computer. However, you can still transfer Outlook data from one computer to another computer.

Use the instructions in the "How to make a backup copy of a .pst file" section to copy the .pst file to a CD or DVD-ROM or other portable media, or copy the file to another computer over a LAN/WAN link.

> [!NOTE]
> Connecting to .pst files over LAN/WAN links is not supported, and problems connecting to .pst files over such links can occur. See [Limits to using personal folders files over LAN and WAN links](limits-using-pst-files-over-lan-wan.md).

You might also want to create a new, secondary .pst file that is intended for transferring data only. Save the data that you want to transfer in this new .pst file and omit any data that you do not want to transfer. If you have to make a secondary .pst file to store data for transfer between two computers, or for backup purposes, use the following steps.

**In Outlook 2010:**  

1. Select the **File** tab.
2. In the **Info** category, select the **Account Settings** button and then select **Account Settings**.
3. In the **Account Settings** window, select the **Data Files** tab.
4. Select **Add**, select **Outlook data file (.pst)**, and then select **OK**.
5. Type a unique name for the new .pst file. For example, type Transfer.pst, and then select **OK**.
6. Close Outlook.

**In earlier versions of Outlook:**

1. On the **File** menu, point to **New**, and then select **Outlook Data File**.
2. Type a unique name for the new .pst file. For example, type Transfer.pst, and then select **OK**.
3. Type a display name for the Personal Folders file, and then select **OK**.
4. Close Outlook.

**Follow these steps to copy an existing .pst file:**

1. Use the instructions in the [How to make a backup copy of a .pst file](#how-to-make-a-backup-copy-of-a-pst-file) section to make a backup copy of the .pst file that you want to transfer. Make sure that you copy the backup .pst file to a CD-ROM or to another kind of removable media.
2. Copy the backup .pst file from the removable media to the second computer.
3. Follow the steps in the [How to import .pst file data into Outlook](#how-to-import-pst-file-data-into-outlook) section to import the .pst file data into Outlook on the second computer.

### How to back up Personal Address Books

Your Personal Address Book might contain email addresses and contact information that is not included in an Outlook Address Book or contact list. The Outlook Address Book can be kept either in an Exchange Server mailbox or in a .pst file. However, the Personal Address Book creates a separate file that is stored on your hard disk drive. To make sure that this address book is backed up, you must include any files that have the .pab extension in your backup process.

Use the following steps to locate your Personal Address Book file:

1. Follow the instructions for the version of Windows that you are running:
   - Windows Vista: Select **Start**.
   - Windows XP: Select **Start** and then select **Search**.
   - Windows 95 or Windows 98: Select **Start**, point to **Find**, and then select **Files or Folders**.
   - Windows 2000 or Windows Millennium Edition (Me): Select **Start**, point to **Search**, and then select **For Files or Folders**.

2. Type *.pab, and then press Enter or select **Find Now**.

   Make a note of the location of the .pab file. Use **My Computer** or **Windows Explorer** to copy the .pab file to the same folder or storage medium that contains the backup of the .pst file.

You can use this backup to restore your Personal Address Book to your computer or to transfer it to another computer. Follow these steps to restore the Personal Address Book:

1. Close any messaging programs, such as Outlook, Microsoft Exchange, or Windows Messaging.
2. Select **Start**, and then select **Run**. Type *control panel* in the **Open** box and then press Enter. This will open **Control Panel**.

    > [!NOTE]
    > If you see the **Pick a category** screen, select **User Accounts**.

3. Double-select the **Mail** icon.
4. Select **Show Profiles**.
5. Select the appropriate profile, and then select **Properties**.
6. Select **Email Accounts**.
7. Select **Add a New Directory or Address Book** and then select **Next**.
8. Select **Additional Address Books** and then select **Next**.
9. Select **Personal Address Book** and then select **Next**.
10. Type the path and the name of the Personal Address Book file that you want to restore, select **Apply**, and then select **OK**.
11. Select **Close** and select then **OK**.

> [!NOTE]
> The Outlook Address Book is a service that the profile uses to make it easier to use a Contacts folder in a Mailbox, Personal Folder File, or Public Folder as an email address book. The Outlook Address Book itself contains no data that has to be saved.

### How to use the Personal Folder Backup utility to automate the backup of .pst files

Microsoft has released a utility to automate the backup of your personal folders (.pst) file. For more information about the Personal Folder Backup utility, see [Back up your email](https://support.microsoft.com/office/e5845b0b-1aeb-424f-924c-aa1c33b18833).

### How to back up Outlook settings files

If you have customized settings, such as toolbar settings and Favorites, that you want to replicate on another computer or restore to your computer, you might want to include the following files in your backup:

- Outcmd.dat: This file stores toolbar and menu settings.
- **ProfileName**.fav: This is your Favorites file, which includes the settings for the Outlook bar (only applies to Outlook 2002 and older versions).
- ProfileName.xml: This file stores the Navigation Pane preferences (only applies to Outlook 2003 and newer versions).
- **ProfileName**.nk2: This file stores the Nicknames for AutoComplete.
- Signature files: Each signature has its own file and uses the same name as the signature that you used when you created it. For example, if you create a signature named MySig, the following files are created in the Signatures folder:
  - MySig.htm: This file stores the HTML Auto signature.
  - MySig.rtf: This file stores the Microsoft Outlook Rich Text Format (RTF) Auto signature.
  - MySig.txt: This file stores the plain text format Auto signature.
  
  The location of the signature files depends on the version of Windows that you are running. Use the following list to find the appropriate location:

  - Windows Vista or Windows 7: Drive\users\Username\appdata, where Drive represents the drive that Outlook was installed to and Username represents the user name that Outlook was installed under.
  - Windows XP or Windows 2000: Drive\Documents and Settings\Username\Local Settings\Application Data\Microsoft\Outlook, where Drive represents the drive that Outlook was installed to and Username represents the user name that Outlook was installed under.
  - Windows 98 or Windows Millenium Edition: Drive\Windows\Local Settings\Application Data, where Drive represents the drive that Outlook was installed to.

> [!NOTE]
> If you use Microsoft Word as your email editor, signatures are stored in the Normal.dot file as AutoText entries. You should back up this file also.

#### How to determine the name and location of your personal folders file

Microsoft Outlook 2010

1. Start Outlook 2010.
2. Select the **File** tab in the Ribbon, and then select the **Info** tab on the menu.
3. Select the **Account Settings** tab.
4. Select **Account Settings** again.
5. Select **Data Files**.

    > [!NOTE]
    > The path and file name of your .pst file. For example, C:\Exchange\Mailbox.pst indicates a .pst file that is named Mailbox.pst and is located in the Exchange folder on your drive C.

6. Select **Close**, select **OK**, and then select **Exit and Log Off** on the **File** menu to exit Outlook.

Microsoft Office Outlook 2002 through Microsoft Office Outlook 2007

1. Start Outlook.
2. On the **Tools** menu, select **Options**.
3. On the **Mail Setup** tab, select the **Data Files** button.

    > [!NOTE]
    > the path and file name of your .pst file. For example, C:\Exchange\Mailbox.pst indicates a .pst file that is named Mailbox.pst located in the Exchange folder on your drive C.

4. Select **Close**, select **OK**, and then select **Exit and Log Off** on the **File** menu to exit Outlook.

#### How to copy your personal folders file

1. On the **Start** menu, point to **Programs**, and then select **Windows Explorer**.
2. Browse through the files to the location of your .pst file.
3. Copy your .pst file to the location that you want.

#### For more information about how to copy a file or a folder

1. Select the **Start** button, and then select **Help**.
2. Select the **Search** tab, and then type **copy**.
3. In the **Select Topic to display** box, select **Copy or move a file or a folder**.

#### How to point Outlook to your new personal folders file

Microsoft Outlook 2010

1. Open Outlook 2010.
2. Select the **File** tab on the Ribbon, and then select the **Info** tab on the menu.
3. Select the **Accounts Settings** tab and then select **Account Settings** again.
4. On the Data Files tab, select **Add**.
5. Under **Save as type**, select **Outlook Data File (*.pst)**.
6. Find the new location for your .pst file and then select **OK**.
7. Select the .pst file and then select **Set as Default**.
8. If this is your default email delivery location, you will receive the following message:

   > You have changed the default deliver location for your email. This will change the location of your Inbox, Calendar, and other folders. These changes will take effect the next time that you start Outlook.

9. Select **OK**.
10. Select the .pst file that was identified in step 4 in the [How to determine the name and location of your personal folders file](#how-to-determine-the-name-and-location-of-your-personal-folders-file) section and then select **Remove** to remove the local .pst file from your profile.
11. Select **Yes**, select **Close**, and then select **OK** to close all dialog boxes.
12. On the **File** menu, select **Exit**.
13. Restart Outlook.

Your profile now points to your .pst file in the new location. Outlook opens your new .pst file and you can now delete the .pst file from its old location.

#### Microsoft Office Outlook 2003 and Microsoft Office Outlook 2007

1. Open Outlook.
2. On the **Tools** menu, select **Options**.
3. On the **Mail Setup** tab, select the **Email accounts** button, even if you do not have an email account specified.
4. On the **Data Files** tab, select **Add**.
5. Select **Office Outlook Personal Folders File (.pst)** and then select **OK**.
6. Find the new location for your .pst file, and then select **OK** two times.
7. Select **Set as Default**.
8. If this is your default email delivery location, you will receive the following message:

   > You have changed the default deliver location for your email. This will change the location of your Inbox, Calendar, and other folders. These changes will take effect the next time that you start Outlook.

9. Select **OK**.
10. Select the .pst file that was identified in step 4 of the "How to determine the name and location of your personal folder file" section, and then select **Remove** to remove the local .pst file from your profile.
11. Select **Yes**, select **Close**, and then select **OK** to close all dialog boxes.
12. On the **File** menu, select **Exit**.
13. Restart Outlook.

If the .pst is your default delivery location, you will receive the following message:

> The location that messages are delivered to has changed for this user profile. To complete this operation, you may have to copy the contents of the old Outlook folders to the new Outlook folders. For information about how to complete the change of your mail delivery location, see Microsoft Outlook Help. Some shortcuts on the Outlook Bar may no longer work. Do you want Outlook to re-create your shortcuts? All shortcuts that you have created will be removed.

Select Yes to have Outlook update the Outlook Bar shortcuts so that they point to your new .pst file location, or select No to leave the shortcuts for your original local .pst file.

Your profile now points to your .pst file in the new location. Outlook opens your new .pst file, and you can now delete the .pst file from its old location.

Microsoft Office Outlook 2002

1. Open Outlook.
2. On the **Tools** menu, select **Options**.
3. On the Mail Setup tab, select the **Email accounts** button, even if you do not have an email account specified.
4. Select the **View or change existing email accounts** check box, and then select **Next**.
5. Select the **New Outlook Data File** button.
6. Under **Types of storage**, select **Personal Folders file (.pst)**, and then select **OK**.
7. Browse through the folders to the new location for your .pst file, and then select **OK** two times.
8. Under the **Deliver new email to the following location** list, select the Personal Folders file that was just added, and then select **Finish**.
9. If this is your default email delivery location, you will receive the following message:

   > You have changed the default deliver location for your email. This will change the location of your Inbox, Calendar, and other folders. These changes will take effect the next time that you start Outlook.

10. Select **OK**.
11. On the **Mail Setup** tab, select the Data Files button.
12. Select the .pst file that was identified in step 4 of the [How to determine the name and location of your personal folders file](#how-to-determine-the-name-and-location-of-your-personal-folders-file) section, and then select **Remove** to remove the local .pst file from your profile.
13. Select **Close**, and then select **OK** to close all dialog boxes.
14. On the **File** menu, select Exit.
15. Restart Outlook.

If the .pst is your default delivery location, you will receive the following message:

> The location that messages are delivered to has changed for this user profile. To complete this operation, you may need to copy the contents of the old Outlook folders to the new Outlook folders. For information about how to complete the change of your mail delivery location, see Microsoft Outlook Help. Some of the shortcuts on the Outlook Bar may no longer work. Do you want Outlook to recreate your shortcuts? All shortcuts you have created will be removed.

Select **Yes** to have Outlook update the Outlook Bar shortcuts so that they point to your new .pst file location, or select **No** to leave the shortcuts for your original local .pst file.

Your profile now points to your .pst file in the new location. Outlook opens your new .pst file, and you can now delete the .pst file from its old location.

## More information

If these methods did not help you, you might want to ask someone you know for help. Or, if you use Outlook with Exchange Server, you might want to contact the Exchange Server administrator for help. You can also use the Microsoft Customer Support Services website to find other solutions. Some services that the Microsoft Customer Support Services website provides include the following:

[Search technical support information and self-help tools for Microsoft products](https://support.microsoft.com)

If you continue to have questions after you use these Microsoft websites or if you cannot find a solution on the Microsoft Support Services Web site, [contact Microsoft Support](https://support.microsoft.com/contactus).
