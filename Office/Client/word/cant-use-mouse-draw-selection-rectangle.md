---
title: Cannot use  mouse to draw selection rectangle around multiple AutoShape objects
description: Describes an issue in Word 2010 in which you cannot use the mouse to draw a selection rectangle around multiple AutoShape objects.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: wdkbprem, ctrword
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Word 2016
  - Word 2013
  - Microsoft Word 2010
ms.date: 03/31/2022
---

# You cannot use the mouse to draw a selection rectangle around multiple AutoShape objects in Microsoft Word

## Symptoms

If a Microsoft Word 2010 or later document contains multiple AutoShape objects that are near one another, you cannot use the mouse to draw a selection rectangle around the objects.

## Resolution

To resolve this issue, use one of the following methods. 

### Method 1: Insert a drawing canvas before you insert any objects

If you always want the drawing canvas to appear when you insert AutoShape objects, follow these steps:

1. On the **File** Menu, click **Options**.   
2. Click **Advanced**.   
3. Under **Editing options**, click to select the **Automatically create drawing canvas when inserting AutoShapes** check box.   
4. Click **OK**.   

### Method 2: Add a button to the Quick Access Toolbar
If you do not want the drawing canvas to be created automatically, you can add a button to the Quick Access Toolbar (QAT) to create the drawing canvas manually. To do this, follow these steps:

1. On the **Quick Access Toolbar** drop-down menu, click **More Commands**.   
2. Click the drop-down menu under **Choose commands from**, and then click **Commands Not in the Ribbon**.   
3. Scroll through the list, click to select **Insert Drawing**, then click **Add**.   
4. Click **OK**.

The **Insert Drawing** command is now added to the Quick Access Toolbar.

### Method 3: Use the Ctrl key together with the mouse to select multiple AutoShape objects


1. Click an AutoShape object.   
2. Press the Ctrl key.   
3. Click other AutoShape objects while you continue to press the Ctrl key.   

### Method 4: Use the Selection Pane


1. Click an AutoShape object in your document.   
2. On the **Drawing Tools** menu, click **Format**.   
3. On the **Arrange** group, click **Selection Pane**.

The Selection Pane appears. The Selection Pane lets you select multiple AutoShape objects by using the steps in Method 3.

### Method 5: In Word 2016 and Word 2013, use Select Objects


1. On the Home tab, click Select and then click Select Objects.   
2. Use the mouse to draw a selection rectangle around the shapes.    
