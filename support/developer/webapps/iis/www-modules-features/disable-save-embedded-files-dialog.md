---
title: Disable the Save Embedded Files dialog box
description: This article displays how the Save Embedded Files dialog can be disabled.
ms.date: 03/19/2020
ms.custom: sap:WWW modules and features
ms.reviewer: jamesche
ms.topic: how-to
ms.technology: iis-www-modules-features
---
# Disable the Save Embedded Files dialog in Expression Web 4

This article describes how you can configure Expression Web so that the **Save Embedded Files** dialog box isn't displayed.

_Original product version:_ &nbsp; Expression Web 4  
_Original KB number:_ &nbsp; 2540778

## Summary

Expression Web allows you to insert image files, style sheets, script files, and other files that are outside of the current site onto a page. When a page containing one or more external files is saved, Expression Web displays the **Save Embedded Files** dialog box and asks you to either save external files into the current site or link to the existing file on your disk.

## Disable Save Embedded Files dialog box

In cases where you want to use absolute links for external files instead of saving the files into your site, you may want to disable the **Save Embedded Files** dialog box. You can do that with the following registry key:  
`HKEY_CURRENT_USER\Software\Microsoft\Expression\Web\4.0\SaveEmbeddedFilesDisabled`

By setting the `SaveEmbeddedFilesDisabled` key to a string value of `1`, the **Save Embedded Files** dialog box will be disabled. Any other value (or the absence of the Registry key) will enable the **Save Embedded Files** dialog box. When the **Save Embedded Files** dialog box is disabled, Expression Web will use the links to the existing files on your disk.

It is not necessary to close and relaunch Expression Web after setting the `SaveEmbeddedFilesDisabled` registry key.
