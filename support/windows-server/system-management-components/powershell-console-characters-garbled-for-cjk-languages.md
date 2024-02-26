---
title: PowerShell Console characters garbled for Chinese, Japanese, and Korean languages on Windows Server 2022
description: PowerShell Console characters are garbled for Chinese, Japanese, and Korean languages on Windows Server 2022.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: slee, kryalava
ms.custom: Fix, csstroubleshoot
---
# PowerShell console characters are garbled for Chinese, Japanese, and Korean languages on Windows Server 2022

This article provides a resolution to an issue that characters in PowerShell console are garbled.

_Applies to:_ &nbsp; Windows PowerShell

## Symptom

When you launch a PowerShell console, the characters are garbled. This issue only occurs in the Chinese, Japanese, and Korean languages versions of Windows.

## Cause

By default, Windows PowerShell .lnk shortcut is hardcoded to use the "Consolas" font. The "Consolas" font doesn't have the glyphs for CJK characters, so the characters aren't rendered correctly. Changing the font to "MS Gothic" explicitly fixes the issue because the "MS Gothic" font has glyphs for CJK characters.

The Command Prompt (cmd.exe) doesn't have this issue, because the cmd .lnk shortcut doesn't specify a font. The console chooses the right font at runtime depending on the system language.

## Resolution

The issue will be fixed in Windows 11 and Windows Server 2022 very soon, but the fix won't be backported to lower versions.

To work around the issue, use either of the following two workarounds.

### Workaround 1: Launch the PowerShell from cmd.exe

Open a Command Prompt (cmd.exe) console, and then run `powershell.exe`. This opens a PowerShell console without any font issues.

### Workaround 2: Change the font in the PowerShell console

1. Start PowerShell in the normal way. Use either of the two steps:
   - Select **Start Menu**, and then select **PowerShell**.
   - Press **Windows Key** + **R** to open the Run box, type *PowerShell*, and then press Enter.
2. Right-click the top bar of the PowerShell console, select **Properties**, and then select the **Font** tab.
3. Under **Font**, select **MS Gothic**, and then select **OK**.

This should resolve the issue.
