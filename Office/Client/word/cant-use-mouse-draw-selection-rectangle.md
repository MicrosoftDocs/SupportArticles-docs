---
title: Can't use  mouse to draw selection rectangle around multiple Auto Shape objects
description: Describes an issue in Word 2010 in which you can't use the mouse to draw a selection rectangle around multiple Auto Shape objects.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: wdkbprem, ctrword
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Insert
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Word 2016
  - Word 2013
  - Microsoft Word 2010
ms.date: 06/06/2024
---

# You can't use the mouse to draw a selection rectangle around multiple AutoShape objects in Microsoft Word

## Symptoms

If a Microsoft Word 2010 or later document contains multiple `AutoShape` objects that are near one another, you can't use the mouse to draw a selection rectangle around the objects.

## Resolution

To resolve this issue, use one of the following methods. 

### Method 1: Insert a drawing canvas before you insert any objects

If you always want the drawing canvas to appear when you insert `AutoShape` objects, follow these steps:

1. On the **File** Menu, select **Options**.
2. Select **Advanced**.   
3. Under **Editing options**, select the **Automatically create drawing canvas when inserting `AutoShapes`** check box.   
4. Select **OK**.   

### Method 2: Add a button to the Quick Access Toolbar

If you don't want the drawing canvas to be created automatically, you can add a button to the Quick Access Toolbar (QAT) to create the drawing canvas manually. To do so, follow these steps:

1. On the **Quick Access Toolbar** drop-down menu, select **More Commands**.   
2. Select the drop-down menu under **Choose commands from**, and then select **Commands Not in the Ribbon**.   
3. Scroll through the list, select **Insert Drawing**, then select **Add**.   
4. Select **OK**.

The **Insert Drawing** command is now added to the Quick Access Toolbar.

### Method 3: Use the Ctrl key together with the mouse to select multiple `AutoShape` objects

1. Select an `AutoShape` object.
2. Press the Ctrl key.
3. Select other `AutoShape` objects while you continue to press the Ctrl key.   

### Method 4: Use the Selection Pane

1. Select an `AutoShape` object in your document.   
2. On the **Drawing Tools** menu, select **Format**.   
3. On the **Arrange** group, select **Selection Pane**.

The Selection Pane appears. The Selection Pane lets you select multiple `AutoShape` objects by using the steps in Method 3.

### Method 5: In Word 2016 and Word 2013, use Select Objects

1. On the Home tab, select **Select** > **Select Objects**.
2. Use the mouse to draw a selection rectangle around the shapes.
