---
title: Unable to add refedit control to VBA userform
description: Fixes the issue that you can't add a refedit control on a VBA userform.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Excel 2013
- Excel 2010
---

# Unable to add refedit control to VBA userform.

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

##  Symptoms

When trying to add a refedit control on a VBA userform the following error messages are received: 

    "%1 Could not be found". 

    "Element Could not be found". 

##  Cause

Multiple versions of refedit.dll exist on the machine.

##  Resolution

**To Resolve the error message "%1 Could not be found".**

1. Exit Excel

2. Click Start, click Run, type regedit in the Open box, and then click OK.
1. In the Registry Editor, click on Edit, choose Find
1. In the Find What dialog type in the following key:

   HKEY_Classes_Root\Wow6432Node\TypeLib\{00024517-0000-0000-C000-000000000046}\1.0
1. Export and then delete every instance of this CLSID key.
1. Repair Office in the Control Panel.
1. Restart the machine.

**To Resolve the error message "Element Could not be found".**

Step 1: Search Regstry

1. Exit Excel.
1. Click Start, click Run, type regedit in the Open box, and then click OK.
1. In the Registry Editor, click on Edit, choose Find
1. In the Find What dialog type refedit.dll
1. Export and then delete every key that refers to refedit.dll

Step 2: Search machine for dll file
1. Search the machine for refedit.dll and delete all instances
2. Repair Office in the Control Panel

Step 3: Add refedit control to the user form
1. Go to the Developer ribbon, Insert, Lower Right Corner is Additional Controls 
2. Select Additional Controls and register custom
3. Browse to C:\Program Files\Microsoft Office\Office15\Refedit.dll (for Excel 2013)
 or C:\Program Files\Microsoft Office\Office14\Refedit.dll (for Excel 2010)
4. Go to VBA and insert a userform 
5. In the toolbox choose additional controls and select refedit.ctrl 
6. Click on the refedit control in the toolbox and add it to the user form