---
title: Cannot edit text in print preview in Word
description: Resolves an issue in which you cannot use Edit mode in print preview in Word 2013 and Word 2013.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Word for Office 365
- Word 2019
- Word 2016
- Word 2013
- Word 2010
---

# Cannot edit text in print preview in Microsoft Word

## Symptoms

In Microsoft Word 2010 and later, you cannot edit text in print preview. This is because Edit mode does not work in print preview. Edit mode lets you edit the print preview without returning to the document.

## Resolution

To resolve this issue, use the Print Preview Edit Mode feature instead of print preview. To do this, use one of the following methods:

### Method 1: Add the Print Preview Edit Mode feature to the Quick Access Toolbar 

1. On the **File** menu, click **Options**.   
2. Click **Quick Access Toolbar**, and then click **All Commands** in the **Choose commands from** drop-down list.   
3. Click **Print Preview Edit Mode**, and then click **Add**.   
4. Click **OK**.   

### Method 2: Add the Print Preview Edit Mode feature by customizing a ribbon

1. On the **File** menu, click **Options**.   
2. Click **Customize Ribbon**, and then click **All Commands** in the **Choose commands from** drop-down list.   
3. Click **Print Preview Edit Mode**, and then click **Add**.   
4. Click **OK**.

Developers can add the PrintPreviewEditMode control to a custom ribbon. Or, developers can make a custom control to run the Print Preview Edit Mode feature through the OnAction callback method of the control.
