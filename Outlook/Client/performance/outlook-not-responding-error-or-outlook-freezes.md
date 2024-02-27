---
title: Outlook not responding error or Outlook freezes
description: Describes an issue that triggers an not responding error or Outlook freezes. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: sercast
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook 2010 with Business Contact Manager
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook not responding error or Outlook freezes when you open a file or send mail

_Original KB number:_ &nbsp; 2652320

## Symptoms

When you open a file or send an email message in Microsoft Outlook 2010 or later versions, Outlook freezes, or you receive the following error message:

> Outlook not responding

## Cause

This problem occurs for one or more of the following reasons:

- You have not installed the latest updates.
- Outlook is in use by another process.
- Outlook is loading external content, such as images in an email message.
- A previously installed add-in is interfering with Outlook.
- Your mailboxes are too large.
- Your AppData folder is redirected to a network location.
- You have to repair your Office programs.
- Outlook data files have become corrupted or damaged.
- Your installed antivirus software is outdated, or it conflicts with Outlook.
- Your user profile has become corrupted.
- Another program conflicts with Outlook.

> [!NOTE]
>
> - This issue may occur for one or more of the reasons in this section. To fix this issue, you may have to follow the troubleshooting steps in the Resolution section.
> - Many of these items can be automatically checked by the Microsoft Support and Recovery Assistant (SaRA). To start the automated checks, follow these steps:
>    1. Install the [Outlook Advanced Diagnostics](https://aka.ms/SaRA-OutlookAdvDiagnostics) tool.
>    2. Select **Run** when you are prompted by your browser.
>    3. In the report that's generated, review the items on the **Issues found** tab. For configuration details about Outlook, Windows, and your computer, review the settings on the **Detailed View** tab.

## Resolution

To resolve this problem, make sure that your computer meets the [Outlook 2016 system requirements](https://www.microsoft.com/microsoft-365/microsoft-365-and-office-resources), [Outlook 2013 system requirements](/previous-versions/office/office-2013-resource-kit/ee624351(v=office.15)) or [Outlook 2010 system requirements](/previous-versions/office/office-2010/ee624351(v=office.14)).

> [!NOTE]
> These steps are provided in a specific order based on commonality and complexity. Follow these steps in the given order.

### Step 1 - Install the latest updates

The Office installation on your computer might not be up to date. This might be because Windows Update is not configured on your computer to automatically download and install recommended updates. By installing important, recommended, and optional updates, you can often correct problems by replacing out-of-date files and fixing vulnerabilities. To install the latest Office updates, click the link for your version of Windows, and then follow the steps in the article:

- [Install Windows updates in Windows 10](https://support.microsoft.com/hub/4338813/windows-help?os=windows-10)
- [Windows Update FAQ for Windows 8.1](https://support.microsoft.com/hub/4338813/windows-help?os=windows-8.1)
- [Install Windows updates in Windows 7](https://support.microsoft.com/help/12373/windows-update-faq)
- [Install Windows updates in Windows Vista](https://support.microsoft.com/help/22882/windows-vista-end-of-support)
- [Install Windows updates in Windows XP](https://support.microsoft.com/help/14223/windows-xp-end-of-support)

Make sure that the latest updates for Outlook are installed. For more information, see [How to install the latest applicable updates for Microsoft Outlook (US English only)](/outlook/troubleshoot/installation/install-outlook-latest-updates).

### Step 2 - Make sure that Outlook is not in use by another process

Performance may be decreased if you use the Outlook AutoArchive feature or sync to Outlook with a mobile device. This is because these processes can use a large number of resources.

If Outlook is in use by another process, this information is displayed in the status bar at the bottom of the screen. If you try to perform other actions while Outlook is in use, Outlook may not respond. Let the task in process finish its job before you try another action.

### Step 3 - Check the problem caused by external content

To resolve this issue, use one of the following methods:

- Prevent Outlook to download external contents. To do this, go to **File** > **Options** > **Trust Center** > **Automatic Download**, select the following two options:
  - Don't download pictures or other content automatically in HTML e-mail option.
  - Warn me before downloading content when editing, forwarding, or replying e-mail.
- Avoid sending such an email with external source.

### Step 4 - Investigate possible add-in issues

Although add-ins can enhance your user experience, they can occasionally interfere or conflict with Outlook. Try to start Outlook without any add-ins running.

#### How to start Outlook without add-ins

1. Do the following, as appropriate for your operating system:
   - If you are running Windows 8, swipe in from the right edge of the screen, and then tap **Search**. (If you are using a mouse, point to the upper-right corner of the screen, move the mouse pointer down, and then select **Search**.) Type Run in the search box, and then tap or select **Run**.
   - If you are running Windows 10, Windows 7 or Windows Vista, select **Start**.
   - If you are running Windows XP, select **Start**, and then select **Run**.
2. Type *Outlook.exe /safe*, and then select **OK**.
3. If the problem is resolved, select **Options** on the **File** menu, and then select **Add-Ins**.
4. Select **COM Add-ins**, and then select **Go**.
5. Clear all the check boxes in the list, and then select **OK**.
6. Restart Outlook.

If the problem does not occur after you restart Outlook, one of the add-ins is likely the cause of the problem. Restore the add-ins one at a time until the problem does occur to determine which add-in is causing the problem.

### Step 5 - Check whether your mailbox is too large

As your mailbox size increases, more resources are required to open each folder. If you have a large number of items in any single folder, you may experience performance issues during certain operations. For more information, see [Outlook performance issues when there are too many items or folders in a cached mode .ost or .pst file](https://support.microsoft.com/help/2768656).

We recommend that you move several items in your larger folders to separate folders, or that you archive those items by using the AutoArchive feature.

#### How to create a folder

1. On the **Folder** tab, select **New Folder** in the **New** group.
2. In the **Name** box, enter a name for the folder.
3. In the **Select where to place the folder** list, select the location for the new folder.

    > [!NOTE]
    > The new folder will become a subfolder of the folder you select.

4. Select **OK**.

To manage your mailbox by reducing the size of the Outlook data file, see [Reduce the size of Outlook Data Files (.pst and .ost)](https://support.microsoft.com/office/reduce-the-size-of-your-mailbox-and-outlook-data-files-pst-and-ost-e4c6a4f1-d39c-47dc-a4fa-abe96dc8c7ef).

To manage your mailbox by using the AutoArchive feature, see [AutoArchive settings explained](https://support.microsoft.com/office/autoarchive-settings-explained-444bd6aa-06d0-4d8f-9d84-903163439114).

### Step 6 - Check whether your AppData folder is being redirected to a network location

Outlook stores certain data, such as email signatures and the spelling checker dictionary, in the AppData folder. If the network is performing slowly, Outlook must wait for read and write operations to the AppData directory to finish.

#### How to disable redirection of the AppData directory

1. Exit Outlook.
2. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows:
   - Windows 10 or Windows 8: Press Windows Key+R to open a Run dialog box. Type *regedit.exe* and then press **OK**.
   - Windows 7: Select **Start**, type *regedit.exe* in the search box, and then press Enter.
3. In Registry Editor, locate and then select the following subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`
4. Locate and then double-click the **AppData** value.

5. In the **Value data** box, type the following path, and then select **OK**:  
   *%USERPROFILE%\AppData\Roaming*

   :::image type="content" source="media/outlook-not-responding-error-or-outlook-freezes/edit-string.png" alt-text="Screenshot of the Edit String dialog where you can input the value data." border="false":::

6. Exit Registry Editor.

### Step 7 - Repair Office programs

You can automatically repair your Office program files to resolve such problems as Outlook freezing or not responding.

#### How to automatically repair Office

1. Exit any Microsoft Office programs that are running.
2. Open Control Panel, and then open the **Add or Remove Programs** item (if you are running Windows XP) or **Programs and Features** (if you are running Windows 10, Windows 8, Windows 7, or Windows Vista).
3. In the list of installed programs, right-click **Microsoft Office 2016**, **Microsoft Office 2013** or **Microsoft Office 2010**, and then select **Repair**.  

### Step 8 - Repair Outlook data files

When you install Outlook, an Inbox repair tool (scanpst.exe) is also installed on your PC. The Inbox repair tool can resolve problems by scanning your Outlook data files, and repairing errors. To use the Inbox repair tool, exit Outlook, and then follow the steps in [Repair Outlook Data Files (.pst and .ost)](https://support.microsoft.com/office/repair-outlook-data-files-pst-and-ost-25663bc3-11ec-4412-86c4-60458afc5253).

### Step 9 - Check whether antivirus software is up-to-date or conflicts with Outlook

If your antivirus software is not up-to-date, Outlook may not function correctly.

#### How to check whether antivirus software is up to date

To keep up with new viruses as they are created, antivirus software vendors periodically provide updates that you can download from the Internet. Download the latest updates by visiting your antivirus software vendor's website.

For a list of antivirus software vendors, see [Consumer antivirus software providers for Windows](https://support.microsoft.com/help/18900/consumer-antivirus-software-providers-for-windows#avtabs=win7).

#### How to check whether antivirus software conflicts with Outlook

If your antivirus software includes integration with Outlook, you may experience performance issues. You can disable all Outlook integration within the antivirus software. Or, you can disable any antivirus software add-ins that are installed in Outlook.

> [!IMPORTANT]
> When you change your antivirus settings, this may make your PC vulnerable to viral, fraudulent, or malicious attacks. We do not recommend that you try to change your antivirus settings. Use this workaround at your own risk.

You may have to contact your antivirus software vendor to determine how to configure the software to exclude any integration with Outlook or to exclude scanning in Outlook.

> [!NOTE]
> If you also plan to perform file-level virus scanning of .pst, .ost, Offline Address Book (.oab), or other Outlook files while Outlook is in use, see [Plan antivirus scanning for Outlook 2010](/previous-versions/office/office-2010/hh550032(v=office.14)) or [Planning considerations for deploying Outlook 2016 for Windows](/outlook/troubleshoot/installation/plan-outlook-2016-deployment#outlook-security-considerations).

### Step 10 - Create a user profile in Outlook

To create a user profile, follow these steps:

1. In Control Panel, select **Programs**, select **User Accounts**, and then select **Mail** to open Mail items.
2. Select **Show Profiles**.
3. Select the profile that you want to remove, and then select **Remove**.
4. Select **Add**.
5. In the **Profile Name** dialog box, type a name for the profile.
6. Specify the user name, the primary SMTP address, and the password. Then, select **Next**.
7. You may receive the following prompt:  
   Allow this website to configure <alias@domain server> settings?

   In this prompt, select the **Don't ask me about this again** checkbox, and then select **Allow**.

### Step 11 - Perform a Selective Startup (advanced users)

When you start Windows normally, several applications and services start automatically and then run in the background. These applications and services can interfere with Outlook. A Selective Startup or "clean boot" process can help you identify problems that are caused by application conflicts.

If you use the Selective Startup option in System Configuration, you can turn services and startup programs on or off individually to check whether the problem occurs the next time that you start your computer. In System Configuration, if you select a check box, the related service or startup program runs when you restart the computer. If the check box is cleared, the service or startup program does not run when you restart the computer.

Follow this procedure to use the process of elimination to identify the problem in Windows 10, Windows 8, Windows 7, or Windows Vista.

> [!NOTE]
> For more information about performing a clean boot, see [How to perform a clean boot in Windows](https://support.microsoft.com/help/929135/how-to-perform-a-clean-boot-in-windows).

#### How to do a Selective startup

1. In Control Panel, select **System and Security**, select **Administrative Tools**, and then double-click **System Configuration**.

    > [!NOTE]
    > If you are prompted for an administrator password or for confirmation, type the password or provide confirmation.
2. Select the **General** tab, select **Selective startup**, and then clear the **Load system services** and the **Load startup items** check boxes.
3. Select the **Load system services** check box, select **OK**, and then select **Restart**.
4. If the problem reoccurs after you restart the computer, do one or both of the following tasks, as necessary.

   **To determine which system service is causing the problem**

    1. In System Configuration, select the **Services** tab, select **Disable all**, select the check box for the first service that is listed, and then restart the computer.

       > [!NOTE]
       > If the problem doesn't reoccur, then you can eliminate the first service as the cause of the problem.

    2. With the first service selected, select the second service check box, and then restart the computer.
    3. Repeat this process until you reproduce the problem.

       > [!NOTE]
       > If you can't reproduce the problem, you can eliminate system services as the cause of the problem.

   **To determine which startup item is causing the problem**

     1. In System Configuration, select the **General** tab, and then select the **Load startup items** check box.
     2. Select the **Startup** tab, select **Disable all**, select the check box for the first startup item that is listed, and then restart the computer.

        > [!NOTE]
        > If the problem doesn't reoccur, you can eliminate the first startup item as the cause of the problem.

     3. While the first startup item is selected, select the second startup item check box, and then restart the computer. Repeat this process until you reproduce the problem.

### Step 12 - Create a Windows user profile (advanced users)

Your user profile is a collection of settings that let you customize the computer appearance and performance. It contains settings for desktop backgrounds, screen savers, sound settings, and other features. User profiles help make sure that your personal preferences are used when you log on to Windows.

To determine whether this problem is caused by a corrupted user profile, create a user profile to see whether the problem still occurs when you use the new profile.

### How to repair a corrupted user profile in Windows 8

#### Step 1 - Create a user account

To create a user profile, you must first create a user account. When the new account is created, a profile is also created.

1. Swipe in from the right edge of the screen, and then tap **Search**. (If you are using a mouse, point to the upper-right corner of the screen, move the mouse pointer down, and then select **Search**.) Type *Command Prompt* in the search box, right-click **Command Prompt**, and then select **Run as administrator**.

    > [!NOTE]
    > If you're prompted for an administrator password or for confirmation, type the password or provide confirmation.
2. Type net user *UsernamePassword /add*, and then press Enter.

#### Step 2 - Copy old files to the new user profile** After you create the profile, you can copy the files from the existing profile

> [!NOTE]
> You must have at least three user accounts on the computer to complete these steps. This includes the new account you just created.

1. Log on as a user other than the user that you just created or the user that you want to copy files from.
2. In Control Panel, select **Appearance and Personalization**, and then select **Folder Options**.
3. Select the **View** tab, and then select **Show hidden files, folders, and drives**.
4. Clear the **Hide protected operating system files** check box, select **Yes** to confirm, and then select **OK**.
5. Open File Explorer. To do this, Swipe in from the right edge of the screen, and then tap **Search**. (If you are using a mouse, point to the upper-right corner of the screen, move the mouse pointer down, and then select **Search**.) Enter **File Explorer** in the search box, tap or select **Apps**, and then tap or select **File Explorer**. Type *Command Prompt* in the search box, right-click **Command Prompt**, and then select **Run as administrator**.
6. Locate the C:\Users\Old_Username folder, in which **C** is the drive that Windows is installed on, and **Old_Username** is the name of the profile that you want to copy files from.
7. Select all the files and folders in this folder, except the following files:
   - Ntuser.dat
   - Ntuser.dat.log
   - Ntuser.ini
8. On the **Edit** menu, select **Copy**.

    > [!NOTE]
    > If you don't see the **Edit** menu, press Alt.
9. Locate the C:\Users\New_Username folder, in which **C** is the drive that Windows is installed on, and **New_Username** is the name of the user profile that you created earlier in this method.

10. On the **Edit** menu, select **Paste**.
11. Log off, and then log back on as the new user.

> [!NOTE]
> If you have email messages in an email program, you must import your email messages and addresses to the new user profile before you delete the old profile. If everything is working correctly, you can now delete the old profile.

## Next step

If the information in this article does not help resolve your problem in Outlook 2016, Outlook 2013 or Outlook 2010, see the following resources for more information:

- [Perform a search to find more online articles about this specific error](https://support.microsoft.com/)
- [Visit the Microsoft Community online to post your question about this error](https://answers.microsoft.com/)
- [Find the appropriate phone number to contact Microsoft Support](https://support.microsoft.com/contactus/)

## References

- [Fix a corrupted user profile in Window 7](https://support.microsoft.com/help/14039)
- [Create a user account in Windows](https://support.microsoft.com/help/13951)
