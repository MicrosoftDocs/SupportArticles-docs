---
title: A connector does not move when you move a shape in Microsoft Word
description: Describes a behavior in Word 2010 where a connector does not move when you move a shape. To resolve this behavior, you must insert the shapes and connector in a new drawing canvas.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Insert
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Word for Microsoft 365
  - Word 2019
  - Word 2016
  - Word 2013
  - Word 2010
ms.date: 06/06/2024
---

# A connector does not move when you move a shape in Microsoft Word

## Symptoms

Consider the following scenario:

- In a Microsoft Word document, you insert several shapes.   
- You insert a connector to link two of the shapes.   
- You select one of the shapes, and you move the shape to a different location.   

In this scenario, the connector does not move with the shape.

## Cause

This behavior occurs because the connector is not connected to the shape.

##  Resolution

To resolve this behavior, insert the shapes and connector in a new drawing canvas. When the shapes and connector are inserted in a new drawing canvas, the connector is connected to the shape. And, the connector remains connected to the shape when you move the shape.

To insert a new drawing canvas, on the **Insert** tab, click **Shapes** in the **Illustrations** group, and then click **New Drawing Canvas**. Then, insert the shapes and connector that you want.

## More Information

For more information about how to draw shapes and connectors, visit the following Microsoft website: [Draw or delete a line or connector](https://office.microsoft.com/word-help/draw-or-delete-a-line-connector-or-freeform-shape-ha010355850.aspx)
