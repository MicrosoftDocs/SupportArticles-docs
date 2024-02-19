---
title: Fingerprint Registration Wizard doesn't run
description: Describes an issue in which the Fingerprint Registration Wizard doesn't run after you install the Microsoft Fingerprint Reader and the Microsoft DigitalPersona Password Manager software and then restart the computer.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: v-jomcc, kaushika
ms.custom: sap:kerberos-authentication, csstroubleshoot
---
# Fingerprint Registration Wizard doesn't run after you install Fingerprint Reader and DigitalPersona Password Manager software and restart the computer

This article provides a solution to an issue in which the Fingerprint Registration Wizard doesn't run after you install the Microsoft Fingerprint Reader and the Microsoft DigitalPersona Password Manager software and then restart the computer.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 909129

## Symptoms

Consider the following scenario. You install the Microsoft Fingerprint Reader and the Microsoft DigitalPersona Password Manager software. Then, you restart the computer. After that, when you try to register a fingerprint with the Fingerprint Reader, the **Fingerprint Registration Wizard** doesn't run. Therefore, you can't register the fingerprint.

## Resolution

To resolve this issue, use one of the following methods.

### Method 1: Reinstall and configure the DigitalPersona Password Manager software

The first time that you log on to Windows after you install the Fingerprint Reader, the **Fingerprint Registration Wizard** is displayed so that you can start registering fingerprints. If the **Fingerprint Registration Wizard** doesn't run, verify the following things:

- Look for DPAgnt.exe on the **Processes** tab in Task Manager. To view the **Processes** tab in Task Manager, press CTRL+ALT+DEL, click **Task Manager**, and then click the **Processes** tab.
- Examine the **Startup** tab in the System Configuration Utility. DPAgnt.exe should be selected. To start the System Configuration Utility, click **Start**, click **Run**, type *msconfig.exe* in the **Open** box, and then click **OK**.
- Make sure that the user who is logged on is a member of the Administrators group.

If one or more of these things aren't verified, reinstall the DigitalPersona Password Manager software. Then, restart the computer.

For information about how to install the DigitalPersona Password Manager software, see the *Getting Started* book that came with the Fingerprint Reader.

If reinstalling the DigitalPersona Password Manager software doesn't resolve the issue, follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Click **Start**, click **Run**, type *regedit* in the **Open** box, and then click **OK** to start Registry Editor.
2. Locate and then click the following registry subkey:
    `HKEY_LOCALMACHINE\Software\Microsoft\Windows\Currentversion\Run`

3. If DPAgnt isn't present in the right pane of Registry Editor when the subkey that is mentioned in step 2 is selected, follow these steps:
      1. With the subkey that is mentioned in step 2 selected, click **New** on the **Edit** menu, and then click **String Value**.
      2. Type DPAgnt, and then press ENTER.
      3. Right-click **DPAgnt**, and then click **Modify**.
      4. In the **Value data** box, type C:\Program Files\Digitalpersona\Bin\DPAgnt.exe, and then click **OK**.
      5. On the **File** menu, click **Exit** to quit Registry Editor.
      6. Restart the computer.

### Method 2: Manually start the Fingerprint Registration Wizard

To register a fingerprint, follow these steps:

1. Log on to the Windows account.
2. Click **Start**, point to **All Programs**, point to **DigitalPersona Password Manager**, and then click **Fingerprint Registration Wizard**.
3. Follow the **Fingerprint Registration Wizard** instructions on the screen.
4. When you're finished registering fingerprints, click **Finish**.
