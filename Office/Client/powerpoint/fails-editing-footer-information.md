---
title: Unable to edit footer when you open a PowerPoint presentation
description: Describes a behavior that occurs because PowerPoint 2007 handles footer information differently than earlier versions of PowerPoint do.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article 
ms.author: v-six
appliesto:
- PowerPoint 2007
---

# Can't edit footer information in the "Header and Footer" dialog in a PowerPoint presentation

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

Consider the following scenario. In Microsoft Office PowerPoint 2007, you save a presentation that contains footer information. This presentation was created in Microsoft Office PowerPoint 2003 or in an earlier version of PowerPoint.

When you open the presentation in PowerPoint 2003 or in an earlier version of PowerPoint, the footer information is displayed in a text box. You cannot edit the footer information in the **Header and Footer** dialog box.

## Cause

This behavior occurs because PowerPoint 2007 handles the footer field differently than earlier versions of PowerPoint do.

## Status

This behavior is by design.

## More Information

In PowerPoint 2003 and in earlier versions of PowerPoint, the display location of the footer field is fixed. The footer field is configured as a special field that can be edited only in the **Header and Footer** dialog box.

In PowerPoint 2007, the footer field is configured as a text box that cannot be edited in the **Header and Footer** dialog box. However, in PowerPoint 2007, you can directly set the location or the format of the footer field for each slide without using a slide master.

In PowerPoint 2007, when you open a presentation that has footer information and that was created in PowerPoint 2003 or in an earlier version of PowerPoint, you can see the footer settings in the **Header and Footer** dialog box. Additionally, you can see that these settings are the same as the footer settings in earlier versions of PowerPoint.

However, if you save the presentation in PowerPoint 2007 and then reopen it in an earlier version of PowerPoint, you cannot see the footer settings in the **Header and Footer** dialog box. Additionally, the footer information is displayed in a text box. This behavior occurs because the footer field is saved as a text box in PowerPoint 2007.

### Steps to reproduce the behavior

1. Start PowerPoint 2003.
2. On the **View** menu, click **Header and Footer**.
3. In the **Header and Footer** dialog box, click to select the **Date and time** check box on the **Slide** tab, click to select the **Update automatically** check box, click to select the **Footer** check box, and then type any characters in the box.
4. Click **Apply**.

   Notice that the footer setting is applied.

5. On the **File** menu, click **Save**.
6. In the **Save As** dialog box, type a name in the **File name** box, and then click **Save**.
7. On the **File** menu, click **Exit** to exit PowerPoint 2003.
8. Start PowerPoint 2007.
9. Click the **Microsoft Office Button**, and then click **Open**.
10. In the **Open** dialog box, click the file that you saved in step 6, and then click **Open**.
11. In the **Text** group on the **Insert** tab, click **Header & Footer**.

    The **Header and Footer** dialog box appears. Notice that all the settings that you set in PowerPoint 2003 are applied.

12. In the **Header and Footer** dialog box, click **Cancel**.
13. Click the **Microsoft Office Button**, and then click **Save**.
14. Click the **Microsoft Office Button**, and then click **Exit PowerPoint**.
15. Start PowerPoint 2003.
16. On the **File** menu, click **Open**.
17. In the **Open** dialog box, click the file that you saved in PowerPoint 2007, and then click **Open**.
18. On the **View** menu, click **Header and Footer**.

    Notice that the footer information is displayed in a text box. You cannot edit this information in the **Header and Footer**dialog box.