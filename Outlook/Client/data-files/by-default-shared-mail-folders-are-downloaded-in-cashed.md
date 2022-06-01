---
title: Shared mail folders are downloaded in Cached mode
description: Provides details on how to disable the download of shared mail folders in Cached mode in Outlook 2013 and later versions. By default, Outlook 2010 and later versions download shared folders that contain mail items.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, migr, laurentc, doakm, gbratton, gregmans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook for Office 365
search.appverid: MET150
ms.date: 6/1/2022
---
# Shared mail folders are downloaded by default in Outlook Cached Exchange Mode

_Original KB number:_ &nbsp; 982697

## Summary

By default, if a Microsoft Outlook 2010 or later versions profile is configured in Cached Exchange Mode and you add another user's mailbox or shared folder to your profile, all items in all the folders to which you have access in the shared mailbox are downloaded to your local cache. This is a change from Microsoft Office Outlook 2007, in which only shared non-mail folder items are cached by default.

For example, the following figure shows the shared Inbox folder of a user. You can identify that the Inbox folder is being cached in Outlook because the status bar displays **Connected** when this folder is selected in the navigation pane.

:::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/example-of-cached-shared-mailbox.png" alt-text="Screenshot of an example of a shared mailbox that's being cached.":::

Mail folders typically contain more items that non-mail folders. In earlier versions of Outlook, when hard disk space was at a premium, Outlook defaulted to only caching non-mail folders. With hardware advancements, disk sizes and speeds increased expontentially. This lowered the impact of caching more data locally, thus later versions of Outlook were changed to also cache mail folders by default. Downloading shared folders locally generally improves the performance when working with those folders. This is because Outlook reads this folder data from your local disk instead of connecting to the Exchange Server to retrieve the shared folders. The performance improvement of downloading shared folders can be even greater when compared to the time it takes for Outlook to retrieve shared folder data that is located on an Exchange Online mailbox in Microsoft 365.

It is important to note that various group policies and registry settings can be used to change the defaults. Some of these policies and registry values may have improved the shared folder performance in earlier versions of Outlook or when the shared folders were on Exchange Server on-premises mailboxes, but those performance gains may be lost in recent Outlook versions or after mailboxes are moved to Microsoft 365 cloud tenants. If you experience performance issues when using shared folders in Outlook, it may be necessary to remove some of the registry values that were previously set on your Windows PC. Contact your administrator to determine if one or more of these group policies are set in your organization and to test Outlook without them.

## More Information

The following registry values and policies control how Outlook uses shared folders.

The *CacheOthersMail* registry value can be configured to only cache non-mail folders such as the Calendar, Contacts, and Tasks folders.

Key:

HKEY_CURRENT_USER\Software\Microsoft\Office\<xx.0>\Outlook\Cached Mode

or

HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<xx.0>\Outlook\Cached Mode

Note The <xx.0> placeholder represents the version of Office (16.0 = Office 2016, Office 2019, or Outlook for Office 365, 15.0 = Office 2013).

Name: CacheOthersMail  
Type: DWORD:  
Value: 0

The default value is 1.

> [!NOTE]
> If the registry value exists in the `\Policies` registry key, the settings applies to all existing Outlook profiles. If the registry value exists in the non-Policies key, it only applies to new Outlook profiles that are created.

This registry data can be set using one or more of the following methods:

- Manually configured in the Windows Registry.
- Administrator controlled registry setting using a Group Policy.
- Deployed using the Office Customization Tool.

Regardless of the method used, if the caching of shared mail folders is disabled, the Outlook status bar displays **Online** when you select a shared mail folder in another mailbox in the navigation pane. This is illustrated in the following figure.

:::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/outlook-status-bar-shows-online.png" alt-text="Screenshot of an example of Outlook status bar which displays Online.":::

In this configuration, items in mail folders are not available when you are working offline in Outlook. However, items in non-mail folders are still available when you are working offline in Outlook.

### Method 1 - Manual modification of the Windows Registry

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To change the shared folder caching behavior in Outlook 2013 or later versions, you must add a registry value to your Outlook client, or edit a registry value if it exists. To do this, follow these steps:

1. Exit Outlook.
2. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows.
   - Windows 10 and Windows 8: Press Windows Key+R to open a Run dialog box. Type **regedit.exe** and then press **OK**.
   - Windows 7 and Windows Vista: Select **Start**, type *regedit.exe* in the search box, and then press Enter.

3. Locate and then select the registry key: `HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Outlook\Cached Mode`

    > [!NOTE]
    > The xx.0 placeholder represents the version of Office (16.0 = Office 2016, Office 2019, or Outlook for Office 365, 15.0 = Office 2013).
    >
    > If the **Cached Mode** key does not exist, create this key by following these steps:
    >
    > 1. Select the **Outlook** key.
    > 2. On the **Edit** menu, point to **New**, and then select **Key**.
    > 3. Type **Cached Mode**, and then press ENTER.
    > 4. Select the **Cached Mode** key and then go to step 4.

4. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
5. Type *CacheOthersMail*, and then press ENTER.
6. On the **Edit** menu, select **Modify**.
7. Type *0* to only cache shared, non-mail folders, or type *1* to cache all shared folders, and then select **OK**.
8. Exit Registry Editor.
9. Start Outlook.

> [!NOTE]
> This method only affects any new Outlook profiles that you create. To change the behavior for all existing Outlook profiles, change the registry value in the following registry key path:
>
> `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\\<xx.0>\Outlook\Cached Mode`
>
> The <xx.0> placeholder represents the version of Office (*16.0* = Office 2016, Office 2019, or Outlook for Office 365, *15.0* = Office 2013).

### Method 2 - Configure the registry by using a Group Policy setting

The registry key value that is required to change the default shared folder caching behavior in Outlook can be configured by using a Group Policy setting. These steps are typically performed by an Active Directory administrator.

#### Outlook 2013 or later versions

The default Group Policy template files for Outlook contain the policy setting that controls this functionality. These are Outlk16.admx and Outlk16.adml for Outlook 2016, Outlook 2019 and Outlook for Office 365 and Outlk15.admx and Outlk15.adml for Outlook 2013.

To deploy this setting by using the Outlook Group Policy template, follow these steps:

1. Download the following file from the Microsoft Download Center:

   - Office 2016, Office 2019, or Outlook for Office 365: [Administrative Template files (ADMX/ADML) and Office Customization Tool for Microsoft 365 Apps for enterprise, Office 2019, and Office 2016](https://www.microsoft.com/download/details.aspx?id=49030)
   - Office 2013: [Office 2013 Administrative Template files (ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=35554) 

2. Extract the admintemplates_32bit.exe or admintemplates_64bit.exe file to a folder on your disk.
3. Copy the file appropriate to your version of Outlook to the C:\Windows\PolicyDefinitions folder.

    Office 2016, Office 2019, or Outlook for Office 36: Outlk16.admx  
    Office 2013: Outlk15.admx

4. Copy the file appropriate to your version of Outlook to the C:\Windows\PolicyDefinitions\\*xx-xx*

    Office 2016, Office 2019, or Outlook for Office 36: Outlk16.adml  
    Office 2013: Outlk15.adml

   where *xx-xx* is a Language Culture Name. For example, for English (US), the Language Culture Name is en-us. For more information about Language Culture Names, see [Table of Language Culture Names, Codes, and ISO Values [C++]](/previous-versions/commerce-server/ee797784(v=cs.20)).

    > [!NOTE]
    > The .adml file must be copied from the correct language folder.

5. Start the Group Policy Object Editor or the Group Policy Management Console.

    > [!NOTE]
    > Because you may be applying the policy setting to an organizational unit and not to the whole domain, the steps may also vary in this aspect of applying a policy setting. Therefore, check your Windows documentation for more information.

6. In the Group Policy Object Editor or the Group Policy Management Console, under **User Configuration**, expand **Administrative Templates**, expand your version of **Microsoft Outlook**, expand **Outlook Options**, and then select the **Delegates** node.

    Screenshot for Outlook 2013:

    :::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/disable-shared-mail-folder-caching.png" alt-text="Screenshot of the Local Group Policy Editor for Outlook 2013.":::

7. Under **Delegates**, double-click **Disable shared mail folder caching**.
8. To revert to the default setting, select **Disabled**, and then select **OK**. To change to the non-default setting of only caching non-mail folders, select **Enabled**, and then select **OK**.

    At this point, the policy setting is applied on your Outlook 2013 client workstations when the Group Policy setting update is replicated. To test this change, at the command prompt, type the `gpupdate /force` command, and press Enter:

After you run this command, start Registry Editor on the client workstation to make sure that the `CacheOthersMail` registry value exists on the client, and that it has a value of **0**:

Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<xx.0>\Outlook\Cached Mode

Note The <xx.0> placeholder represents the version of Office (16.0 = Office 2016, Office 2019, or Outlook for Office 365, 15.0 = Office 2013).

Name: CacheOthersMail  
Type: DWORD:  
Value: *x*

Where *x* is 1 to revert to the default behavior or 0 if applying the non-default setting to only cache non-mail folders.

If you see this registry data in the registry, the Group Policy setting was already applied to this client. Start Outlook to verify that this change is implemented.

### Method 3 - Deployment of the Shared Mail Folder Cache setting using the Office Customization Tool

You can use the Office Customization Tool (OCT) to deploy the Shared Mail Folder Caching setting.

#### Outlook 2013 or later versions

To deploy this setting in Outlook 2013 or later versions, use the Office Customization Tool (OCT) built-in setting. To do this, follow these steps:

> [!NOTE]
> You must have an enterprise edition of Microsoft Office to use the OCT. If you have a Retail edition of Office, you receive the following error when you try to start the OCT:Files necessary to run the Office Customization Tool were not found. Run Setup from the installation point of a qualifying product.

1. Select **Start**, type *cmd* in the **Start Search** box, and then press Enter.
2. At the command prompt, type the path to your Office installation files followed by " /admin", such as the following, and then press Enter:

   \\\Server\share\Office\Setup.exe /admin

3. In the **Select Product** dialog box, select **Create a new Setup customization file for the following product**.
4. Select the Office product in the **Select Product** dialog box, and then select **OK**.
5. In the navigation pane of the OCT, select **Modify user settings**, expand your version of **Microsoft Outlook**, expand **Outlook Options**, and then select **Delegates**.
6. Double-click the **Disable shared mail folder caching**.
7. To revert to the default setting, select **Disabled**, and then select **OK**. To change to the non-default setting of only caching non-mail folders, select **Enabled**, and then select **OK**.
8. Complete any remaining tasks in the OCT, and then save your .msp file.
9. Deploy Office with this .msp file.

> [!NOTE]
> This method only affects any new Outlook profiles that you create. To change the behavior for all existing Outlook profiles, add the registry value in the following registry key path:
>
> `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\\<xx.0>\Outlook\Cached Mode`
>
> The <xx.0> placeholder represents the version of Office (*16.0* = Office 2016, Office 2019, or Outlook for Office 365, *15.0* = Office 2013).

### Disable Download of All Shared Folders

It is possible that caching of *all* shared folders has been disabled for Cached mode profiles. This would include both shared mail folders and shared non-mail folders. This setting is available in the OCT and in the Group Policy template.

#### OCT

In the OCT for Outlook 2013 and later versions, the setting that controls the caching of all shared folders is located under **Modify user settings**, your version of Microsoft Outlook, Account Settings, Exchange, Cached Exchange Mode, and the setting is named Download shared non-mail folders.

The following figure shows this setting in the Outlook 2010 OCT.

:::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/settings-in-office-customization-tool.png" alt-text="Screenshot shows the setting in the Outlook OCT.":::

When the OCT is used to disable this setting, the following registry key value is configured on Outlook clients.

Key: HKEY_CURRENT_USER\Software\Microsoft\Office\\<xx.0>\Outlook\Cached Mode

Note The <xx.0> placeholder represents the version of Office (*16.0* = Office 2016, Office 2019, or Outlook for Office 365, *15.0* = Office 2013).

Name: DownloadSharedFolders  
Type: DWORD  
Value: 0

If the value is set to 0, this indicate that a non-default setting is configured.

#### Group Policy Template

In the Group Policy Template for Outlook 2010 and later versions, the setting that controls the caching of all shared folders is located under User Configuration, Administrative Templates, your version of Microsoft Outlook, Account Settings, Exchange, Cached Exchange Mode, and the setting is named Download shared non-mail folders.

The following figure shows the Group Policy Management Editor that controls this setting in Outlook 2010.

:::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/setting-in-local-group-policy-editor.png" alt-text="Screenshot shows the Group Policy Management Editor that controls this setting in Outlook.":::

When you use a Group Policy setting to disable this setting, the following registry key value is configured on your Outlook 2010 client.

Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\\<xx.0>\Outlook\Cached Mode

Note The <xx.0> placeholder represents the version of Office (16.0 = Office 2016, Office 2019, or Outlook for Office 365, 15.0 = Office 2013).

Name: DownloadSharedFolders  
Type: DWORD  
Value: 0

If the value is set to 0, this indicate that a non-default setting is configured.

### Effect on the size of the Offline Outlook Data (.ost) file

If Outlook is configured to download shared folders, the contents of the shared folders are stored in your local Offline Outlook Data (.ost) file. If the shared folders contain many items or large attachments, your .ost file size may grow significantly.

Additionally, Outlook 2013 introduced support for Site Mailboxes. The Site Mailboxes feature requires Exchange Server 2013 or later versions and SharePoint 2013 or later versions. If you are working in one of these environments and are granted permission to a site mailbox, the site mailbox is automatically added to Outlook 2013 or later versions. If you have *Download Shared Folders* enabled, the site mailbox contents are synchronized to your local .ost file. This can result in a significantly larger .ost file.

The best Outlook client performance can vary from user to user, based on their configuration, the number of shared folders being accessed, the location of those shared mailboxes, etc. Only by testing with and without the default download shared folder options can the optimal settings be determined for each user.

For more information about large Outlook data files and performance, see [You may experience application pauses if you have a large Outlook data file](https://support.microsoft.com/help/2759052).

If the size of your .ost file is restricted by policies, caching shared folders may result in the .ost file size limit being reached. For more information about policies that administrators may use to limit the size of Outlook data files, see [How to configure the size limit for both (.pst) and (.ost) files in Outlook](https://support.microsoft.com/help/832925).
