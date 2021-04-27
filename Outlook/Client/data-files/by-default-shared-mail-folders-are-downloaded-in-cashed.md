---
title: Shared mail folders are downloaded in Cached mode
description: Provides details on how to disable the download of shared mail folders in Cached mode in Outlook 2010 and later versions. By default, Outlook 2010 and later versions download shared folders that contain mail items.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
ms.reviewer: gregmans, aruiz, tsimon, laurentc, amkanade, doakm, randyto, gbratton, bobcool
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook 2013
- Microsoft Outlook 2010
- Outlook for Office 365
search.appverid: MET150
---
# Shared mail folders are downloaded in Cached mode by default in Outlook 2010 and later versions 

_Original KB number:_ &nbsp; 982697

## Symptoms

By default, if a Microsoft Outlook 2010 or later versions profile is configured in Cached mode and you add another user's mailbox or shared folder to your profile, all items in all the folders to which you have access in the shared mailbox are downloaded to your local cache. This is a change from Microsoft Office Outlook 2007, in which only shared non-mail folder items are cached by default.

For example, the following figure shows the shared Inbox folder of Marcelo Santos. This Inbox folder is being cached in Outlook 2010 because the status bar displays **Connected** when this folder is selected in the navigation pane.

:::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/example-of-cached-shared-mailbox.png" alt-text="example of a shared mailbox that's being cached" border="false":::

## Cause

This problem is caused by a change in the default shared folder caching behavior that was introduced in Outlook 2010 and persists in later versions of Outlook.

## Resolution

To change the shared folder caching behavior in Outlook 2010 or later versions to match the default behavior in Office Outlook 2007, you must add the following registry data to your Outlook client. In this situation, only non-mail folders such as the Calendar, Contacts, and Tasks folders are cached.

Key:

HKEY_CURRENT_USER\Software\Microsoft\Office\<xx.0>\Outlook\Cached Mode

or

HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<xx.0>\Outlook\Cached Mode

Note The <xx.0> placeholder represents your version of Office (16.0 = Office 2016, Office 2019, or Outlook for Office 365, 15.0 = Office 2013, 14.0 = Office 2010).

Name: CacheOthersMail  
Type: DWORD:  
Value: 0

> [!NOTE]
> If you configure the registry value in the `\Policies` registry key, the change is applied to all existing Outlook profiles. If you configure the registry value in the non-Policies key, the change only applies to new Outlook profiles that you create.

You can use one of the following methods to configure this registry data for Outlook 2010 or later versions:

- Manually change the Windows Registry.
- Configure the registry by using a Group Policy setting.
- Deploy the Shared Mail Folder Cache setting by using the Office Customization Tool.

Regardless of the method that you use, if you disable the caching of shared mail folders, the Outlook status bar displays **Online** when you select a shared mail folder in another mailbox in the navigation pane. This is illustrated in the following figure.

:::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/outlook-status-bar-shows-online.png" alt-text="example of Outlook status bar displays Online" border="false":::

In this configuration, items in mail folders are not available when you are working offline in Outlook. However, items in non-mail folders are still available when you are working offline in Outlook.

### Method 1 - Manual modification of the Windows Registry

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To change the shared folder caching behavior in Outlook 2010 or later versions to match the default behavior in Office Outlook 2007, you must add a registry value to your Outlook client. To do this, follow these steps:

1. Exit Outlook.
2. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows.
   - Windows 10 and Windows 8: Press Windows Key+R to open a Run dialog box. Type **regedit.exe** and then press **OK**.
   - Windows 7 and Windows Vista: Select **Start**, type *regedit.exe* in the search box, and then press Enter.

3. Locate and then select the registry key: `HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Outlook\Cached Mode`

    > [!NOTE]
    > The xx.0 placeholder represents your version of Office (16.0 = Office 2016, Office 2019, or Outlook for Office 365, 15.0 = Office 2013, 14.0 = Office 2010).
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
7. Type *0*, and then select **OK**.
8. Exit Registry Editor.
9. Start Outlook.

> [!NOTE]
> This method only affects any new Outlook profiles that you create. To change the behavior for all existing Outlook profiles, add the registry value in the following registry key path:
>
> `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\\<xx.0>\Outlook\Cached Mode`
>
> The <xx.0> placeholder represents your version of Office (*16.0* = Office 2016, Office 2019, or Outlook for Office 365, *15.0* = Office 2013, *14.0* = Office 2010).

### Method 2 - Configure the registry by using a Group Policy setting

The registry key value that is required to change the default shared folder caching behavior in Outlook 2010 or later versions can be configured by using a Group Policy setting

#### Outlook 2013 or later versions

The default Group Policy template files for Outlook contain the policy setting that controls this functionality. These are Outlk16.admx and Outlk16.adml for Outlook 2016, Outlook 2019 and Outlook for Office 365 and Outlk15.admx and Outlk15.adml for Outlook 2013.

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

    :::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/disable-shared-mail-folder-caching.jpg" alt-text="Screenshot for Outlook 2013" border="false":::

7. Under **Delegates**, double-click **Disable shared mail folder caching**.
8. Select **Enabled**, and then select **OK**.

    At this point, the policy setting is applied on your Outlook 2013 client workstations when the Group Policy setting update is replicated. To test this change, at the command prompt, type the `gpupdate /force` command, and press Enter:

After you run this command, start Registry Editor on the client workstation to make sure that the `CacheOthersMail` registry value exists on the client, and that it has a value of **0**:

Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<xx.0>\Outlook\Cached Mode

Note The <xx.0> placeholder represents your version of Office (16.0 = Office 2016, Office 2019, or Outlook for Office 365, 15.0 = Office 2013).

Name: CacheOthersMail  
Type: DWORD:  
Value: 0

If you see this registry data in the registry, the Group Policy setting was already applied to this client. Start Outlook 2013 to verify that this change is implemented.

#### Outlook 2010

The default Group Policy template (Outlk14.adm) for Outlook 2010 does not contain the policy setting that controls this functionality. Therefore, you must use a custom Group Policy template to manage this functionality.

To deploy this setting by using a custom Group Policy template, follow these steps:

1. Download the following file from the Microsoft Download Center:

    [https://download.microsoft.com/download/2/1/F/21FB30E6-C526-4B65-BAF1-7FE0E2252879/outlk14-DisableCachingSharedMailFolders.zip](https://download.microsoft.com/download/2/1/f/21fb30e6-c526-4b65-baf1-7fe0e2252879/outlk14-disablecachingsharedmailfolders.zip)

    > [!NOTE]
    > The custom .adm template contains the following text.

    > CLASS USER  
    > CATEGORY !!L_MicrosoftOfficeOutlookCachedSharedMailFolders  
    > POLICY !!L_TurnOnOffSharedMailFolderCaching  
    > KEYNAME "Software\Policies\Microsoft\Office\14.0\Outlook\Cached Mode"  
    > EXPLAIN !!L_TurnOnOffSharedMailFolderCachingExplain  
    > VALUENAME "CacheOthersMail"  
    > VALUEON NUMERIC 0  
    > VALUEOFF NUMERIC 1  
    > END POLICY END CATEGORY  
    > [strings]  
    > L_MicrosoftOfficeOutlookCachedSharedMailFolders="Outlook 2010 Shared Mail Folder Caching"  
    > L_TurnOnOffSharedMailFolderCaching="Disable shared mail folder caching"  
    > L_TurnOnOffSharedMailFolderCachingExplain="This policy controls the caching of shared mail folders in Outlook 2010 \n \n By default, Outlook 2010 caches shared mail and non-mail (Calendar, Contacts, Tasks) to which you have access.\n \n Enable this policy to configure Outlook to only cache shared non-mail folders. This mirrors the default shared folder caching behavior in Outlook 2007.\n \n If you disable this policy or do not configure this policy, shared mail and non-mail folders to which you have access are cached in your .ost file when you add another mailbox to your profile."

2. Add the Outlk14-DisableCachingSharedMailFolders.adm file to the Group Policy Object Editor or to the Group Policy Management Console.

    > [!NOTE]
    > The steps to add the .adm file to the Group Policy Object Editor or the Group Policy Management Console vary, depending on the version of Windows that you are running. Also, because you may be applying the policy setting to an organizational unit and not to the whole domain, the steps may also vary in this aspect of applying a policy setting. Therefore, check your Windows documentation for more information.

    Go to step 3 after you add the .adm template to the Group Policy Object Editor or to the Group Policy Management Console.

3. In the Group Policy Object Editor or the Group Policy Management Console, under **User Configuration**, expand **Classic Administrative Templates (ADM)** to locate the policy node for your custom template. By using the custom *.adm template that is provided in step 1, this node is named **Outlook 2010 Shared Mail Folder Caching**.

    :::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/the-disable-shared-mail-folder-caching-setting.png" alt-text="Outlook 2010 Shared Mail Folder Caching" border="false":::

4. Under **Outlook 2010 Shared Mail Folder Caching**, double-click **Disable shared mail folder caching**.
5. Select **Enabled**, and then select **OK**.

    At this point, the policy setting is applied on your Outlook 2010 client workstations when the Group Policy setting update is replicated. To test this change, at the command prompt, type the `gpupdate /force` command, and press Enter.

After you run this command, start Registry Editor on the client workstation to make sure that the CacheOthersMail registry value exists on the client, and that it has a value of **0**:

Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0\Outlook\Cached Mode

Name: CacheOthersMail  
Type: DWORD:  
Value: 0

If you see this registry data in the registry, the Group Policy setting was already applied to this client. Start Outlook 2010 to verify that this change is implemented.

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
5. In the navigation pane of the OCT, select **Modify user settings**, expand your version of **Microsoft Outlook**, expand **Outlook Options**, and then select **Delegates**.
6. Double-click the **Disable shared mail folder caching**.
7. Select **Enabled**, and then select **OK**.
8. Complete any remaining tasks in the OCT, and then save your .msp file.
9. Deploy Office with this .msp file.

> [!NOTE]
> This method only affects any new Outlook profiles that you create. To change the behavior for all existing Outlook profiles, add the registry value in the following registry key path:
>
> `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\\<xx.0>\Outlook\Cached Mode`
>
> The <xx.0> placeholder represents your version of Office (*16.0* = Office 2016, Office 2019, or Outlook for Office 365, *15.0* = Office 2013).

#### Outlook 2010

To deploy this setting in Outlook 2010, use the **Add registry entries** option in the Office Customization Tool (OCT). To do this, follow these steps:

> [!NOTE]
> You must have an Enterprise edition of Microsoft Office 2010 to use the OCT. If you have a Retail edition of Office 2010, you receive the following error when you try to start the OCT:Files necessary to run the Office Customization Tool were not found. Run Setup from the installation point of a qualifying product.

1. Select **Start**, type *cmd* in the **Start Search** box, and then press Enter.
2. At the command prompt, type the following, and then press Enter:

   \\\Server\share\Office2010\Setup.exe /admin

3. In the **Select Product** dialog box, select **Create a new Setup customization file for the following product**.
4. Select the Office product in the **Select Product** dialog box, and then select **OK**.
5. In the navigation pane of the OCT, select **Modify user settings**, and then select **Add**.
6. In the **Add/Modify Registry Entry** dialog box, make the following changes, and then select **OK**.

   1. **Root**: **HKEY_CURRENT_USER**  
   2. **Date type**: **REG_DWORD**  
   3. **Key**: Software\Microsoft\Office\14.0\Outlook\Cached Mode
   4. **Value name**: CacheOthersMail
   5. **Value data**: 0

   The following figure displays these changes that were made in the **Add/Modify Registry Entry** dialog box.

    :::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/add-modify-registry-entry.png" alt-text="Add/Modify Registry Entry" border="false":::

    After you select **OK** in the **Add/Modify Registry Entry** dialog box, the OCT displays this registry data. This change is displayed in the following figure.

    :::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/change-shown-in-office-customiztion-tool.png" alt-text="results of Add/Modify Registry Entry" border="false":::

7. Complete any remaining tasks in the OCT, and then save your .msp file.
8. Deploy Office 2010 with this .msp file.

> [!NOTE]
> This method only affects any new Outlook profiles that you create. To change the behavior for all existing Outlook profiles, add the registry value in the following registry key path:  
> `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0\Outlook\Cached Mode`

## More information

### Disable Download of All Shared Folders

You can disable the caching of all shared folders when you are using a Cached mode profile. This includes shared mail folders and shared non-mail folders. This setting is available in the OCT and in the Group Policy template.

#### OCT

In the OCT for Outlook 2010 and later versions, the setting that controls the caching of all shared folders is located under **Modify user settings**, your version of Microsoft Outlook, Account Settings, Exchange, Cached Exchange Mode, and the setting is named Download shared non-mail folders.

The following figure shows this setting in the Outlook 2010 OCT.

:::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/settings-in-office-customization-tool.png" alt-text="setting in the Outlook 2010 OCT" border="false":::

When you use the OCT to disable this setting, the following registry key value is configured on your Outlook client.

Key: HKEY_CURRENT_USER\Software\Microsoft\Office\\<xx.0>\Outlook\Cached Mode

Note The <xx.0> placeholder represents your version of Office (*16.0* = Office 2016, Office 2019, or Outlook for Office 365, *15.0* = Office 2013, *14.0* = Office 2010).

Name: DownloadSharedFolders  
Type: DWORD  
Value: 0

#### Group Policy Template

In the Group Policy Template for Outlook 2010 and later versions, the setting that controls the caching of all shared folders is located under User Configuration, Administrative Templates, your version of Microsoft Outlook, Account Settings, Exchange, Cached Exchange Mode, and the setting is named Download shared non-mail folders.

The following figure shows the Group Policy Management Editor that controls this setting in Outlook 2010.

:::image type="content" source="media/by-default-shared-mail-folders-are-downloaded-in-cashed/setting-in-local-group-policy-editor.png" alt-text="The figure shows the Group Policy Management Editor that controls this setting in Outlook 2010" border="false":::

When you use a Group Policy setting to disable this setting, the following registry key value is configured on your Outlook 2010 client.

Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\\<xx.0>\Outlook\Cached Mode

Note The <xx.0> placeholder represents your version of Office (16.0 = Office 2016, Office 2019, or Outlook for Office 365, 15.0 = Office 2013, 14.0 = Office 2010).

Name: DownloadSharedFolders  
Type: DWORD  
Value: 0

### Effect on the size of the Offline Outlook Data (.ost) file

If Outlook is configured to download shared folders, the contents of the shared folders are stored in your local Offline Outlook Data (.ost) file. If the shared folders contain many items or large attachments, your .ost file size may grow significantly.

Additionally, Outlook 2013 introduced support for Site Mailboxes. The Site Mailboxes feature requires Exchange Server 2013 or later versions and SharePoint 2013 or later versions. If you are working in one of these environments and are granted permission to a site mailbox, the site mailbox is automatically added to Outlook 2013 or later versions. If you have Download Shared Folders enabled, the site mailbox contents are synchronized to your local .ost file. This can result in a significantly larger .ost file.

For more information about large Outlook data files and performance, see [You may experience application pauses if you have a large Outlook data file](https://support.microsoft.com/help/2759052).

If the size of your .ost file is restricted by policies, caching shared folders may result in the .ost file size limit being reached. For more information about policies that administrators may use to limit the size of Outlook data files, see [How to configure the size limit for both (.pst) and (.ost) files in Outlook](https://support.microsoft.com/help/832925).
