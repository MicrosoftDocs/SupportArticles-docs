---
title: Unattended desktop flow run fails with MSEntraMachineAlwaysPromptingForPassword
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

:::image type="content" source="media/msentramachinealwayspromptingforpassword-error/msentramachinealwayspromptingforpassword.png" alt-text="The error code that shows in the Body section of the Run a flow built with Power Automate for desktop page.":::

## Cause

Power Automate for desktop fails to validate your Microsoft Entra ID (formerly Azure Active Directory) credentials on the machine. This issue is typically caused by a group policy setting on your machine.

## Resolution

To solve this issue, check the group policy setting on your machine.

1. Press Windows key + <kbd>R</kbd> to open the **Run** dialog.
1. Type _gpedit.msc_ and press <kbd>Enter</kbd> to open the Local Group Policy Editor.
1. Navigate to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Security**.
1. Look for the **Always prompt for password upon connection** setting.

   - If the setting is enabled, you need to work with your IT department to disable the policy for that machine.

     > [!NOTE]
     > This value is also reflected in the registry in the **Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services** path. If the **Terminal Services** key has a **fPromptForPassword** DWORD value set to **1**, it means the setting is enabled and you must work with your IT department to disable it (simply changing the registry value is generally not sufficient as it might be reverted.)

   - If the **Always prompt for password upon connection** setting isn't enabled but you receive the error code, type _regedit_ in the **Run** dialog to open the Registry Editor. In the Registry Editor, navigate to the **Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp** registry key. Then, look for the **fPromptForPassword** DWORD and set it to **0**. If that DWORD doesn't exist, you can create it and then set its value to **0**.
