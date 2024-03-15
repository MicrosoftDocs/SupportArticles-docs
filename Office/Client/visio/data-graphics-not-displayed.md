---
title: Data graphics are not displayed when you try to apply data graphics to images or objects in your Visio 2007 or Visio 2010 drawing
description: Describes behavior that occurs in Visio 2007 and Visio 2010 in which data graphics are not displayed when you try to apply data graphics to images or objects in your drawing. Provides a workaround.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Visio Premium 2010
  - Visio Professional 2010
  - Visio Standard 2010
  - Microsoft Office Visio Professional 2007
ms.reviewer: johnlan
ms.date: 03/31/2022
---
# Data graphics applied to images or objects are not displayed in Visio 2010 and Visio 2007

## Symptoms

When you apply a data graphic to an image or object in a Microsoft Visio 2010 or 2007 drawing, the data graphic is not displayed. You might experience this issue if you try to apply a data graphic to any of the following image file formats or objects:

- Tag Image File (.tif)
- Graphics Image File (.gif)
- JPEG File Interchange (.jpg)
- Portable Network Graphics (.png)
- Windows Bitmaps (.bmp, .dib)
- Enhanced Meta File (.emf, .emz)
- Windows Meta File (.wmf)
- AutoCAD drawing (.dwg, .dxf)
- Object Linking and Embedding (OLE) objects

## Cause

This behavior occurs because you cannot apply data graphics to images or objects in Visio 2010 and Visio 2007. This behavior is by design in Visio 2007 and can also occur in Visio 2010.

## Workaround

To work around this behavior, follow these steps:

1.	Group the image or object together with one or more shapes in your drawing. To do this, select the shapes and the image or object that you want to group, point to **Grouping** on the **Shape** menu, and then select **Group**.
2.	Add data to the group. To do this, use one of the following methods:
    - Define shape data for the group. To do this, follow these steps:
        1.	Select the group, and then select **Shape Data** on the **Data** menu.
        2.	When you are prompted to confirm whether you want to define shape data, select **Yes**.
        3.	In the **Define Shape Data** dialog box, specify the shape data that you want, and then select **OK**.
    - Link data to the group. To do this, follow these steps:
        1.	Select the group, and then select **Link Data to Shapes** on the **Data** menu.
        2.	Follow the instructions in the Data Selector Wizard.
3.	Apply the data graphic to the group. 
    - To do this, select **Display Data on Shapes** on the **Data** menu, and then apply the data graphic that you want.

### Updates to Office installation

1.	For Office 2010, you can download and install the latest service pack through Windows Update or at the [Microsoft Download Center](https://www.microsoft.com/download/details.aspx?id=39667).
2.	For Office 2007, we recommended that you download and install the latest service pack (SP3) through Windows Update.

## More information

You can apply data graphics to shapes in a drawing to show data about the shapes. For more information about how to work with data graphics in Visio 2007, select **Microsoft Office Visio Help** on the **Help** menu, type **data graphics** in the **Type words to search for** box, and then select **Search** to view a list of relevant topics.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
