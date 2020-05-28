---
title: AD FS sites are slow to open from links in Office applications
description: Fixes an issue in which hyperlinked AD FS sites are slow to open in Office applications. 
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro 
ms.topic: article
ms.prod: office-perpetual-itpro 
localization_priority: Normal
ms.custom: 
- CI 115052
- CSSTroubleshoot
ms.reviewer: bhamv
appliesto:
- Word for Office 365
- Word 2016
- Excel for Office 365
- Excel 2016
- PowerPoint for Office 365
- PowerPoint 2016
search.appverid: MET150
---
# Links in Office take at least 60 seconds to open AD FS sites

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you access Active Directory Federation Services (AD FS) sites through hyperlinks in Microsoft Office applications, the sites take a minimum of 60 seconds to open.

## Cause

This issue occurs because the following conditions are true:

- AD FS doesn't know how to handle a HEAD request that it receives from an Office application.
- AD FS tries to respond by returning an error message. However, the AD FS protocol rejects it because the HEAD response can't contain a request body.

## Resolution

The following resolution is applicable to only AD FS 4.0 and later versions.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows) in case problems occur.

To fix this issue, add the following registry key on affected client computers.

Subkey: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Common\Identity`

DWORD: **ReplaceHLinkHEADRequestWithGET**

Value: **1** (**Hexadecimal** for **Base**)
