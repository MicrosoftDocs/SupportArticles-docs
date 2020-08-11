---
title: File size  of an existing PowerPoint presentation increases
description: Describes the issue where the presentation file size increases when you save the presentation using PowerPoint.
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
- PowerPoint 2003
- PowerPoint 2002
---

# File size of an existing presentation increases when saving the presentation in PowerPoint

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you open and then save an existing Microsoft PowerPoint presentation, the file size of the presentation may increase by several megabytes.

## Cause

This issue occurs when the following conditions are true:

- You open a Microsoft PowerPoint 97 or a Microsoft PowerPoint 2000 presentation in Microsoft Office PowerPoint 2007, in Microsoft Office PowerPoint 2003, or in Microsoft PowerPoint 2002.
- The presentation has one or more embedded fonts.

Embedded fonts are typically only a subset of the full font set. When you save an existing PowerPoint 97 or PowerPoint 2000 presentation in PowerPoint 2007, in PowerPoint 2003, or in PowerPoint 2002, the full font set is embedded instead of the smaller font subset of the characters.

If the **Embed TrueType fonts** check box was selected when the PowerPoint 97 or PowerPoint 2000 presentation was saved, PowerPoint automatically embeds a subset of the fonts that are being used. However, this setting is saved with the presentation.

## Workaround

To work around this issue, you must manually select the **Embed characters that are used** option for each presentation. To do this, follow these steps, as appropriate for the version of PowerPoint that you are running.

### PowerPoint 2003 or PowerPoint 2002

1. Open the PowerPoint 97 or PowerPoint 2000 presentation.
2. On the **Tools** menu, click **Options**.
3. Click the **Save** tab.
4. Under the **Embed TrueType fonts** check box, click **Embed characters that are used only**.
5. Click **OK**.

### PowerPoint 2007

1. Open the PowerPoint 97 or PowerPoint 2000 presentation.
2. Click the **Microsoft Office Button** ![Microsoft Office Button](./media/presentation-file-size-increases/office-button.png), and then click **PowerPoint Options**.
3. Click **Save**, and then click to select the **Embed fonts in the file** check box.
4. Click **Embed only the characters used the presentation**.
5. Click **OK**.

Now, PowerPoint will embed only those fonts that are used in the presentation when you save the presentation.

## Resolution

To resolve this issue for presentations that are already saved, you must reduce the file size.

If you have already saved the PowerPoint 97 or PowerPoint 2000 presentation in PowerPoint 2007, in PowerPoint 2003, or in PowerPoint 2002, the file size has already increased. To reduce the file size, follow these steps, as appropriate for the version of PowerPoint that you are running.

### PowerPoint 2003 or PowerPoint 2002

1. Open the presentation.
2. On the **Tools** menu, click **Options**.
3. Click the **Save** tab.
4. Under the **Embed TrueType fonts** check box, click **Embed characters that are used only**.
5. Click **OK**.
6. Save the presentation.
7. In Windows Explorer, verify that the file size has decreased.

### PowerPoint 2007

1. Open the presentation.
2. Click the **Microsoft Office Button** ![Microsoft Office Button](./media/presentation-file-size-increases/office-button.png), and then click **PowerPoint Options**.
3. Click **Save**, and then click to select the **Embed fonts in the file** check box.
4. Click **Embed only the characters used the presentation**.
5. Click **OK**.
6. Save the presentation.
7. In Windows Explorer, verify that the file size has decreased.

If the file size did not change, try saving the presentation one more time.

If the file size still does not change, you must save a new copy of the presentation. To do this, click **Save As** on the **File** menu, and then rename the presentation.

If the file size still does not change, turn off font embedding for that presentation. After you turn off font embedding, save a new copy of the presentation.

> [!NOTE]
> The fonts will be replaced with the nearest equivalent font that is present on the computer if you do not have the same fonts on the computer.

To determine what fonts are used in the presentation, follow these steps:

1. Open the original presentation.
2. On the **File** menu, click **Properties**.
3. Click the **Contents** tab, and then note the fonts that are listed in the **Fonts in use** list.
4. Click **Start**, click **Run**, type control fonts in the **Open** box, and then click **OK**.
5. Compare the fonts in the Fonts folder to the fonts that you noted in step 3.

## More Information

In PowerPoint 2002 and in later versions of PowerPoint, you can embed a subset of a font by using the **Embed characters in use only** option. This option is saved with the presentation. When you save the presentation, PowerPoint 2002, PowerPoint 2003, or PowerPoint 2007 will embed the complete font set into the presentation.

For more information about how to embed fonts in PowerPoint presentations, see the following article:

[Embed fonts in Word or PowerPoint](https://support.office.com/article/embed-fonts-in-word-or-powerpoint-cb3982aa-ea76-4323-b008-86670f222dbc?ui=en-US&rs=en-US&ad=US
)