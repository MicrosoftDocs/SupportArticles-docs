---
title: Office file previews in Windows Explorer may not show after switching from 64-bit Office to 32-bit Office
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 02/13/2020
audience: ITPro
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Office
ms.custom: 
- CI 113658
- CSSTroubleshoot 
ms.reviewer: salarson 
description: What to do if document previews don't show up after uninstalling the 64-bit version of Office and then installing the 32-bit version.
---

# Office file previews in Windows Explorer may not show after switching from 64-bit Office to 32-bit Office

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

If a 64-bit version of Office 365 is installed, then uninstalled, and then a 32-bit version of Office 365 is subsequently installed, Windows Explorer may not show document previews.  Instead, an error may be shown:

- Word : "Word could not create the work file. Check the temp environment variable."
- PowerPoint : "Access denied. Contact your administrator."
- Excel : "This file cannot be previewed."

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, back up the registry for restoration in case problems occur.

To work around this issue, delete the following registry keys:

1.    Press and hold or right-click the **Start** button, then select **Run**. 
2.    Enter regedit in the **Open:**box and select **OK**.
3.    Search for and delete the following registry keys:
    - Word Preview  : HKCR\CLSID\{84F66100-FF7C-4fb4-B0C0-02CD7FB668FE}
    - PowerPoint Preview : HKCR\CLSID\{65235197-874B-4A07-BDC5-E65EA825B718}
    - Excel Preview : HKCR\CLSID\{00020827-0000-0000-C000-000000000046}
4.    Close Registry Editor and restart Windows. 

