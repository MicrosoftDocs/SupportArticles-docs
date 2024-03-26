---
title: Unable to cast COM object when exporting to Excel from Team Explorer 2008
description: You cannot open a work item or collection of work items in Excel using Team Explorer 2008.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft Excel
  - Visual Studio 2008
ms.date: 03/31/2022
---

# "Unable to cast COM object..." when exporting to Excel from Team Explorer 2008

## Action

Using Team Explorer 2008 you try to open a work item or collection of work items in Microsoft Excel via the menu item "Open Selection in Microsoft Excel" or "Open in Microsoft Excel".

## Result

You receive the following error message:

```asciidoc
Unable to cast COM object of type 'Microsoft.Office.Interop.Excel.ApplicationClass' to interface type 'Microsoft.Office.Interop.Excel._Application'. This operation failed because the QueryInterface call on the COM component for the interface with IID '{000208D5-0000-0000-C000-000000000046}' failed due to the following error: The interface is unknown. (Exception from HRESULT: 0x800706B5).
```

## Resolution

You may be able to resolve this error message by resetting the Visual Studio 2008 environment:

1. Open a command prompt and CD to %programfiles%\Microsoft Visual Studio 9\Common7\IDE\
(path assumes you have Visual Studio 2008 installed in the default location; adjust accordingly).
2. Execute the following command:

   **devenv.exe /ResetUserData**