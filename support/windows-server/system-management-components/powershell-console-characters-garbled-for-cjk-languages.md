---
title: PowerShell Console characters garbled for Chinese, Japanese, and Korean languages on Windows Server 2022
description: PowerShell Console characters garbled for Chinese, Japanese, and Korean languages on Windows Server 2022.
ms.date: 08/18/2021
author: Deland_Han
ms.author: delhan 
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: slee, kryalava
ms.prod-support-area-path: PowerShell
ms.technology: windows-server-system-management-components
---
# PowerShell console characters are garbled for Chinese, Japanese, and Korean languages on Windows Server 2022

This article provides a resolution to an issue that characters in PowerShell console are garbled.

_Applies to:_ &nbsp; Windows PowerShell

## Symptom

When you launch a PowerShell console, the characters are garbled. This issue only occurs with Chinese, Japanese, and Korean languages versions of Windows.

## Cause

By default, Windows PowerShell .lnk shortcut is hardcoded to use the "Consolas" font. The "Consolas" font doesn't have the glyphs for CJK characters, so the characters aren't rendered correctly. Changing the font to "MS Gothic" explicitly fixes the issue, because the "MS Gothic" font has glyphs for CJK characters.

Cmd.exe doesn't have this issue. The cmd .lnk shortcut doesn't specify a font so the console chooses the right one at runtime depending on the system language.

## Resolution

The issue will be fixed in Windows 11 and Windows Server 2022 very soon, but the fix won't be backported to lower versions.

To work around the issue, use either of the following two workarounds.

## Workaround 1: Launch the PowerShell from cmd.exe

Start cmd.exe, and then run `powershell.exe` in the cmd console. This opens a PowerShell console without any font issues.

## Workaround 2: Change the font in the PowerShell console

Start PowerShell the normal way. Right-click the top bar of PowerShell console, select **Properties** -> **Font** tab. Under **Font**, select **MS Gothic** and select **OK**. This should resolve the issue.
