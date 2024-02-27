---
title: Cannot change the location of .ost file
description: Describes and provides a workaround for an issue in which you can't change the location of the offline Outlook Data File (.ost) in Microsoft Outlook 2013 or later versions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: rakeshs
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
  - Outlook LTSC 2021
search.appverid: MET150
ms.date: 01/30/2024
---
# You can't change the location of the offline Outlook Data File (.ost) in Microsoft Outlook

_Original KB number:_ &nbsp; 2752583

## Symptoms

When you try to change the location of the offline Outlook Data File (`.ost`) in Microsoft Outlook 2013 or later versions, the **Browse** button on the **Outlook Data File Settings** page is disabled.

## Cause

This issue occurs because of the deprecation of the classic offline mode in Outlook 2013 or later versions. This mode is a legacy data access method for online mode connections to Microsoft Exchange Server.

## Workaround Method 1 - Create a new Outlook Profile and then change the location of the .ost file

1. Copy the existing `.ost` file to the new location that you want to use. If you want to create a new `.ost` file instead, you can skip this step.
2. Open **Control Panel**. To do this, use one of the following procedures, as appropriate for your version of Windows.
   - Windows 10 and Windows 8: Press Windows Key, and then type *Control Panel* and then press **OK**.
   - Windows 7: Select **Start** and then select **Control Panel**.

3. In **Control Panel**, type mail to search for the Mail item, and then open it. If there are two Mail items, choose the one that is labeled with your version of Outlook, such as Outlook 2013 or Outlook 15 for Outlook 2013, or Outlook 2016 or Outlook 16 for Outlook 2016 (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-change-the-location-of-ost-file/search-mail-item-in-control-panel.png" alt-text="Screenshot of the result after searching for the Mail item in Control Panel.":::

4. Select **Show Profiles**.
5. Select **Add** (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-change-the-location-of-ost-file/add-mail.png" alt-text="Screenshot of the Mail window which shows the add button.":::

6. In the **Profile Name** box, type the name that you want to use for the new email profile, and then select **OK** (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-change-the-location-of-ost-file/create-new-profile.png" alt-text="Screenshot of the New Profile window where you can type a profile name.":::

7. Select **Next** after Outlook finds your account information (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-change-the-location-of-ost-file/add-account-page.png" alt-text="Screenshot of the Add Account window where you can select Next after Outlook finds your account information.":::

8. After Outlook finishes the setup for your account, select the **Change account settings** option, and then select **Next** (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-change-the-location-of-ost-file/change-account-settings-option.png" alt-text="Screenshot of the Add Account window in which Outlook finishes the setup for your account.":::

9. In the **Server Settings** section, select **More Settings** (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-change-the-location-of-ost-file/more-settings.png" alt-text="Screenshot of the Add Account window with the More Settings button under the Server Settings section.":::

10. On the **Advanced** tab, select **Outlook Data File Settings** (The screenshot for this step is listed below).

    :::image type="content" source="media/cannot-change-the-location-of-ost-file/outlook-data-file-settings.png" alt-text="Screenshot of Microsoft Exchange window with Outlook Data File Settings button on the Advanced tab.":::

11. Select **Browse**, browse to the `.ost` file that you copied in step 1, and then select **Open**. If you want to create a new `.ost` file, browse to the location where you want to save the new `.ost` file, type the file name that you want to use, and then select **Open**. Outlook will create the new `.ost` file (The screenshot for this step is listed below).

    :::image type="content" source="media/cannot-change-the-location-of-ost-file/outlook-data-files-setting-browse.png" alt-text="Screenshot of the Outlook Data File Settings window with the Browse button.":::

    :::image type="content" source="media/cannot-change-the-location-of-ost-file/new-outlook-data-file.png" alt-text="Screenshot of the New Outlook data file window which shows the new .ost file.":::

12. Select **Finish** to finish the setup for your email account.
13. Open **Control Panel**, and then open the **Mail**.
14. Select **Always use this profile**, select the new profile that you created, and then select **OK** (The screenshot for this step is listed below).

    :::image type="content" source="media/cannot-change-the-location-of-ost-file/always-use-this-profile.png" alt-text="Screenshot of the Mail window with New Profile selected under Always use this profile.":::

## Workaround Method 2 - Set the ForceOSTPath registry entry to change the location of the .ost file

> [!NOTE]
> The value of the `ForceOSTPath` registry entry only works for a new Outlook profile.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To set the `ForceOSTPath` registry entry in order to change the location of the `.ost` file, follow these steps:

1. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.

2. Locate and then select the registry subkey: `HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Outlook`

   > [!NOTE]
   > The *xx*.0 placeholder represents your version of Office (16.0 = Office 2016, Microsoft 365, Office 2019, or Office LTSC 2021, 15.0 = Office 2013).

3. Right-click **Outlook**, select **New**, and then select **Expandable String Value**.
4. Type *ForceOSTPath*, and then press Enter.
5. Right-click **ForceOSTPath**, and then select **Modify**.
6. In the **Value** data box, type the full path of where you want to store the `.ost` file (such as D:\MyOST), and then select **OK**.
7. On the **File** menu, select **Exit** to exit Registry Editor.
