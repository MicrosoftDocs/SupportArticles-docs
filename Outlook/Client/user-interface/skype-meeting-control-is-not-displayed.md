---
title: Skype Meeting control is not shown
description: Resolves an issue that prevents the Skype Meeting control from being displayed on the Outlook 2016 ribbon.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Add-in error
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: sercast
appliesto: 
  - Outlook 2016
search.appverid: MET150
ms.date: 01/30/2024
---
# Skype Meeting control is not displayed on Outlook 2016

_Original KB number:_ &nbsp; 3097122

## Summary

After you install the Skype Meeting Add-in for Microsoft Office 2016 in Microsoft Outlook, the Skype Meeting control may not appear on the ribbon of a meeting request in Outlook.

## Resolution

To resolve this issue, you can manually enable the Skype Meeting Add-in for Microsoft Office 2016 in Outlook. To do this, follow these steps:

1. Start Outlook.
2. On the **File** menu, select **Options**.
3. In the navigation pane, select **Add-Ins**.
4. On the Manage menu, select **COM Add-Ins**, and then select **Go**.
5. In the **COM Add-Ins** dialog box, select the **Skype Meeting Add-in for Microsoft Office 2016** option, and then select **OK**.

If you do not see the Skype Meeting Add-in for Microsoft Office 2016 entry in the **COM Add-Ins** dialog box, see [Skype Meeting Add-in for Microsoft Office 2016 entry is missing in COM Add-Ins](#skype-meeting-add-in-for-microsoft-office-2016-entry-is-missing-in-com-add-ins) this section for the resolution. The entry should be displayed as it is in the following screenshot:

:::image type="content" source="media/skype-meeting-control-is-not-displayed/com-add-ins-window.png" alt-text="Screenshot of the Skype Meeting Add-in for Microsoft Office 2016 option in COM Add-ins dialog." border="false":::

> [!NOTE]
> You may receive the following error message during step 5:  
> **The add-in is installed for all users of the computer, and can only be connected or disconnected by an administrator.**  
> If this occurs, make sure that you are logged on to the local computer through an administrator account.

## Registry Key to enable or disable Skype Meeting Add-in

When you manually enable or disable the Skype Meeting Add-in for Microsoft Office 2016 add-in by using the **COM Add-Ins** dialog box (by using the steps in the Resolution section), the following registry data is updated:

Key: `HKEY_CURRENT_USER\Software\Microsoft\Office\Outlook\Addins\UcAddin.LyncAddin.1`  
DWORD: LoadBehavior  
Value: 3 = add-in is enabled, 2 = add-in is not enabled

## Skype Meeting Add-in for Microsoft Office 2016 entry is missing in COM Add-Ins

If you do not see the Skype Meeting Add-in for Microsoft Office 2016 entry in the **COM Add-Ins** dialog box in Outlook, the add-in may not be correctly configured in the `HKEY_LOCAL_MACHINE` hive of the registry. In this situation, follow these steps.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, back up the registry for restoration in case problems occur.

To resolve this issue, examine the applicable registry subkey for the Skype Meeting Add-in for your installation of Microsoft Office 2016.

> [!NOTE]
> These steps apply to both the 32-bit Windows client with Office 32-bit (Click-to-Run installation) and the 64-bit Windows client with Office 64-bit (Click-to-Run installation)

1. Select **Start**, type *regedit* in the **Start Search** box, and then select **OK**.
2. In Registry Editor, locate one of following subkeys, as applicable to your installation of Microsoft Office:

   - For 32-bit Windows client with Office 32-bit (Click-to-Run installation) or 64-bit Windows client with Office 64-bit (Click-to-Run installation):

     `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Registry\Machine\Software\Microsoft\Office\Outlook\Addins\UcAddin.LyncAddin.1`
   - For 64-bit Windows client with Office 32-bit (Click-to-Run installation):

     `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Registry\Machine\Software\Wow6432Node\Microsoft\Office\Outlook\Addins\UcAddin.LyncAddin.1`
   - For 32-bit Windows client with Office 32-bit (MSI installation) or 64-bit Windows client with Office 64-bit (MSI installation):

     `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Outlook\Addins\UcAddin.LyncAddin.1`
   - For 64-bit Windows client with Office 32-bit (MSI installation):

     `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\Outlook\Addins\UcAddin.LyncAddin.1`

3. In the details pane, double-click **LoadBehavior**. If the value in the **Value data** box is not **3**, change it to **3**, and then select **OK**.

## How to determine whether you are using a Click-to-Run or MSI installation

Select the **File** tab in Outlook, and then select **Office Account**.

:::image type="content" source="media/skype-meeting-control-is-not-displayed/office-account.png" alt-text="Screenshot shows the Office Product Information section.":::

If you see Office Updates in the Product Information area, you have a Click-to-Run installation of Office 2016.

If you do not see Office Updates in the Product Information area, you have an MSI installation of Office 2016.
