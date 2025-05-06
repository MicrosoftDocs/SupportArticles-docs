---
title: Manage download settings for shared mail folders in Cached Exchange mode in Outlook
description: Discusses how to disable the download of shared mail folders in Cached Exchange mode in Outlook 2016 and later versions. 
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Exchange Mailbox Accounts\Cached mode synchronization
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, migr, laurentc, doakm, gbratton, gregmans
appliesto: 
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 04/07/2025
---

# Manage download settings for shared mail folders in Cached Exchange mode in Outlook

_Original KB number:_ &nbsp; 982697

Consider that you have a profile which is configured in Cached Exchange mode in Microsoft Outlook 2016 or a later version. If you add another user's shared mailbox or shared folder to your profile, then all the folders in the shared mailbox to which you have access are downloaded to your local cache by default.

The following screenshot displays the shared Inbox folder of a user. You can identify that this folder is being cached in Outlook because the status bar displays **Connected** when this folder is selected in the navigation pane.

:::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/example-of-cached-shared-mailbox.png" alt-text="Screenshot of a shared mailbox that's being cached.":::

Mail folders typically contain more items that non-mail folders. In the versions of Outlook earlier than Outlook 2010 when hard disk space was at a premium, only non-mail folders were cached by default. With hardware advancements, increased disk sizes and speeds, the impact of caching more data locally was reduced. Therefore later versions of Outlook were changed to also cache mail folders by default.

Working with shared folders that are downloaded locally provides better performance. This is because Outlook reads the folder data from the local hard disk instead of connecting to the Microsoft Exchange Server to retrieve the shared folders. The performance gained by using locally cached folders is even more noticeable if the shared folders are located on an Exchange Online mailbox in Microsoft 365.

## Effect of cached shared folders on the size of the Offline Outlook Data (.ost) file

If Outlook is configured to download shared folders, the contents of the shared folders are stored in your local Offline Outlook Data (.ost) file. If the shared folders contain many items or large attachments, the size of your .ost file size might grow significantly.

Also, if you have permissions to a site mailbox, and the *Download Shared Folders* option is enabled in Outlook, the contents of the site mailbox are synchronized to your local .ost file. This can result in an increase in size for the .ost file as well.

For more information about large Outlook data files and performance, see [You might experience application pauses if you have a large Outlook data file](https://support.microsoft.com/help/2759052).

If the size of your .ost file is restricted by policies, caching shared folders might result in the .ost file size limit being reached. For more information about policies that administrators can use to limit the size of Outlook data files, see [How to configure the size limit for both (.pst) and (.ost) files in Outlook](https://support.microsoft.com/help/832925).

Beginning with the Outlook 2016 version, the **Download email for the past** feature applies to your mailbox and to shared mailboxes. This helps to prevent the .ost file from becoming too large. However, an administrator might have implemented a registry value to revert to the previous behavior. To determine this, check for the `DisableSyncSliderForSharedMailbox` registry value. If the value exists and is set to 1, it indicates that the entire contents of shared mailboxes are synchronized to your local .ost file. This is the behavior assuming that the registry values `CacheOthersMail` and `DownloadSharedFolders` aren't set to `0`.

For more information about the DisableSyncSliderForSharedMailbox registry value, see [Only some emails are synchronized](fewer-emails-in-shared-mailboxes-or-public-folders.md).

**Note**: In the versions of Outlook earlier than Outlook 2016, the **Download email for the past** feature was named **Mail to keep offline**.

The best Outlook client performance can vary from user to user, based on their configuration, the number of shared folders being accessed, the location of those shared mailboxes, etc. Only by testing with and without the default download shared folder options can the optimal settings be determined for each user.

## Registry values, Group Policy, and Office Customization Tool settings to modify download settings

The default behavior to download shared folders can be modified by using group policies and registry settings. Some of these policies and registry values might have improved the shared folder performance in earlier versions of Outlook or when the shared folders were on Exchange Server on-premises mailboxes. However those performance gains might be lost in recent Outlook versions or after mailboxes are moved to Microsoft 365 cloud tenants. If you experience performance issues when using shared folders in Outlook, an administrator will need to determine if such group policies and registry values are set for your organization, and test the performance in Outlook without them.

There are settings that control how Outlook uses shared folders and others that can be used to disable caching of all shared folders. 

### Settings that control how Outlook uses shared folders

The `CacheOthersMail` registry value can be configured to cache only non-mail folders such as the Calendar, Contacts, and Tasks folders. When this value is configured, the items in mail folders aren't available when you're working offline in Outlook. However, items in non-mail folders are still available.

Key:

HKEY_CURRENT_USER\Software\Microsoft\Office\<xx.0>\Outlook\Cached Mode

or

HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<xx.0>\Outlook\Cached Mode

The <xx.0> placeholder represents the version of Office (16.0 = Office 2016 and later versions).

Name: CacheOthersMail  
Type: DWORD:  
Value: 0

The default value is 1.

> [!NOTE]
> If the registry value exists in the `\Policies` registry key, the setting applies to all existing Outlook profiles. If the registry value exists in the non-Policies key, it only applies to new Outlook profiles that are created.

After the caching of shared mail folders is disabled, the status bar in Outlook will display **Online** when you select a shared mail folder in the navigation pane as shown in the following screenshot.

:::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/outlook-status-bar-shows-online.png" alt-text="Screenshot of the Outlook status bar which displays Online.":::

To set the `CacheOthersMail` registry value, you can:

- Configure the Windows Registry manually.
- Control the registry setting by using a Group Policy.
- Deploy the Shared Mail Folder Cache setting by using the Office Customization Tool (OCT).

#### Configure the Windows Registry manually

[!INCLUDE [Important registry alert](../../../includes/registry-important-alert.md)]

Use the following steps to change the caching behavior for shared folders in Outlook 2016 or later versions:

1. Exit Outlook.
2. Select the Windows Key+R to open a Run dialog box.
3. Type **regedit.exe** and then press **OK**.
4. Locate and select the registry key: `HKEY_CURRENT_USER\Software\Microsoft\Office\<xx.0>\Outlook\Cached Mode`

    The <xx.0> placeholder represents the version of Office (16.0 = Office 2016 and later versions).
    > [!NOTE]
    >
    > If the **Cached Mode** key doesn't exist, create it by following these steps:
    >
    > 1. Select the **Outlook** key.
    > 2. On the **Edit** menu, point to **New**, and then select **Key**.
    > 3. Type **Cached Mode**, and then press ENTER.
    > 4. Select the **Cached Mode** key and then go to step 5.

5.  On the **Edit** menu, point to **New**, and then select **DWORD Value**.
6.  Type **CacheOthersMail**, and press ENTER.
7.  On the **Edit** menu, select **Modify**.
8.  Type **0** to only cache shared, non-mail folders, or **1** to cache all shared folders, and then select **OK**.
9.  Exit the Registry Editor.
10. Start Outlook.

> [!NOTE]
> This method will affect only the new Outlook profiles that you create. To change the behavior for all existing Outlook profiles, change the registry value in the following registry key path:
>
> `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\\<xx.0>\Outlook\Cached Mode`
>
> The <xx.0> placeholder represents the version of Office (16.0 = Office 2016 and later versions).

#### Control the registry setting by using a Group Policy

The registry key value that is required to change the default shared folder caching behavior in Outlook can be configured by using a Group Policy setting. These steps are usually performed by an Active Directory administrator.

The default Group Policy template files for Outlook contain the policy setting that controls this functionality. These are _outlk16.admx_ and _outlk16.adml_ for Outlook 2016 and later versions.

To deploy the registry setting by using the Outlook Group Policy template, use the following steps:

1. Download the [Administrative template files](https://www.microsoft.com/download/details.aspx?id=49030) from the Microsoft Download Center.

2. Extract the admintemplates_32bit.exe or admintemplates_64bit.exe file to a folder on your computer.

3. For Outlook 2016 and later versions, copy _outlk16.admx_ to the _C:\Windows\PolicyDefinitions_ folder.

4. For Outlook 2016 and later versions, copy _outlk16.adml_ to the _C:\Windows\PolicyDefinitions\<language culture name>_ folder. For English (US), the language culture name is `en-US`. For more information about language culture names, see [Table of language culture names, codes, and ISO values](/previous-versions/commerce-server/ee797784(v=cs.20)).

   **Note**: Make sure that you copy the .adml file from the correct language folder.

5. Start the Group Policy Object Editor or the Group Policy Management Console.

   Group policies can be applied to different Active Directory objects such as Organization Units (OU). Check your Windows documentation to set the group policies on the desired objects.

6. In the Group Policy Object Editor or the Group Policy Management Console, under **User Configuration**, expand **Administrative Templates**, expand your version of **Microsoft Outlook**, expand **Outlook Options**, and then select the **Delegates** node.

    :::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/disable-shared-mail-folder-caching.png" alt-text="Screenshot of the Local Group Policy Editor for Outlook 2013.":::

7. Under **Delegates**, double-click **Disable shared mail folder caching**.
8. To revert to the default setting, select **Disabled**, and then select **OK**. To change to the non-default setting of only caching non-mail folders, select **Enabled**, and then select **OK**.

   The policy setting will be applied to all the Outlook client installations when the Group Policy setting update is replicated.

9. To test this change, type `gpupdate /force` at the command prompt and press Enter.

10. Start Registry Editor on the affected client computer and verify that the `CacheOthersMail` registry value exists on the client, and has a value of **0**:

   Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<xx.0>\Outlook\Cached Mode

   The <xx.0> placeholder represents the version of Office (16.0 = Office 2016 and later versions).

   Name: CacheOthersMail
   Type: DWORD:
   Value: x

   Where x is 1 to revert to the default behavior or 0 if applying the non-default setting to cache non-mail folders only.

   If you see this registry data in the registry, it indicates that the Group Policy setting has been applied to the client.

11. Start Outlook to verify that this change has been implemented.

#### Deploy the Shared Mail Folder Cache setting by using the Office Customization Tool (OCT)

To deploy the Shared Mail Folder Cache setting in Outlook 2016 or later versions, use the built-in setting in the OCT.

> [!NOTE]
> You must have an enterprise edition of Microsoft Office to use the OCT. If you have a retail edition of Office, you'll see the following error when you try to start the OCT:
> Files necessary to run the Office Customization Tool weren't found. Run Setup from the installation point of a qualifying product.

1. Select **Start**, type *cmd* in the **Start Search** box, and then press Enter.
2. At the command prompt, type the path to your Office installation files followed by " /admin", such as the following, and then press Enter:

   \\\Server\share\Office\Setup.exe /admin

3. In the **Select Product** dialog box, select **Create a new Setup customization file for the following product**.
4. Select the Office product in the **Select Product** dialog box, and then select **OK**.
5. In the navigation pane of the OCT, select **Modify user settings**, expand your version of **Microsoft Outlook**, expand **Outlook Options**, and then select **Delegates**.
6. Double-click **Disable shared mail folder caching**.
7. To revert to the default setting, select **Disabled**, and then select **OK**. To change to the non-default setting of only caching non-mail folders, select **Enabled**, and then select **OK**.
8. Complete any remaining tasks in the OCT, and then save your .msp file.
9. Deploy Office with this .msp file.

> [!NOTE]
> This method affects only the new Outlook profiles that you create. To change the behavior for all existing Outlook profiles, add the registry value in the following registry key path:
>
> `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\\<xx.0>\Outlook\Cached Mode`
>
> The <xx.0> placeholder represents the version of Office (16.0 = Office 2016 and later versions).

### Settings to disable caching of shared folders

It's possible to disable caching for shared folders in all Cached mode profiles. This includes shared mail folders and shared non-mail folders. The setting is available both in the OCT and in the Group Policy template.

#### OCT

In the OCT for Outlook 2016 and later versions, the setting that controls caching for all shared folders is named **Download shared non-mail folders**. It's located under **Modify user settings** > your version of Microsoft Outlook > **Account Settings** > **Exchange** > **Cached Exchange Mode**.

:::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/settings-in-office-customization-tool.png" alt-text="Screenshot shows the setting in the Outlook OCT.":::

When the OCT is used to disable this setting, the following registry key value is configured on Outlook clients:

Key: HKEY_CURRENT_USER\Software\Microsoft\Office\\<xx.0>\Outlook\Cached Mode

The <xx.0> placeholder represents the version of Office (16.0 = Office 2016 and later versions).

Name: DownloadSharedFolders  
Type: DWORD  
Value: 0

If the value of the registry key is set to `0`, this indicates that a non-default setting has been configured.

#### Group Policy Template

In the Group Policy Template for Outlook 2016 and later versions, the setting that controls the caching of all shared folders is named **Download shared non-mail folders**. It's located under **User Configuration** > **Administrative Templates** > your version of Microsoft Outlook > **Account Settings** > **Exchange** > **Cached Exchange Mode**.

:::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/setting-in-local-group-policy-editor.png" alt-text="Screenshot of the Group Policy Management Editor that controls the setting for caching in Outlook.":::

When you use a Group Policy to disable this setting, the following registry key value is configured on Outlook clients:

Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\\<xx.0>\Outlook\Cached Mode

The <xx.0> placeholder represents the version of Office (16.0 = Office 2016 and later versions).

Name: DownloadSharedFolders  
Type: DWORD  
Value: 0

If the value is set to `0`, this indicates that a non-default setting has been configured.
