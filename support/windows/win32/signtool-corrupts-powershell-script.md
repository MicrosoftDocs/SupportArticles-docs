---
title: SignTool may corrupt PowerShell script file
description: This article provides resolutions for the PowerShell script file corruption that occurs when you use SignTool to sign the file that already contains a digital signature.
ms.date: 06/11/2025
ms.custom: sap:Security Development\Certificate API
ms.reviewer: mstanley
author: HaiyingYu
ms.author: haiyingyu
---

# PowerShell script files re-signed with SignTool may be corrupted

_Applies to:_ &nbsp; Windows SDK for Windows 10  

## Symptoms

Assume that you made changes to a Windows PowerShell script file (.ps1) that already has a digital signature. The script file may be corrupted after using SignTool ([SignTool.exe](/windows/win32/seccrypto/signtool)) to add a new signature.

## Cause

When using SignTool to sign a script file for the first time, a carriage return and a line feed are added at the end of the file before the signature is added. When using SignTool to add a new signature to the file, the old signature and the two characters before the signature are deleted. SignTool may corrupt the script if the two characters before the signature are not the carriage return and line feed characters added when the script was signed. This can occur when editing the script file after it has been signed using an editor that replaces carriage return and line feed pairs with a line feed character.  

## Workaround

Remove the existing signature before signing the file.
