---
title: Computer not joined Microsoft Entra or domain or MachineNotJoined
description: Solves errors that occur when you create a desktop flow connection using the connect with sign-in option in Microsoft Power Automate for desktop.
author: 
ms.author: moelaabo
ms.reviewer: guco
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
ms.date: 11/06/2024
---
# Desktop flow failing with AADMachineAlwaysPromptingForPassword error code

## Symptoms

Your desktop flow unattended runs fail with the error code AADMachineAlwaysPromptingForPassword as shown in the screenshot below.

:::image type="content" source="media/msentramachinealwayspromptingforpassword-error/addmachinealwayspromptingforpassword.png" alt-text="The error code that shows in the Body seciton of the Run a flow built with Power Automate for desktop page.":::

## Cause

Power Automate for desktop failed to validate your Azure Active Directory credentials on the machine. This is typically caused by a group policy setting on your machine.

## Resolution

To see if a group policy setting is causing the issue, you can go to the Local Group Policy Editor (Start > Run > "gpedit.msc"). From within there, look at Local Computer Policy > Computer Configuration > Administrative Templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > Security, and look at the value "**Always prompt for password upon connection**". If this is set to true, you need to work with your IT department to disable the policy for that machine. Note that this value is also reflected in the registry in the following path: **Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services**; if the Terminal Services key has a value **fPromptForPassword** set to 1, it means the setting is enabled and you must work with your IT department to disable it (simply changing the registry value is generally not sufficient as it may be reverted).

If "Always prompt for password upon connection" is not enabled yet you are still experiencing the error, then use regedit to open the following registry key: **Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp**. Then look for the DWORD **fPromptForPassword** and set it to 0; if that DWORD does not exist you can create it.
