---
title: Unattended Desktop Flow Run Fails with MSEntraMachineAlwaysPromptingForPassword
description: Solves an error that occurs when you run an unattended desktop flow in Microsoft Power Automate for desktop.
ms.author: moelaabo
ms.reviewer: guco, alarnaud
ms.custom: sap:Desktop flows\Unattended flow runtime errors
ms.date: 12/09/2024
---
# An unattended desktop flow run fails with the MSEntraMachineAlwaysPromptingForPassword error

This article provides a resolution for an error that occurs when you run an unattended desktop flow in Microsoft Power Automate for desktop.

## Symptoms

Your unattended desktop flow run fails with the "MSEntraMachineAlwaysPromptingForPassword" error code (formerly "AADMachineAlwaysPromptingForPassword").

```jsonc
{
    "error":{
        "code": "MSEntraMachineAlwaysPromptingForPassword",
        "message": "Could not create unattended session with these credentials."  
    }    
}
```

:::image type="content" source="media/msentramachinealwayspromptingforpassword-error/msentramachinealwayspromptingforpassword.png" alt-text="Screenshot of the error code shown in the Body section of the Run a flow built with Power Automate for desktop page.":::

## Cause

Power Automate for desktop can't validate your Microsoft Entra ID (formerly Azure Active Directory) credentials on the machine. This issue is typically caused by a group policy setting on your machine.

## Resolution

To solve this issue, check the group policy setting on your machine.

1. Press the Windows key+<kbd>R</kbd> to open the **Run** dialog.
1. Type **gpedit.msc** and press <kbd>Enter</kbd> to open the Local Group Policy Editor.
1. Navigate to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Security**.
1. Look for the **Always prompt for password upon connection** setting.

   - If the setting is enabled, work with your IT department to disable the policy for that machine.

     > [!NOTE]
     > This value is also reflected in the registry at **Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services**. If the **fPromptForPassword** DWORD value for the **Terminal Services** key is set to **1**, the setting is enabled, and you need to work with your IT department to disable it (simply changing the registry value is generally not sufficient, as it might be reverted.)

   - If the **Always prompt for password upon connection** setting isn't enabled but you receive the error code, type **regedit** in the **Run** dialog to open the Registry Editor. In the Registry Editor, navigate to the **Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp** registry key. Then, look for the **fPromptForPassword** DWORD and set it to **0**. If the DWORD doesn't exist, create it and set its value to **0**.
