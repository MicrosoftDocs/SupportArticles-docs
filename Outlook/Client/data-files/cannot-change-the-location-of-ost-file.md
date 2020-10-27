---
title: Cannot change the location of .ost file
description: Describes and provides a workaround for an issue in which you can't change the location of the offline Outlook Data File (.ost) in Microsoft Outlook 2013 or later versions.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: rakeshs
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook 2013
- Outlook for Office 365
search.appverid: MET150
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

   :::image type="content" source="media/cannot-change-the-location-of-ost-file/search-mail-item-in-control-panel.png" alt-text="type mail to search for the Mail item in Control Panel" border="false":::

4. Select **Show Profiles**.
5. Select **Add** (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-change-the-location-of-ost-file/add-mail.png" alt-text="add profile" border="false":::

6. In the **Profile Name** box, type the name that you want to use for the new email profile, and then select **OK** (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-change-the-location-of-ost-file/create-new-profile.png" alt-text="create a new email profile" border="false":::

7. Select **Next** after Outlook finds your account information (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-change-the-location-of-ost-file/add-account-page.png" alt-text="select Next on the Add Account page" border="false":::

8. After Outlook finishes the setup for your account, select the **Change account settings** option, and then select **Next** (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-change-the-location-of-ost-file/change-account-settings-option.png" alt-text="Change account settings" border="false":::

9. In the **Server Settings** section, select **More Settings** (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-change-the-location-of-ost-file/more-settings.png" alt-text="More Settings" border="false":::

10. On the **Advanced** tab, select **Outlook Data File Settings** (The screenshot for this step is listed below).

    :::image type="content" source="media/cannot-change-the-location-of-ost-file/outlook-data-file-settings.png" alt-text="Outlook Data File Settings" border="false":::

11. Select **Browse**, browse to the `.ost` file that you copied in step 1, and then select **Open**. If you want to create a new `.ost` file, browse to the location where you want to save the new `.ost` file, type the file name that you want to use, and then select **Open**. Outlook will create the new `.ost` file (The screenshot for this step is listed below).

    :::image type="content" source="media/cannot-change-the-location-of-ost-file/browse.png" alt-text="Select Browse on the Outlook Data File Settings page" border="false":::

    :::image type="content" source="media/cannot-change-the-location-of-ost-file/open.png" alt-text="open the the new .ost file" border="false":::

12. Select **Finish** to finish the setup for your email account.
13. Open **Control Panel**, and then open the **Mail**.
14. Select **Always use this profile**, select the new profile that you created, and then select **OK** (The screenshot for this step is listed below).

    :::image type="content" source="media/cannot-change-the-location-of-ost-file/always-use-this-profile.png" alt-text="Always use this profile" border="false":::

## Workaround Method 2 - Set the ForceOSTPath registry entry to change the location of the .ost file

> [!NOTE]
> The value of the `ForceOSTPath` registry entry only works for a new Outlook profile.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To set the `ForceOSTPath` registry entry in order to change the location of the `.ost` file, follow these steps:

1. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.

2. Locate and then select the registry subkey: `HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Outlook`

   > [!NOTE]
   > The *xx*.0 placeholder represents your version of Office (16.0 = Office 2016, Office 365 and Office 2019, 15.0 = Office 2013).

3. Right-click **Outlook**, select **New**, and then select **Expandable String Value**.
4. Type *ForceOSTPath*, and then press Enter.
5. Right-click **ForceOSTPath**, and then select **Modify**.
6. In the **Value** data box, type the full path of where you want to store the `.ost` file (such as D:\MyOST), and then select **OK**.
7. On the **File** menu, select **Exit** to exit Registry Editor.
