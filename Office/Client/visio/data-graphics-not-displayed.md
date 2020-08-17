---
title: Data graphics are not displayed when you try to apply data graphics to images or objects in your Visio 2007 or Visio 2010 drawing
description: Describes behavior that occurs in Visio 2007 and Visio 2010 in which data graphics are not displayed when you try to apply data graphics to images or objects in your drawing. Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: troubleshoot
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Visio Premium 2010
- Visio Professional 2010
- Visio Standard 2010
- Microsoft Office Visio Professional 2007
ms.reviewer: johnlan
---
# Data graphics are not displayed or applied to images or objects in your Visio 2007 or Visio 2010 drawing

This article documents an issue in which data graphics are not displayed when you try to apply data graphics to images or objects in your drawing.

_Original KB number:_ &nbsp; 923596

## Symptoms

While applying a data graphic to the image or to the object in a Microsoft Visio 2007 or 2010 drawing, the data graphic is not displayed. You might experience this issue if you try to apply a data graphic to any one of the following image file formats or objects:

- Tag Image File Format (.tif)
- Graphics Image File Format (.gif)
- JPEG File Interchange Format (.jpg)
- Portable Network Graphics (.png)
- Windows Bitmaps (.bmp, .dib)
- Enhanced Meta File Formats (.emf, .emz)
- Windows Meta File Format (.wmf)
- AutoCAD drawings (.dwg, .dxf)
- Object Linking and Embedding (OLE) objects

## Cause

This behavior occurs because you cannot apply data graphics to images or to objects in Visio 2007 and Visio 2010. This behavior is by design in Visio 2007 and might trigger same behavior in Visio 2010.

## Workaround

To work around this issue, follow these steps:

1. Group the image or object together with one or more shapes in your drawing. To do this, select the shapes and the image or the object that you want to group, point to **Grouping** on the **Shape** menu, and then select **Group**.
1. Add data to the group. To do this, use one of the following procedures:
   - Define shape data for the group. To do this, follow these steps:
     1. Select the group, and then select **Shape Data** on the **Data** menu.
     1. When you are prompted to confirm whether you want to define shape data, select **Yes**.
     1. In the **Define Shape Data** dialog box, specify the shape data that you want, and then select **OK**.
   - Link data to the group. To do this, follow these steps:
     1. Select the group, and then select **Link Data to Shapes** on the **Data** menu.
     1. Follow the instructions in the Data Selector Wizard.
1. Apply the data graphic to the group. To do this, select **Display Data on Shapes** on the **Data** menu, and then apply the data graphic that you want.

## Further Advisory

Updates to Office installation:

1. For Office 2007, it is recommended to download and install the latest service pack (SP3) through    Windows update.
1. For Office 2010, you can download and install the latest service pack through Windows Update or use the Official Microsoft website.

## More information

You can apply data graphics to shapes in a drawing to show the data about the shapes. For more information about how to work with data graphics in Visio 2007, see Visio 2007 Help. To do this, select **Microsoft Office Visio Help** on the **Help** menu, type data graphics in the **Type words to search for** box, and then select **Search** to view a list of relevant topics.
