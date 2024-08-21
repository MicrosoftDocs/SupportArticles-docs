---
title: No notifications if missing Start menu shortcut
description: Describes an issue that blocks new email desktop alerts (toast notifications) in Outlook 2013 and Outlook 2016. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User Interface features and Configuration\New mail and Outlook icon in the Windows notification area
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tmoore, tasitae, gregmans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
  - Windows Server 2012 Standard
  - Windows Server 2012 R2 Standard
  - Windows 8
  - Windows 8.1
search.appverid: MET150
ms.date: 01/30/2024
---
# No desktop alerts (toast notifications) if the Outlook Start menu shortcut is missing

_Original KB number:_ &nbsp; 3014833

## Symptoms

If you have Microsoft Outlook 2013, Outlook 2016, Outlook 2019, or Outlook for Microsoft 365 running on Windows Server 2012 or Windows 8, you no longer receive new email desktop alerts (toast notifications). Additionally, Outlook is no longer listed under **Search and Apps Notifications**.

## Cause

This issue may occur for one of the following reasons:

- The Outlook shortcut is missing from the following location, depending on your version of Outlook:

    Outlook 2013: C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Office 2013

    Outlook 2016, Outlook 2019 or Outlook for Microsoft 365: C:\ProgramData\Microsoft\Windows\Start Menu\Programs\

    Desktop applications that send toast notifications must have a shortcut installed to the Start screen or in the Apps view.

- The **Remove common program groups from Start Menu** Group Policy setting is enabled.

## Resolution

To fix this issue, first you must determine whether the **Remove common program groups from Start Menu** Group Policy setting is enabled. To do this, follow these steps:

1. Exit Outlook.
2. Start Registry Editor. To do this, press Windows Key+R to open the **Run** dialog box. Type *regedit.exe*, and then press **OK**.
3. In Registry Editor, locate and then select the following subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer`

4. Locate the NoCommonGroups value, and view its data.

5. If this registry value is set to **1**, the Group Policy setting is enabled. If this value does not exist or is set to a value other than **1**, the Group Policy setting is not enabled.

6. Exit Registry Editor.

If the **Remove common program groups from Start Menu** setting is enabled, disable it.

The **Remove common program groups from Start Menu** setting is located under **User Configuration** > **Administrative Templates** > **Start Menu and Taskbar**, as shown in the following screenshot:

:::image type="content" source="media/no-desktop-alerts-(toast-notifications)-if-missing-start-menu-shortcut/remove-common-program-groups-from-start-menu.png" alt-text="Screenshot shows the location of the Remove common program groups from Start Menu setting." border="false":::

If the **Remove common program groups from Start Menu** setting is not enabled, you can fix this by running a repair of your installation of Microsoft Office.

> [!NOTE]
> To complete the repair process, you will have to restart Outlook, and you may also have to restart Windows.

To determine what type of Office installation you have, start Outlook, and then on the **File** menu, select **Office Account**. Compare the image that this generates to the following screenshots to determine the installation type of your Office suite. Notice that the MSI installation type doesn't have the **Update Options** button, whereas the Click-To-Run installation type does have the **Update Options** button.

The MSI installer displays the following:

:::image type="content" source="media/no-desktop-alerts-(toast-notifications)-if-missing-start-menu-shortcut/msi-install-info.png" alt-text="Screenshot of the Information window for MSI install.":::

The Click-To-Run installer displays the following (notice the **Update Options** button):

:::image type="content" source="media/no-desktop-alerts-(toast-notifications)-if-missing-start-menu-shortcut/click-to-run-install-info.png" alt-text="Screenshot of Information window for Click-to-Run install.":::

For information about deploying Microsoft 365 Apps, which uses Click-to-Run, see [Deployment guide for Microsoft 365 Apps](/deployoffice/deployment-guide-microsoft-365-apps).

Now, to repair your installation of Office, follow these steps:

1. Open Control Panel. To do this, select **Start** or press the **Windows** key. Type **control panel**, and then select **Control Panel** in the search results.
2. Select **Programs**, and then select **Programs and Features**.
3. Select your version of Microsoft Office, and then select **Change**.
4. Select the appropriate option for your Office installation type, as follows:
   - For an Office MSI installation, select **Repair**, and then select **Continue**.
   - For an Office Click-to-Run installation, select **Quick Repair**, and then select **Repair**.

## More information

For more information about toast notifications, see [Toast notification overview (Windows Runtime apps)](/previous-versions/windows/apps/hh779727(v=win.10)).

For more information about the Remove common program groups from Start Menu setting and the corresponding `NoCommonGroups` registry value, see [NoCommonGroups](/previous-versions/windows/it-pro/windows-2000-server/cc938264(v=technet.10)).
