---
title: Lync Meeting control is not displayed on the Outlook 2013 ribbon
description: Describes how to turn on the Lync Meeting Add-in for Microsoft Office 2013 in Microsoft Outlook. Also describes how to verify that this feature is turned on by checking the system registry.
author: cloud-writer
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - Outlook 2010
  - Outlook 2013
ms.date: 01/30/2024
---

# Lync Meeting control is not displayed on the Outlook 2013 ribbon

## Symptoms

After you install the Lync Meeting Add-in for Microsoft Office 2013 in Microsoft Outlook, the Lync Meetingcontrol may not appear on the ribbon of a meeting request in Outlook. The following figure shows the expected appearance of the control on the ribbon:

:::image type="content" source="./media/lync-meeting-control-not-displayed/skype-meeting-control.png" alt-text="Screenshot of the Meeting ribbon in Outlook." border="false":::


If this behavior occurs, you can manually enable the Lync Meeting Add-in for Microsoft Office 2013 in Outlook.

## Resolution

To manually enable the Lync Meeting Add-in for Microsoft Office 2013 in Outlook, follow these steps:

1. Start Outlook.   
2. On the Filemenu, click Options.   
3. In the navigation pane, click Add-Ins.   
4. On the Managemenu, click COM Add-ins, and then click Go.   
5. In the COM Add-Ins dialog box, select the Lync Meeting Add-in for Microsoft Office 2013 check box, and then click OK.

    The following figure shows the COM Add-Insdialog box with the Lync Meeting Add-in for Microsoft Office 2013 add-in enabled:

    :::image type="content" source="./media/lync-meeting-control-not-displayed/add-in.png" alt-text="Screenshot of the COM Add-ins dialog box.":::

> [!NOTE]
> If you receive the following error message during step 5, make sure that you are logged on to the local computer through an administrator account.

The add-in is installed for all users of the computer, and can only be connected or disconnected by an administrator.

When you manually enable or disable the Lync Meeting Add-in for Microsoft Office 2013 add-in using the COM Add-Ins dialog box (see above steps), the following registry data is updated:

**Key**: HKEY_CURRENT_USER\Software\Microsoft\Office\Outlook\Addins\UcAddin.LyncAddin.1

**DWORD**: LoadBehavior

**Value**: 3 = add-in is enabled, 2 = add-in is not enabled

You can use the following steps to update this section of the registry:

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

1. Exit Outlook if it is running.   
2. Press the Windows function key, search for "regedit," and then click OK.   
3. In Registry Editor, locate the following subkey:

    **HKEY_CURRENT_USER\Software\Microsoft\Office\Outlook\Addins\UcAddin.LyncAddin.1**

4. In the details pane, double-click LoadBehavior. If the value in the Value databox is not 3, change it to 3 and then click OK.   
5. Exit Registry Editor.   
6. Start Outlook.   

### Examine the registry data under HKEY_LOCAL_MACHINE for the Lync Meeting Add-in for Office 2013 

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

If you do not see the Lync Meeting Add-in for Microsoft Office 2013 entry in the COM Add-Ins dialog box in Outlook, the add-in may not be correctly configured in the HKEY_LOCAL_MACHINE hive of the registry. Please examine one of the following hives in the registry that is applicable to your installation of Microsoft Office.

**32-bit Windows client with Office 32-bit (Click-to-Run installation) or 64-bit Windows client with Office 64-bit (Click-to-Run installation)**

1. Press the Windows function key, search for "regedit," and then click OK.   
2. In Registry Editor, locate the following subkey:

    **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\15.0\ClickToRun\Registry\Machine\Software\Microsoft\Office\Outlook\Addins\UcAddin.LyncAddin.1**   
3. In the details pane, double-click LoadBehavior. If the value in the Value databox is not 3, change it to 3 and then click OK.   

**64-bit Windows client with Office 32-bit (Click-to-Run installation)**

1. Press the Windows function key, search for "regedit," and then click OK.   
2. In Registry Editor, locate the following subkey:

    **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\15.0\ClickToRun\Registry\Machine\Software\Wow6432Node\Microsoft\Office\Outlook\Addins\UcAddin.LyncAddin.1**   
3. In the details pane, double-click LoadBehavior. If the value in the Value databox is not 3, change it to 3 and then click OK.   

#### 32-bit Windows client with Office 32-bit (MSI installation) or 64-bit Windows client with Office 64-bit (MSI installation)

1. Press the Windows function key, search for "regedit," and then click OK.   
2. In Registry Editor, locate the following subkey:

    **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Outlook\Addins\UcAddin.LyncAddin.1**   
3. In the details pane, double-click LoadBehavior. If the value in the Value databox is not 3, change it to 3 and then click OK.   

#### 64-bit Windows client with Office 32-bit (MSI installation)

1. Press the Windows function key, search for "regedit," and then click OK.   
2. In Registry Editor, locate the following subkey:

    **HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\Outlook\Addins\UcAddin.LyncAddin.1**   
3. In the details pane, double-click LoadBehavior. If the value in the Value databox is not 3, change it to 3 and then click OK.   

## More Information

To determine whether you are using a Click-to-Run or MSI installation of Office 2013, click the Filetab in Outlook, and then click Office Account.

:::image type="content" source="./media/lync-meeting-control-not-displayed/office-version.png" alt-text="Screenshot of the Product Information page of Office." border="false":::


If you see **Office Updates** under **Product Information**, you have a Click-to-Run installation of Office 2013.

If you do not see **Office Updates** under **Product Information**, you have an MSI installation of Office 2013.