---
title: Some context menu items don't appear
description: Fixes an issue where the Open, Print, and Edit items are missing from the context menu when you select multiple items in Windows Explorer.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:file-explorer/windows-explorer, csstroubleshoot
---
# Context menus are shortened when more than 15 files are selected

This article provides a solution to an issue where the Open, Print, and Edit items are missing from the context menu when you select multiple items in Windows Explorer.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2022295

## Symptoms

The following items may be missing from the context (right-click) menu when multiple items are selected in Windows Explorer.

- Open
- Print
- Edit

## Cause

This is by design. These context menu items won't appear if selecting more than 15 items to avoid accidentally performing these actions on a large number of files.

## Resolution

The following registry value may be modified to choose the number of files that may be selected while maintaining the context menu options.

- Path: HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer
- Name: MultipleInvokePromptMinimum
- Type: DWORD
- Default: 15 (decimal)

## More information

The registry change will go into effect after logging off and back on, or after terminating Windows Explorer (Explorer.exe) and relaunching the process.

> [!NOTE]
> A value of 16 is interpreted as unlimited for showing the options from the context menu, however it doesn't allow the actual opening of the documents selected if selecting more than 16. To allow the opening of more than 16 documents, set this key to a decimal value greater than the number of documents you wish to open. Microsoft recommends only increasing this value to a reasonable number in a controlled environment and only where users really need this value increased.
