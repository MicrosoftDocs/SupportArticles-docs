---
title: The Open new side note icon is missing from the Windows notification area
description: Explains that the Open new side note icon is missing from the taskbar. Requires that you clear the Place OneNote icon in the notification area of the taskbar check box, restart the program, and then recheck the check box.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
ms.custom: CSSTroubleshoot
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Microsoft Office OneNote
---

# The "Open new side note" icon is missing from the Windows notification area in OneNote

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

##  Symptoms

When you start Microsoft Windows, the Microsoft Office OneNote **Open new side note** icon may be missing from the Windows notification area.

##  Cause

This problem may occur if one of the following conditions is true: 


- You removed and reinstalled OneNote.

  -or-   
- You removed the **Open new side note** icon in the Windows notification area.

  -or-

- On Windows 7, click the Show hidden icons arrow in the notification area to see the OneNoteicon.   


##  Resolution

To resolve this problem, follow these steps: 

1. Start OneNote.   
2. In OneNote 2007 or earlier, on the **Tools** menu, click
**Options**.

   In OneNote 2010 or later, choose Options from the File menu.

3. For OneNote 2007 or earlier, in the **Category** list, click
**Other**.

   For OneNote 2010 or later in the Category list, click Display.

4. Click to clear the **Place OneNote icon in the notification area of the taskbar** check box if it is selected, and then click **OK**.   
5. Quit and then restart OneNote.   
6. In OneNote 2007 or earlier on the Tools menu, click Options. 

   In OneNote 2010 or later choose Options from the File menu. 

7. For OneNote 2007 or earlier in the Category list, click Other.

   For OneNote 2010 or later in the Category list, click Display.

8. Click to select the **Place OneNote icon in the notification area of the taskbar** check box, and then click
**OK**.   

**Important** The **Microsoft Office OneNote 2003 Quick Launch** shortcut is required for the correct operation of the quick launch functionality of Side Note. If the **Microsoft Office OneNote 2003 Quick Launch** shortcut is missing from the **Startup** folder (click **Start**, point to **All Programs**, and then point to **Start up**), run **Detect and Repair** to complete the restoration of the quick launch functionality of Side Note. To do this, follow these steps as appropriate for your situation:


1. Start OneNote 2003.   
2. On the **Help** menu, click
**Detect and Repair**.   
3. In the **Detect and Repair** dialog box, click to select the **Restore my shortcuts while repairing** check box (if it is not selected), and then click **Start**.   

**Note** In OneNote 2007 or 2010, the OneNote Screen Clipper and Launcher shortcut is automatically added to the Startup folder when you click to select the Place OneNote icon in the notification area of the taskbar check box in step 8.