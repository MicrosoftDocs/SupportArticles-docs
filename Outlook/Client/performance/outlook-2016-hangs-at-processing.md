---
title: Outlook 2016 hangs at Processing at start-up
description: Describes how to work around a problem in which Outlook 2016 hangs at the Processing stage on start-up.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Install, Update, Activate, and Deploy\Outlook Deployment issues
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook 2016 hangs at Processing on the start-up screen

_Original KB number:_ &nbsp; 3188434

## Symptoms

You start Microsoft Outlook 2016, and it hangs at the Processing stage on the startup screen. Outlook never fully starts.

## Resolution

This issue was fixed in the following updates:

- Office build 16.0.7369.2015 for Office 2016 Click-to-Run editions.
- [March 2017 update](https://support.microsoft.com/help/3178660/march-7-2017-update-for-office-2016-kb3178660) for Microsoft Installer (.msi)-based edition of Office 2016.

## Workaround Method 1 - Manually configure Outlook 2016 to always run maximized

1. Exit Outlook 2016.
2. Determine which icon you use to start Outlook, and access the **Properties** for that shortcut:

    - Icon on the Desktop

      - Right-click the Outlook icon on the Desktop, and then select **Properties**.
    - Icon pinned to the taskbar

      1. Right-click the Outlook icon on the taskbar, right-click **Outlook 2016**, and then select **Properties**.

    - Icon pinned to the **Start** menu

      1. Right-click the Outlook tile pinned to the Start menu, point to **More**, and then select **Open file location**.

      2. Right-click **Outlook 2016** in the File Explorer window that opens, and then select **Properties**.
3. In the **Outlook 2016 Properties** dialog box, select **Maximized** for Run.
4. Select **OK**.

## Workaround Method 2 - Use Group Policy to configure Outlook 2016 to always run maximized

1. Start the Group Policy Management Console.

   > [!NOTE]
   > Because you may be applying the policy setting to an organizational unit and not to the whole domain, the steps may also vary in this aspect of applying a policy setting. Therefore, check your Windows documentation for more information.

2. In the Group Policy Management Console, under **User Configuration**, expand **Preferences**, expand **Windows Settings**, and then select **Shortcuts**.
3. Create a new shortcut with the following properties:

    Name: Outlook 2016  
    Location: All Users Desktop  
    Target path: \<path of Outlook.exe>  
    Arguments: /recycle  
    Start in: \<path of Outlook.exe>  
    Run: Maximized  
    Icon file path: \<path of Outlook.exe>

    > [!NOTE]
    > The path of Outlook.exe may vary, depending on the Office installation type and bitness of Windows and Office, as follows.

    |Office installation type|Bitness of Windows and Office|Default path of Office|
    |---|---|---|
    |Click-to-Run|Same|C:\Program Files\Microsoft Office\root\Office16\|
    |Click-to-Run|Different|C:\Program Files (x86)\Microsoft Office\root\Office16\|
    |MSI|Same|C:\Program Files\Microsoft Office\Office16\|
    |MSI|Different|C:\Programs Files (x86)\Microsoft Office\Office16\|
    
    Same Bitness: Office 32-bit running on Windows 32-bit or Office 64-bit running on Windows 64-bit  
    Different Bitness: Office 32-bit running on Windows 64-bit

4. Copy the shortcut that you created, and then paste it to duplicate it.
5. Double-click the shortcut that you pasted, and then change the Location to **All Users Start Menu**. Select **OK**.
6. Copy the shortcut that you created, and then paste it to duplicate it.
7. Double-click the shortcut that you pasted, and then change the Location to **All Users Programs**. Select **OK**.

> [!NOTE]
> If a user has an Outlook 2016 shortcut pinned to their taskbar, this will not replace it. The user can unpin the shortcut from their taskbar and then re-pin it from one of the other locations after the policy is in effect.

## Workaround Method 3 - Manually delete the Outlook Frame value from the registry

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Exit Outlook 2016.
2. Use one of the following procedures to start Registry Editor.

   - Windows 10, Windows 8.1, and Windows 8: Press Windows Key+R to open a **Run** dialog box. Type *regedit.exe*, and then select **OK**.
   - Windows 7: Select **Start**, type *regedit.exe* in the search box, and then press Enter.

3. In Registry Editor, locate and then select the following subkey in the registry:

   `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook\Office Explorer`

4. In the details pane, select the **Frame** value.
5. On the **Edit** menu, select **Delete**.
6. Select **Yes** to confirm that you want to delete this value.
7. Exit Registry Editor.
8. Start Outlook 2016.

> [!NOTE]
> You may have to follow these steps again if the issue occurs repeatedly. If you find the issue occurs frequently, it might be better to use a different method to work around the issue.

## Workaround Method 4 - Create a .reg file to reset the Outlook Frame value in the registry

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Start Notepad.
2. Copy the following text and paste it into Notepad:

    Windows Registry Editor Version 5.00  
    [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook\Office Explorer]  
    "Frame"=hex:

3. On the **File** menu, select **Save As**.
4. Browse to a convenient location to create the .reg file, such as the Desktop.
5. For Save as type, select **All Files (*.*)**.
6. Enter a file name and the file name extension .reg, such as *Reset Outlook Frame.reg*.
7. Select **Save**.
8. When the issue occurs, exit Outlook and then double-click the .reg file to reset the Outlook Frame value to work around the issue.

## Workaround Method 5 - Use Group Policy to delete the Outlook Frame value from the registry

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Start the Group Policy Management Console.

   > [!NOTE]
   > Because you may be applying the policy setting to an organizational unit and not to the whole domain, the steps may vary in this aspect of applying a policy setting. Check your Windows documentation for more information.

2. In the Group Policy Management Console, under **User Configuration**, expand **Preferences**, expand **Windows Settings**, and then select **Registry**.
3. Create a registry item that has the following properties:

   **Action:** Delete
   **Hive:** HKEY_CURRENT_USER
   **Key Path:** SOFTWARE\Microsoft\Office\16.0\Outlook\Office Explorer
   **Value Name:** Frame
4. Select **OK**.

## Workaround Method 6 - Use a logon script to delete the Outlook Frame value from the registry

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

Include the following PowerShell command in your logon script:

```powershell
remove-itemproperty 'HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Office Explorer' -Name Frame
```
