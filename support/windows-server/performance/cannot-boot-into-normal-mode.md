---
title: Can't boot into normal mode and machine keeps booting into safe mode
description: Fixes an issue in which machines can't boot into the normal mode and keep on restarting into the safe mode.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
---
# Unable to boot into normal mode, machine keeps booting into safe mode

This article provides steps to fix an issue in which machines can't boot into the normal mode and keep on restarting into the safe mode.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2543632

## Symptoms

Machine is unable to boot into the normal mode and it keeps on restarting into the safe mode.

## Cause

This issue happens when **SAFEBOOT** option is checked in the **System Configuration Utility**, under the **Boot** tab.

## Resolution

To fix the issue, follow the steps:

Using the System Configuration Tool on Windows 2003/Windows XP:

**Step 1:** Close all programs so that you have nothing open and are at the desktop.

**Step 2:** Click the **Start** button, and then click **Run**.

**Step 3:** In the **Run** field type *msconfig* as shown in the image below.

:::image type="content" source="media/cannot-boot-into-normal-mode/run-msconfig.png" alt-text="Screenshot of the Run window with the msconfig input.":::

**Step 4:** Press the **OK** button and the **System Configuration Utility** will start up.
 You'll then see a screen similar to image below.

:::image type="content" source="media/cannot-boot-into-normal-mode/system-config-utility-window.png" alt-text="Screenshot of the System Configuration Utility window.":::

**Step 5:** Click the **BOOT.INI** tab selected by the red box in the figure above and you'll see a screen similar to image below.

:::image type="content" source="media/cannot-boot-into-normal-mode/boot-options-safeboot.png" alt-text="Screenshot of the BOOT.INI tab of the System Configuration Utility window.":::

**Step 6:** Uncheck the mark in the checkbox labeled **/SAFEBOOT** designated by the red box above. Then press the **OK** button and then the **OK** button again. Windows will now prompt if you would like to reboot. Press the **Yes** button and machine can boot into normal mode now.

> [!NOTE]
> With the **/SAFEBOOT** option checked, you'll notice an additional entry in Boot.ini file as seen below. If you see the box check for /SAFEBOOT, remove the check.

:::image type="content" source="media/cannot-boot-into-normal-mode/boot-dot-ini-file-entry.png" alt-text="Screenshot of the entry in the Boot.ini file.":::

Even though this document focuses primarily on Windows 2003 Server and Windows XP, this information applies to Windows Vista, Windows Server 2008, Windows 7, and Windows Server 2008 R2.

On the Operating System running Vista or above Boot Configuration Data Editor (Bcdedit.exe) command-line tool can be handy:

Following command will delete the **/SAFEBOOT** option and help machine boot into normal mode:

***bcdedit /deletevalue {default} safeboot***  

Open administrative command prompt to run above `bcdedit` command. For detailed command and option information at the command prompt, type ***bcdedit.exe /?*** command.

## More information

[Boot Configuration Data Editor Frequently Asked Questions](https://technet.microsoft.com/library/cc721886%28WS.10%29.aspx)
