---
title: Error when you open gpedit.msc
description: Provides help to solve an issue where you receive an error (Resource $(string id="Win7Only)' referenced in attribute displayName could not be found) when you open gpedit.msc.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, Warrenw, ajayps
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# Error when you open gpedit.msc: Resource $(string id="Win7Only)' referenced in attribute displayName could not be found

This article provides help to solve an issue where you receive an error (Resource $(string id="Win7Only)' referenced in attribute displayName could not be found) when you open gpedit.msc.

_Applies to:_ &nbsp; Windows 10, version 1803  
_Original KB number:_ &nbsp; 4292332

## Symptom

Assume that you update the ADML and ADMX file to the Windows 10, version 1803 version. When you open gpedit.msc, you receive the following error:

> Resource $(string id="Win7Only)' referenced in attribute displayName could not be found

:::image type="content" source="media/resource-stringid-win7only-not-found/resource-referenced-in-attribute-displayname-could-not-be-found-error-1.png" alt-text="The details of the error message that's shown in the Group Policy Management Editor.":::

:::image type="content" source="media/resource-stringid-win7only-not-found/resource-referenced-in-attribute-displayname-could-not-be-found-error-2.png" alt-text="The details of the error message that's shown in User Configuration.":::

## Cause

This is a known issue. There are text updates in the Windows 10, version 1803 version of SearchOCR.ADML. However, when the changes were made, this line was cut-out of the new ADML:

`\<string id="Win7Only">Microsoft Windows 7 or later\</string>`

## Resolution

To fix this issue, download the updated ADMX package by using the following link. Then, use the updated SearchOCR.ADMX and SearchOCR.ADML files from it.

[Administrative Templates (.admx) for Windows 10 April 2018 Update (1803)](https://www.microsoft.com/download/details.aspx?id=56880)

## Workarounds

To work around this issue, follow these steps:

1. Add the missing String to the 1803 version of SearchOCR.adml.
2. Copy the old Windows 10, version 1511 version of SearchOCR.admx to the system. This file was not updated after Windows 10, version 1511 until the Windows 10, version 1803 release.

To update SearchOCR.adml, follow these steps:

> [!NOTE]
> This is for the United States English version. Other languages will have similar instructions.

1. Locate the file in the `\path\PolicyDefinitions\en-US` folder.
2. Make a backup copy of SearchOCR.adml in case that you make a mistake when editing the file.
3. Open the file in a text editor. (If you use notepad.exe, turn on the **Status** Bar on the **View** menu.)
4. Locate line 26.
5. Add a blank line. Line 26 should now be blank.
6. On the blank line 26 paste this text:

    `\<string id="Win7Only">Microsoft Windows 7 or later\</string>`

7. Save the file.
