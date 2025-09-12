---
title: Can't automate Save as or Open or Upload dialog box within a web browser
description: Provides a workaround to automate the Save as, Open or Upload dialog boxes by using the Web recorder or the Web automation actions in Power Automate.
ms.reviewer: pefelesk
ms.date: 09/20/2022
ms.custom: sap:Desktop flows\UI or browser automation
---
# Can't automate the Save as, Open or Upload dialog boxes within a web browser

This article provides a workaround to automate the elements within the web browser application or the Windows' File Explorer in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5003774

## Symptoms

The **Save as**, **Open**, or **Upload** dialog box that pops up within a web browser and prompts the user to browse and select one or more files to save as, open, or upload, can't be automated through the Web recorder or the Web automation actions in Microsoft Power Automate.

## Cause

Web automation actions can interact with elements that exist within the HTML source code of the web page. However, the dialog box isn't part of the web page but comes from either the web browser application (Google Chrome, Firefox, Microsoft Edge, or Internet Explorer) or the Windows' File Explorer.

## Workaround

You can use either the Desktop recorder or the UI automation group of actions to interact with the elements within the web browser application or the Windows' File Explorer.
