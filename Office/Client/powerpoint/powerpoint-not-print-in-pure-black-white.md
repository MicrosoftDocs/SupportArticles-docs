---
title: PowerPoint 2013 does not print in Pure Black and White mode
description: Resolves an issue in which Powerpoint 2013 does not print in Pure Black and White mode.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: CSSTroubleshoot
ms.reviewer: Keiko Sewake (Intl Agency) 
search.appverid: 
- MET150
appliesto:
- PowerPoint 2013
---

# PowerPoint 2013 does not print in Pure Black and White mode

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

##  Symptoms

When you print a Microsoft Office PowerPoint 2013 presentation by selecting **Pure Black and White** in the print settings, the printer prints in grayscale instead.

Note This issue does not occur in Microsoft XPS Document Writer.

##  Resolution

**Important** 

Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this issue manually, follow these steps:

1. Click **Start**, type regedit in the **Start Search** box, and then click **OK**.   
2. Locate and then select the following registry subkey:
   **HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\PowerPoint**
1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.   
1. Type IgnoreDevModeColor, and then press Enter.   
1. In the **Details** pane, right-click **IgnoreDevModeColor**, and then click **Modify**.   
1. In the **Value data** box, type 1, and then click **OK**.   
1. Exit Registry Editor.   


##  More Information

To resolve this issue in PowerPoint 2010, you must apply the following hotfix or Office 2010 Service Pack 2 before you make the registry setting that is described in Method 2:

- [2466273](https://support.microsoft.com/help/2466273) Description of the PowerPoint 2010 hotfix package (powerpoint-x-none.msp) December 14, 2010
- [2687455](https://support.microsoft.com/help/2687455) Description of Office 2010 Service Pack 2